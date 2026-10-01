import type { FormProps } from 'antd'
import { Form, Input, InputNumber, Modal } from 'antd'

export interface RegisterAccountValues {
  account: string
  rawPassword: string
  goldCoin: number
  silverCoin: number
  privilege: number
}

interface AccountRegisterModalProps {
  open: boolean
  existingAccounts: string[]
  onCancel: () => void
  onRegister: (values: RegisterAccountValues) => void
}

const initialValues: Pick<
  RegisterAccountValues,
  'goldCoin' | 'silverCoin' | 'privilege'
> = {
  goldCoin: 0,
  silverCoin: 0,
  privilege: 0,
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
  existingAccounts,
  onCancel,
  onRegister,
}) => {
  const [form] = Form.useForm<RegisterAccountValues>()

  const handleCancel = () => {
    form.resetFields()
    onCancel()
  }

  const handleFinish: FormProps<RegisterAccountValues>['onFinish'] = (
    values,
  ) => {
    onRegister(values)
    form.resetFields()
  }

  return (
    <Modal
      afterClose={() => form.resetFields()}
      cancelButtonProps={{ 'aria-label': '取消' }}
      cancelText="取消"
      okButtonProps={{ 'aria-label': '注册' }}
      okText="注册"
      onCancel={handleCancel}
      onOk={() => form.submit()}
      open={open}
      title="注册账号"
    >
      <Form<RegisterAccountValues>
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
            {
              validator: (_rule, value: string | undefined) => {
                if (
                  value &&
                  existingAccounts.some(
                    (account) => account.toLowerCase() === value.toLowerCase(),
                  )
                ) {
                  return Promise.reject(new Error('账号已存在'))
                }

                return Promise.resolve()
              },
            },
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
          label="金币"
          name="goldCoin"
          rules={[integerRangeValidator('金币', 0, 2_000_000_000)]}
        >
          <InputNumber className="w-full" step={1} />
        </Form.Item>

        <Form.Item
          label="银币"
          name="silverCoin"
          rules={[integerRangeValidator('银币', 0, 2_000_000_000)]}
        >
          <InputNumber className="w-full" step={1} />
        </Form.Item>

        <Form.Item
          label="权限"
          name="privilege"
          rules={[integerRangeValidator('权限', 0, 1000)]}
        >
          <InputNumber className="w-full" step={1} />
        </Form.Item>
      </Form>
    </Modal>
  )
}
