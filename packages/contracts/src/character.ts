import { z } from 'zod'
import { paginatedResponseSchema, paginationQuerySchema } from './pagination'

export const CHARACTER_POLAR_LABELS = {
  1: '金',
  2: '木',
  3: '水',
  4: '火',
  5: '土',
} as const

export const CHARACTER_GENDER_LABELS = {
  1: '男',
  2: '女',
} as const

export const charactersQuerySchema = paginationQuerySchema

export type CharactersQuery = z.infer<typeof charactersQuerySchema>

export const characterListItemSchema = z.object({
  gid: z.string(),
  name: z.string(),
  polar: z.number().int(),
  gender: z.number().int(),
  time: z.string(),
})

export type CharacterListItem = z.infer<typeof characterListItemSchema>

export const characterWithAccountSchema = characterListItemSchema.extend({
  account: z.string().nullable(),
})

export type CharacterWithAccount = z.infer<typeof characterWithAccountSchema>

export const charactersResponseSchema = paginatedResponseSchema(
  characterWithAccountSchema,
)

export type CharactersResponse = z.infer<typeof charactersResponseSchema>

export const characterDetailParamsSchema = z.object({
  gid: z.string().min(1),
})

export type CharacterDetailParams = z.infer<typeof characterDetailParamsSchema>

export const characterDetailResponseSchema = z.object({
  basicInfo: z.object({
    gid: z.string(),
    name: z.string().nullable(),
    account: z.string().nullable(),
    level: z.number().nullable(),
    polar: z.number().int().nullable(),
    gender: z.number().int().nullable(),
    createTime: z.string().nullable(),
  }),
  sectInfo: z.object({
    family: z.string().nullable(),
    master: z.string().nullable(),
    title: z.string().nullable(),
  }),
  attributes: z.object({
    strength: z.number().nullable(),
    constitution: z.number().nullable(),
    dexterity: z.number().nullable(),
    wiz: z.number().nullable(),
  }),
  combat: z.object({
    life: z.number().nullable(),
    maxLife: z.number().nullable(),
    mana: z.number().nullable(),
    maxMana: z.number().nullable(),
    speed: z.number().nullable(),
    defense: z.number().nullable(),
    physicalPower: z.number().nullable(),
    magPower: z.number().nullable(),
  }),
  cultivation: z.object({
    experience: z.number().nullable(),
    experienceToNextLevel: z.number().nullable(),
    tao: z.number().nullable(),
    potential: z.number().nullable(),
  }),
  assets: z.object({
    cash: z.number().nullable(),
    goldCoin: z.number().nullable(),
    silverCoin: z.number().nullable(),
    voucher: z.number().nullable(),
  }),
})

export type CharacterDetailResponse = z.infer<
  typeof characterDetailResponseSchema
>

export const characterItemSchema = z.object({
  entryKey: z.number(),
  name: z.string().min(1),
  alias: z.string().nullable(),
})

export type CharacterItem = z.infer<typeof characterItemSchema>

export const characterItemsResponseSchema = z.object({
  branchExists: z.boolean(),
  items: z.array(characterItemSchema),
})

export type CharacterItemsResponse = z.infer<
  typeof characterItemsResponseSchema
>
