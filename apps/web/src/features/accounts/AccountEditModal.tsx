import type {
  AccountDetailResponse,
  UpdateAccountRequest,
} from '@atgm/contracts'
import type { FormProps } from 'antd'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { Alert, Form, InputNumber, message, Modal, Select } from 'antd'
import { useEffect, useMemo } from 'react'
import { AccountNotFoundError, updateAccount } from './accounts-api'
import { accountQueryKeys, privilegesQueryOptions } from './accounts-queries'

interface AccountEditModalProps {
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

export const AccountEditModal: React.FC<AccountEditModalProps> = ({
  account,
  open,
  onCancel,
}) => {
  const [form] = Form.useForm<UpdateAccountRequest>()
  const [messageApi, messageContext] = message.useMessage()
  const queryClient = useQueryClient()
  const privilegesQuery = useQuery({
    ...privilegesQueryOptions(),
    enabled: open,
  })
  const privilegeOptions = useMemo(() => {
    const options = (privilegesQuery.data ?? []).map((privilege) => ({
      label:
        privilege.grant && privilege.constant
          ? `${privilege.privilege} - ${privilege.grant} - ${privilege.constant}(${privilege.description})`
          : `${privilege.privilege} - ${privilege.description}`,
      value: privilege.privilege,
    }))

    if (!options.some((option) => option.value === account.privilege)) {
      options.unshift({
        label: `${account.privilege} - 未知权限`,
        value: account.privilege,
      })
    }

    return options
  }, [account.privilege, privilegesQuery.data])
  const updateMutation = useMutation({
    mutationFn: (values: UpdateAccountRequest) =>
      updateAccount(account.account, values),
    onSuccess: () => {
      void queryClient
        .invalidateQueries({
          queryKey: accountQueryKeys.detail(account.account),
        })
        .catch(() => undefined)
      void queryClient
        .invalidateQueries({ queryKey: accountQueryKeys.all })
        .catch(() => undefined)
      void messageApi.success('账号修改成功')
      onCancel()
    },
    onError: (error) => {
      if (error instanceof AccountNotFoundError) {
        void messageApi.error('账号不存在')
        return
      }

      if (error instanceof Error) {
        void messageApi.error(error.message)
        return
      }

      void messageApi.error('账号修改失败，请稍后重试')
    },
  })

  useEffect(() => {
    if (!open) return

    form.setFieldsValue({
      privilege: account.privilege,
      goldCoin: account.goldCoin,
      silverCoin: account.silverCoin,
    })
  }, [account.goldCoin, account.privilege, account.silverCoin, form, open])

  const handleCancel = () => {
    if (updateMutation.isPending) return

    form.resetFields()
    updateMutation.reset()
    onCancel()
  }

  const handleFinish: FormProps<UpdateAccountRequest>['onFinish'] = (
    values,
  ) => {
    if (privilegesQuery.isSuccess && !updateMutation.isPending) {
      updateMutation.mutate(values)
    }
  }

  const saveDisabled = !privilegesQuery.isSuccess || updateMutation.isPending

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
          'aria-label': '保存',
          disabled: saveDisabled,
        }}
        okText="保存"
        onCancel={handleCancel}
        onOk={() => {
          if (!updateMutation.isPending) form.submit()
        }}
        open={open}
        title={`编辑账号：${account.account}`}
      >
        {privilegesQuery.isError && (
          <Alert
            className="mb-4"
            showIcon
            title="权限列表加载失败"
            type="error"
          />
        )}

        <Form<UpdateAccountRequest>
          form={form}
          layout="vertical"
          onFinish={handleFinish}
        >
          <Form.Item
            label="权限"
            name="privilege"
            rules={[{ required: true, message: '请选择权限' }]}
          >
            <Select
              disabled={privilegesQuery.isPending || privilegesQuery.isError}
              loading={privilegesQuery.isPending}
              options={privilegeOptions}
              placeholder="请选择权限"
            />
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
        </Form>
      </Modal>
    </>
  )
}
