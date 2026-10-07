import type {
  AccountDetailResponse,
  RechargeAccountRequest,
} from '@atgm/contracts'
import type { FormProps } from 'antd'
import { ACCOUNT_COIN_MAX, ACCOUNT_COIN_MIN, errorCodes } from '@atgm/contracts'
import { useMutation, useQueryClient } from '@tanstack/react-query'
import { Button, Form, InputNumber, message, Modal } from 'antd'
import { useEffect } from 'react'
import { ApiError } from '@/lib/apiError'
import { coinFormatter, coinParser } from '@/lib/coinInput'
import { rechargeAccount } from './accounts-api'
import { accountQueryKeys } from './accounts-queries'

interface AccountRechargeModalProps {
  account: AccountDetailResponse
  open: boolean
  onCancel: () => void
}

const integerRangeValidator = (label: string, min: number, max: number) => ({
  validator: (_rule: unknown, value: number | null | undefined) => {
    if (value === null || value === undefined) {
      return Promise.reject(new Error(`请输入${label}`))
    }

    if (!Number.isInteger(value) || value < min || value > max) {
      return Promise.reject(
        new Error(
          `${label}必须是 ${min.toLocaleString()}～${max.toLocaleString()} 的整数`,
        ),
      )
    }

    return Promise.resolve()
  },
})

export const AccountRechargeModal: React.FC<AccountRechargeModalProps> = ({
  account,
  open,
  onCancel,
}) => {
  const [form] = Form.useForm<RechargeAccountRequest>()
  const [messageApi, messageContext] = message.useMessage()
  const queryClient = useQueryClient()
  const maxGoldCoinAmount = ACCOUNT_COIN_MAX - account.goldCoin
  const maxSilverCoinAmount = ACCOUNT_COIN_MAX - account.silverCoin
  const updateMutation = useMutation({
    mutationFn: (values: RechargeAccountRequest) =>
      rechargeAccount(account.account, values),
    onSuccess: () => {
      void queryClient
        .invalidateQueries({
          queryKey: accountQueryKeys.detail(account.account),
        })
        .catch(() => undefined)
      void queryClient
        .invalidateQueries({ queryKey: accountQueryKeys.all })
        .catch(() => undefined)
      void messageApi.success('充值成功')
      onCancel()
    },
    onError: (error) => {
      if (
        error instanceof ApiError &&
        error.code === errorCodes.ACCOUNT_NOT_FOUND
      ) {
        void messageApi.error(error.message)
        return
      }

      if (error instanceof Error) {
        void messageApi.error(error.message)
        return
      }

      void messageApi.error('充值失败，请稍后重试')
    },
  })

  useEffect(() => {
    if (!open) return

    form.setFieldsValue({
      goldCoinAmount: ACCOUNT_COIN_MIN,
      silverCoinAmount: ACCOUNT_COIN_MIN,
    })
  }, [account.account, form, open])

  const handleCancel = () => {
    if (updateMutation.isPending) return

    form.resetFields()
    updateMutation.reset()
    onCancel()
  }

  const handleFinish: FormProps<RechargeAccountRequest>['onFinish'] = (
    values,
  ) => {
    if (!updateMutation.isPending) {
      updateMutation.mutate(values)
    }
  }

  const saveDisabled = updateMutation.isPending

  return (
    <>
      {messageContext}
      <Modal
        afterClose={() => {
          form.resetFields()
          updateMutation.reset()
        }}
        cancelButtonProps={{
          'aria-label': '取消',
          disabled: updateMutation.isPending,
        }}
        cancelText="取消"
        closable={!updateMutation.isPending}
        confirmLoading={updateMutation.isPending}
        mask={{ closable: !updateMutation.isPending }}
        okButtonProps={{
          'aria-label': '充值',
          disabled: saveDisabled,
        }}
        okText="充值"
        onCancel={handleCancel}
        onOk={() => {
          if (!updateMutation.isPending) form.submit()
        }}
        open={open}
        title={`充值账号：${account.account}`}
      >
        <p className="text-muted-foreground pb-2">
          当前金元宝：{account.goldCoin.toLocaleString()}，当前银元宝：
          {account.silverCoin.toLocaleString()}
        </p>

        <Form<RechargeAccountRequest>
          form={form}
          layout="vertical"
          onFinish={handleFinish}
        >
          <div className="mb-2 flex items-center justify-between">
            <label htmlFor="goldCoinAmount">金元宝充值数量</label>
            <div className="flex gap-1">
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() =>
                  form.setFieldValue('goldCoinAmount', ACCOUNT_COIN_MIN)
                }
              >
                最小
              </Button>
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() =>
                  form.setFieldValue('goldCoinAmount', maxGoldCoinAmount)
                }
              >
                最大
              </Button>
            </div>
          </div>
          <Form.Item
            name="goldCoinAmount"
            rules={[
              integerRangeValidator(
                '金元宝充值数量',
                ACCOUNT_COIN_MIN,
                maxGoldCoinAmount,
              ),
            ]}
          >
            <InputNumber
              className="w-full"
              id="goldCoinAmount"
              min={ACCOUNT_COIN_MIN}
              max={maxGoldCoinAmount}
              formatter={coinFormatter}
              parser={coinParser}
              step={1}
            />
          </Form.Item>

          <div className="mb-2 flex items-center justify-between">
            <label htmlFor="silverCoinAmount">银元宝充值数量</label>
            <div className="flex gap-1">
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() =>
                  form.setFieldValue('silverCoinAmount', ACCOUNT_COIN_MIN)
                }
              >
                最小
              </Button>
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() =>
                  form.setFieldValue('silverCoinAmount', maxSilverCoinAmount)
                }
              >
                最大
              </Button>
            </div>
          </div>
          <Form.Item
            name="silverCoinAmount"
            dependencies={['goldCoinAmount']}
            rules={[
              integerRangeValidator(
                '银元宝充值数量',
                ACCOUNT_COIN_MIN,
                maxSilverCoinAmount,
              ),
              ({ getFieldValue }) => ({
                validator: (_rule, value: number | null | undefined) =>
                  value === 0 && getFieldValue('goldCoinAmount') === 0
                    ? Promise.reject(
                        new Error('金元宝和银元宝充值数量不能同时为 0'),
                      )
                    : Promise.resolve(),
              }),
            ]}
          >
            <InputNumber
              className="w-full"
              id="silverCoinAmount"
              min={ACCOUNT_COIN_MIN}
              max={maxSilverCoinAmount}
              formatter={coinFormatter}
              parser={coinParser}
              step={1}
            />
          </Form.Item>
        </Form>
      </Modal>
    </>
  )
}
