import type { FastifyInstance } from 'fastify'
import type { ZodTypeProvider } from 'fastify-type-provider-zod'
import {
  characterDetailParamsSchema,
  characterDetailResponseSchema,
  characterItemDetailParamsSchema,
  characterItemDetailResponseSchema,
  characterItemsResponseSchema,
  charactersQuerySchema,
  charactersResponseSchema,
  errorCodes,
  errorSchema,
} from '@atgm/contracts'
import { LpcParseError } from '@atgm/lpc'
import {
  CharacterCarryError,
  parseCharacterCarry,
  parseCharacterCarryItem,
} from '../lib/character-carry'
import {
  readCharacterMe,
  readCharacterNumber,
  readCharacterString,
} from '../lib/character-data'
import { formatDisplayTime } from '../lib/game-time'

export async function characterRoutes(app: FastifyInstance) {
  app.withTypeProvider<ZodTypeProvider>().get(
    '/characters/:gid/items/:entryKey',
    {
      schema: {
        tags: ['Character'],
        summary: '查询角色物品详情',
        params: characterItemDetailParamsSchema,
        response: {
          200: characterItemDetailResponseSchema,
          400: errorSchema,
          404: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request, reply) => {
      const { gid, entryKey } = request.params
      try {
        const character = await app.db.ddb
          .selectFrom('basic_char_info')
          .select('gid')
          .where('gid', '=', gid)
          .executeTakeFirst()
        if (!character)
          return reply.code(404).send({
            code: errorCodes.CHARACTER_NOT_FOUND,
            message: '角色不存在',
          })
        const row = await app.db.ddb
          .selectFrom('data')
          .select('content')
          .where('path', '=', 'user')
          .where('name', '=', gid)
          .where('branch', '=', 'carry')
          .executeTakeFirst()
        const item = row ? parseCharacterCarryItem(row.content, entryKey) : null
        if (!item)
          return reply.code(404).send({
            code: errorCodes.CHARACTER_ITEM_NOT_FOUND,
            message: '物品不存在',
          })
        return item
      } catch (cause) {
        request.log.error(
          {
            gid,
            entryKey,
            reason:
              cause instanceof CharacterCarryError
                ? cause.message
                : 'Item detail query failed',
          },
          'Invalid character carry item data',
        )
        return reply.code(500).send({
          code: errorCodes.INTERNAL_SERVER_ERROR,
          message: 'Internal Server Error',
        })
      }
    },
  )

  app.withTypeProvider<ZodTypeProvider>().get(
    '/characters/:gid/items',
    {
      schema: {
        tags: ['Character'],
        summary: '查询角色物品列表',
        params: characterDetailParamsSchema,
        response: {
          200: characterItemsResponseSchema,
          400: errorSchema,
          404: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request, reply) => {
      const { gid } = request.params
      const character = await app.db.ddb
        .selectFrom('basic_char_info')
        .select('gid')
        .where('gid', '=', gid)
        .executeTakeFirst()
      if (!character) {
        return reply.code(404).send({
          code: errorCodes.CHARACTER_NOT_FOUND,
          message: '角色不存在',
        })
      }
      const row = await app.db.ddb
        .selectFrom('data')
        .select('content')
        .where('path', '=', 'user')
        .where('name', '=', gid)
        .where('branch', '=', 'carry')
        .executeTakeFirst()
      if (!row) return { branchExists: false, items: [] }
      try {
        return { branchExists: true, items: parseCharacterCarry(row.content) }
      } catch (cause) {
        request.log.error(
          {
            gid,
            entryKey:
              cause instanceof CharacterCarryError ? cause.entryKey : null,
            reason:
              cause instanceof CharacterCarryError
                ? cause.message
                : 'Invalid carry data',
          },
          'Invalid character carry data',
        )
        return reply.code(500).send({
          code: errorCodes.INTERNAL_SERVER_ERROR,
          message: 'Internal Server Error',
        })
      }
    },
  )

  app.withTypeProvider<ZodTypeProvider>().get(
    '/characters/:gid',
    {
      schema: {
        tags: ['Character'],
        summary: '查询角色详情',
        params: characterDetailParamsSchema,
        response: {
          200: characterDetailResponseSchema,
          400: errorSchema,
          404: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request, reply) => {
      const { gid } = request.params
      const basic = await app.db.ddb
        .selectFrom('basic_char_info')
        .select(['gid', 'name', 'polar', 'gender', 'time'])
        .where('gid', '=', gid)
        .executeTakeFirst()
      if (!basic) {
        return reply.code(404).send({
          code: errorCodes.CHARACTER_NOT_FOUND,
          message: '角色不存在',
        })
      }
      const row = await app.db.ddb
        .selectFrom('data')
        .select('content')
        .where('path', '=', 'user')
        .where('name', '=', gid)
        .where('branch', '=', '')
        .executeTakeFirst()
      try {
        const me = row ? readCharacterMe(row.content) : undefined
        if (row && readCharacterString(me, 'gid') !== gid)
          throw new Error('me.gid must match the requested GID')
        const number = (key: string) => readCharacterNumber(me, key)
        const string = (key: string) => readCharacterString(me, key)
        return {
          basicInfo: {
            gid: basic.gid,
            name: basic.name ?? null,
            account: string('account'),
            level: number('level'),
            polar: basic.polar ?? null,
            gender: basic.gender ?? null,
            createTime:
              basic.time == null ? null : formatDisplayTime(basic.time),
          },
          sectInfo: {
            family: string('family'),
            master: string('master'),
            title: string('title'),
          },
          attributes: {
            strength: number('str'),
            constitution: number('con'),
            dexterity: number('dex'),
            wiz: number('wiz'),
          },
          combat: {
            life: number('life'),
            maxLife: number('max_life'),
            mana: number('mana'),
            maxMana: number('max_mana'),
            speed: number('speed'),
            defense: number('def'),
            physicalPower: number('phy_power'),
            magPower: number('mag_power'),
          },
          cultivation: {
            experience: number('exp'),
            experienceToNextLevel: number('exp_to_next_level'),
            tao: number('tao'),
            potential: number('pot'),
          },
          assets: {
            cash: number('cash'),
            goldCoin: number('gold_coin'),
            silverCoin: number('silver_coin'),
            voucher: number('voucher'),
          },
        }
      } catch (cause) {
        const message = cause instanceof Error ? cause.message : String(cause)
        const offset =
          cause instanceof LpcParseError ? ` (offset: ${cause.offset})` : ''
        request.log.error(
          { err: cause, gid },
          `Invalid character data: ${message}${offset}`,
        )
        return reply.code(500).send({
          code: errorCodes.CHARACTER_DATA_INVALID,
          message: `角色数据损坏：${message}${offset}`,
        })
      }
    },
  )

  app.withTypeProvider<ZodTypeProvider>().get(
    '/characters',
    {
      schema: {
        tags: ['Character'],
        summary: '查询角色列表',
        description: '分页查询 dl_ddb_1.basic_char_info',
        querystring: charactersQuerySchema,
        response: {
          200: charactersResponseSchema,
          400: errorSchema,
          500: errorSchema,
          default: errorSchema,
        },
      },
    },
    async (request) => {
      const { page, pageSize } = request.query
      const [countResult, items] = await Promise.all([
        app.db.ddb
          .selectFrom('basic_char_info')
          .select((expressionBuilder) =>
            expressionBuilder.fn.countAll().as('total'),
          )
          .executeTakeFirstOrThrow(),
        app.db.ddb
          .selectFrom('basic_char_info')
          .select(['gid', 'name', 'polar', 'gender', 'time'])
          .orderBy('gid')
          .limit(pageSize)
          .offset((page - 1) * pageSize)
          .execute(),
      ])

      const total = Number(countResult.total)
      if (!Number.isSafeInteger(total) || total < 0) {
        throw new Error('Invalid character count returned by database')
      }

      const accounts = new Map<string, string | null>()
      if (items.length > 0) {
        const rows = await app.db.ddb
          .selectFrom('data')
          .select(['name', 'content'])
          .where('path', '=', 'user')
          .where('branch', '=', '')
          .where(
            'name',
            'in',
            items.map((item) => item.gid),
          )
          .execute()
        for (const row of rows) {
          try {
            accounts.set(
              row.name,
              readCharacterString(readCharacterMe(row.content), 'account'),
            )
          } catch (cause) {
            const message =
              cause instanceof Error ? cause.message : String(cause)
            const offset =
              cause instanceof LpcParseError ? ` (offset: ${cause.offset})` : ''
            throw new Error(
              `Invalid character data for GID ${row.name}: ${message}${offset}`,
            )
          }
        }
      }

      return {
        page,
        pageSize,
        total,
        items: items.map((item) => ({
          ...item,
          time: formatDisplayTime(item.time),
          account: accounts.get(item.gid) ?? null,
        })),
      }
    },
  )
}
