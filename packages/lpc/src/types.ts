export type LpcValue = string | number | LpcArray | LpcMapping | LpcSpecialValue
export type LpcArray = LpcValue[]
export type LpcMappingKey = string | number
export type LpcMapping = Map<LpcMappingKey, LpcValue>
export interface LpcSpecialValue {
  type: 'special'
  value: string
}
