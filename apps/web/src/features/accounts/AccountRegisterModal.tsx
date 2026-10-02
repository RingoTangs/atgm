import type { RegisterAccountRequest } from '@atgm/contracts'
import type { FormProps } from 'antd'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import {
  Alert,
  Button,
  Form,
  Input,
  InputNumber,
  message,
  Modal,
  Select,
} from 'antd'
import { AccountConflictError, registerAccount } from './accounts-api'
import { accountQueryKeys, privilegesQueryOptions } from './accounts-queries'

interface AccountRegisterModalProps {
  open: boolean
  onCancel: () => void
}

const COIN_MIN = 0
const COIN_MAX = 2_000_000_000

const initialValues: Pick<RegisterAccountRequest, 'goldCoin' | 'silverCoin'> = {
  goldCoin: COIN_MIN,
  silverCoin: COIN_MIN,
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
  const privilegesQuery = useQuery({
    ...privilegesQueryOptions(),
    enabled: open,
  })
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
      if (error instanceof AccountConflictError) {
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
    if (privilegesQuery.isSuccess && !registerMutation.isPending) {
      registerMutation.mutate(values)
    }
  }

  const registrationDisabled =
    !privilegesQuery.isSuccess || registerMutation.isPending

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
        {privilegesQuery.isError && (
          <Alert
            className="mb-4"
            showIcon
            title="权限列表加载失败"
            type="error"
          />
        )}

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

          <Form.Item
            extra={
              <div className="flex gap-2">
                <Button
                  size="small"
                  type="link"
                  onClick={() => form.setFieldValue('goldCoin', COIN_MIN)}
                >
                  最小值
                </Button>
                <Button
                  size="small"
                  type="link"
                  onClick={() => form.setFieldValue('goldCoin', COIN_MAX)}
                >
                  最大值
                </Button>
              </div>
            }
            label="金币"
            name="goldCoin"
            rules={[integerRangeValidator('金币', COIN_MIN, COIN_MAX)]}
          >
            <InputNumber
              className="w-full"
              max={COIN_MAX}
              min={COIN_MIN}
              precision={0}
              step={1}
            />
          </Form.Item>

          <Form.Item
            extra={
              <div className="flex gap-2">
                <Button
                  size="small"
                  type="link"
                  onClick={() => form.setFieldValue('silverCoin', COIN_MIN)}
                >
                  最小值
                </Button>
                <Button
                  size="small"
                  type="link"
                  onClick={() => form.setFieldValue('silverCoin', COIN_MAX)}
                >
                  最大值
                </Button>
              </div>
            }
            label="银币"
            name="silverCoin"
            rules={[integerRangeValidator('银币', COIN_MIN, COIN_MAX)]}
          >
            <InputNumber
              className="w-full"
              max={COIN_MAX}
              min={COIN_MIN}
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
              disabled={privilegesQuery.isPending || privilegesQuery.isError}
              loading={privilegesQuery.isPending}
              options={(privilegesQuery.data ?? []).map((privilege) => ({
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
