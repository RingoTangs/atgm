import type { Privilege } from '@atgm/contracts'

export const formatAccountPrivilegeLabel = (
  privilege: Pick<Privilege, 'privilege' | 'description'> &
    Partial<Pick<Privilege, 'grant' | 'constant'>>,
): string =>
  privilege.grant && privilege.constant
    ? `${privilege.privilege} - ${privilege.grant} - ${privilege.constant}(${privilege.description})`
    : `${privilege.privilege} - ${privilege.description}`
