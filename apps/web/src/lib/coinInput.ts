import type { InputNumberProps } from 'antd'

export const coinFormatter: InputNumberProps['formatter'] = (value) =>
  String(value ?? '').replace(/\B(?=(\d{3})+(?!\d))/g, ',')

export const coinParser: InputNumberProps['parser'] = (value) => {
  const normalized = (value ?? '').replace(/[^\w.-]+/g, '')
  return normalized === '' ? '' : Number(normalized)
}
