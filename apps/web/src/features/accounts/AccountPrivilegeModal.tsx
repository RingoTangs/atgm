import type {
  AccountDetailResponse,
  UpdateAccountPrivilegeRequest,
} from '@atgm/contracts'
import type { FormProps } from 'antd'
import { errorCodes } from '@atgm/contracts'
import { useMutation, useQuery, useQueryClient } from '@tanstack/react-query'
import { Alert, Form, message, Modal, Select } from 'antd'
import { useEffect, useMemo } from 'react'
import { ApiError } from '@/lib/apiError'
import { updateAccountPrivilege } from './accounts-api'
import { accountQueryKeys, privilegesQueryOptions } from './accounts-queries'

interface AccountPrivilegeModalProps {
  account: AccountDetailResponse
  open: boolean
  onCancel: () => void
}

export const AccountPrivilegeModal: React.FC<AccountPrivilegeModalProps> = ({
  account,
  open,
  onCancel,
}) => {
  const [form] = Form.useForm<UpdateAccountPrivilegeRequest>()
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
    mutationFn: (values: UpdateAccountPrivilegeRequest) =>
      updateAccountPrivilege(account.account, values),
    onSuccess: () => {
      void queryClient
        .invalidateQueries({
          queryKey: accountQueryKeys.detail(account.account),
        })
        .catch(() => undefined)
      void queryClient
        .invalidateQueries({ queryKey: accountQueryKeys.all })
        .catch(() => undefined)
      void messageApi.success('权限变更成功')
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

      void messageApi.error('权限变更失败，请稍后重试')
    },
  })

  useEffect(() => {
    if (!open) return

    form.setFieldsValue({
      privilege: account.privilege,
    })
  }, [account.privilege, form, open])

  const handleCancel = () => {
    if (updateMutation.isPending) return

    form.resetFields()
    updateMutation.reset()
    onCancel()
  }

  const handleFinish: FormProps<UpdateAccountPrivilegeRequest>['onFinish'] = (
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
        title={`变更权限：${account.account}`}
      >
        {privilegesQuery.isError && (
          <Alert
            className="mb-4"
            showIcon
            title="权限列表加载失败"
            type="error"
          />
        )}

        <Form<UpdateAccountPrivilegeRequest>
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
        </Form>
      </Modal>
    </>
  )
}
