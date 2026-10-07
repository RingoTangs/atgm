import type { RegisterAccountRequest } from '@atgm/contracts'
import type { FormProps } from 'antd'
import {
  ACCOUNT_COIN_MAX,
  ACCOUNT_COIN_MIN,
  ACCOUNT_PRIVILEGES,
  errorCodes,
} from '@atgm/contracts'
import { useMutation, useQueryClient } from '@tanstack/react-query'
import { Button, Form, Input, InputNumber, message, Modal, Select } from 'antd'
import { ApiError } from '@/lib/apiError'
import { registerAccount } from './accounts-api'
import { accountQueryKeys } from './accounts-queries'

interface AccountRegisterModalProps {
  open: boolean
  onCancel: () => void
}

const initialValues: Pick<RegisterAccountRequest, 'goldCoin' | 'silverCoin'> = {
  goldCoin: ACCOUNT_COIN_MIN,
  silverCoin: ACCOUNT_COIN_MIN,
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

export const AccountRegisterModal: React.FC<AccountRegisterModalProps> = ({
  open,
  onCancel,
}) => {
  const [form] = Form.useForm<RegisterAccountRequest>()
  const [messageApi, messageContext] = message.useMessage()
  const queryClient = useQueryClient()
  const registerMutation = useMutation({
    mutationFn: registerAccount,
    onSuccess: () => {
      void queryClient
        .invalidateQueries({ queryKey: accountQueryKeys.all })
        .catch(() => undefined)
      void messageApi.success('账号注册成功')
      form.resetFields()
      registerMutation.reset()
      onCancel()
    },
    onError: (error) => {
      if (
        error instanceof ApiError &&
        error.code === errorCodes.ACCOUNT_ALREADY_EXISTS
      ) {
        form.setFields([{ name: 'account', errors: ['账号已存在'] }])
        return
      }

      void messageApi.error('账号注册失败，请稍后重试')
    },
  })

  const handleCancel = () => {
    if (registerMutation.isPending) return

    form.resetFields()
    registerMutation.reset()
    onCancel()
  }

  const handleFinish: FormProps<RegisterAccountRequest>['onFinish'] = (
    values,
  ) => {
    if (!registerMutation.isPending) {
      registerMutation.mutate(values)
    }
  }

  const registrationDisabled = registerMutation.isPending

  return (
    <>
      {messageContext}
      <Modal
        afterClose={() => {
          form.resetFields()
          registerMutation.reset()
        }}
        cancelButtonProps={{
          'aria-label': '取消',
          disabled: registerMutation.isPending,
        }}
        cancelText="取消"
        closable={!registerMutation.isPending}
        confirmLoading={registerMutation.isPending}
        mask={{ closable: !registerMutation.isPending }}
        okButtonProps={{
          'aria-label': '注册',
          disabled: registrationDisabled,
        }}
        okText="注册"
        onCancel={handleCancel}
        onOk={() => {
          if (!registerMutation.isPending) form.submit()
        }}
        open={open}
        title="注册账号"
      >
        <Form<RegisterAccountRequest>
          form={form}
          initialValues={initialValues}
          layout="vertical"
          onFinish={handleFinish}
        >
          <Form.Item
            label="账号"
            name="account"
            rules={[
              { required: true, message: '请输入账号' },
              { max: 32, message: '账号不能超过 32 个字符' },
            ]}
          >
            <Input autoComplete="off" />
          </Form.Item>

          <Form.Item
            label="密码"
            name="rawPassword"
            rules={[{ required: true, message: '请输入密码' }]}
          >
            <Input.Password autoComplete="new-password" />
          </Form.Item>

          <div className="mb-2 flex items-center justify-between">
            <label htmlFor="goldCoin">金元宝</label>
            <div className="flex gap-1">
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() => form.setFieldValue('goldCoin', ACCOUNT_COIN_MIN)}
              >
                最小
              </Button>
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() => form.setFieldValue('goldCoin', ACCOUNT_COIN_MAX)}
              >
                最大
              </Button>
            </div>
          </div>
          <Form.Item
            name="goldCoin"
            rules={[
              integerRangeValidator(
                '金元宝',
                ACCOUNT_COIN_MIN,
                ACCOUNT_COIN_MAX,
              ),
            ]}
          >
            <InputNumber
              className="w-full"
              id="goldCoin"
              max={ACCOUNT_COIN_MAX}
              min={ACCOUNT_COIN_MIN}
              precision={0}
              step={1}
            />
          </Form.Item>

          <div className="mb-2 flex items-center justify-between">
            <label htmlFor="silverCoin">银元宝</label>
            <div className="flex gap-1">
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() =>
                  form.setFieldValue('silverCoin', ACCOUNT_COIN_MIN)
                }
              >
                最小
              </Button>
              <Button
                size="small"
                type="text"
                className="text-muted-foreground"
                onClick={() =>
                  form.setFieldValue('silverCoin', ACCOUNT_COIN_MAX)
                }
              >
                最大
              </Button>
            </div>
          </div>
          <Form.Item
            name="silverCoin"
            rules={[
              integerRangeValidator(
                '银元宝',
                ACCOUNT_COIN_MIN,
                ACCOUNT_COIN_MAX,
              ),
            ]}
          >
            <InputNumber
              className="w-full"
              id="silverCoin"
              max={ACCOUNT_COIN_MAX}
              min={ACCOUNT_COIN_MIN}
              precision={0}
              step={1}
            />
          </Form.Item>

          <Form.Item
            label="权限"
            name="privilege"
            rules={[{ required: true, message: '请选择权限' }]}
          >
            <Select
              options={ACCOUNT_PRIVILEGES.map((privilege) => ({
                label:
                  privilege.grant && privilege.constant
                    ? `${privilege.privilege} - ${privilege.grant} - ${privilege.constant}(${privilege.description})`
                    : `${privilege.privilege} - ${privilege.description}`,
                value: privilege.privilege,
              }))}
              placeholder="请选择权限"
            />
          </Form.Item>
        </Form>
      </Modal>
    </>
  )
}
