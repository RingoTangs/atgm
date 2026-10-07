import type { MenuProps } from 'antd'
import { useLocation, useNavigate } from '@tanstack/react-router'
import { Button, Drawer, Dropdown, Grid, Layout, Menu } from 'antd'
import {
  Gamepad2,
  LayoutDashboard,
  Menu as MenuIcon,
  Moon,
  PanelLeftClose,
  PanelLeftOpen,
  Sun,
  UserRound,
  Users,
} from 'lucide-react'
import { useState } from 'react'
import { useTheme } from '@/theme'

const { Content, Header, Sider } = Layout

const themeLabels = {
  light: '浅色',
  dark: '深色',
  system: '跟随系统',
} as const

const themeItems: MenuProps['items'] = [
  {
    key: 'light',
    label: themeLabels.light,
  },
  {
    key: 'dark',
    label: themeLabels.dark,
  },
  {
    key: 'system',
    label: themeLabels.system,
  },
]

interface AppBrandProps {
  collapsed: boolean
}

const AppBrand: React.FC<AppBrandProps> = ({ collapsed }) => (
  <div
    aria-label="ATGM"
    className="flex h-16 items-center justify-center gap-3 px-4"
  >
    <Gamepad2 aria-hidden="true" className="shrink-0" size={24} />
    {!collapsed && (
      <div className="min-w-0 leading-tight">
        <div className="text-base font-semibold">Asktao GM</div>
      </div>
    )}
  </div>
)

interface NavigationMenuProps {
  onNavigate: () => void
}

const NavigationMenu: React.FC<NavigationMenuProps> = ({ onNavigate }) => {
  const pathname = useLocation({ select: (location) => location.pathname })
  const navigate = useNavigate()
  const { resolvedTheme } = useTheme()
  const isAccountsPath =
    pathname === '/accounts' || pathname.startsWith('/accounts/')
  const isCharactersPath =
    pathname === '/characters' || pathname.startsWith('/characters/')
  const selectedNavigationKey =
    pathname === '/'
      ? pathname
      : isAccountsPath
        ? '/accounts'
        : isCharactersPath
          ? '/characters'
          : undefined

  const navigationItems: MenuProps['items'] = [
    {
      key: '/',
      icon: <LayoutDashboard aria-hidden="true" size={18} />,
      label: (
        <span aria-current={pathname === '/' ? 'page' : undefined}>
          Dashboard
        </span>
      ),
    },
    {
      key: '/accounts',
      icon: <Users aria-hidden="true" size={18} />,
      label: (
        <span aria-current={isAccountsPath ? 'page' : undefined}>账号管理</span>
      ),
    },
    {
      key: '/characters',
      icon: <UserRound aria-hidden="true" size={18} />,
      label: (
        <span aria-current={isCharactersPath ? 'page' : undefined}>
          角色管理
        </span>
      ),
    },
  ]

  const handleNavigation: MenuProps['onClick'] = ({ key }) => {
    onNavigate()

    if (key === '/') {
      void navigate({ to: '/' })
    }

    if (key === '/accounts') {
      void navigate({ to: '/accounts' })
    }
    if (key === '/characters') {
      void navigate({ to: '/characters' })
    }
  }

  return (
    <Menu
      classNames={{
        root: 'border-e-0 bg-transparent',
      }}
      items={navigationItems}
      mode="inline"
      onClick={handleNavigation}
      selectedKeys={selectedNavigationKey ? [selectedNavigationKey] : []}
      theme={resolvedTheme}
    />
  )
}

const ThemeSwitcher: React.FC = () => {
  const { theme, resolvedTheme, setTheme } = useTheme()
  const handleThemeChange: MenuProps['onClick'] = ({ key }) => {
    if (key === 'light' || key === 'dark' || key === 'system') {
      setTheme(key)
    }
  }

  const themeIcon =
    resolvedTheme === 'dark' ? (
      <Moon aria-hidden="true" size={18} />
    ) : (
      <Sun aria-hidden="true" size={18} />
    )

  return (
    <Dropdown
      menu={{
        items: themeItems,
        onClick: handleThemeChange,
        selectable: true,
        selectedKeys: [theme],
      }}
      trigger={['click']}
    >
      <Button
        aria-label={`切换主题，当前：${themeLabels[theme]}`}
        icon={themeIcon}
        type="text"
      />
    </Dropdown>
  )
}

interface DesktopSidebarProps {
  collapsed: boolean
  onNavigate: () => void
}

const DesktopSidebar: React.FC<DesktopSidebarProps> = ({
  collapsed,
  onNavigate,
}) => {
  const { resolvedTheme } = useTheme()

  return (
    <Sider
      collapsed={collapsed}
      collapsedWidth={72}
      width={240}
      theme={resolvedTheme}
      classNames={{
        root: 'h-full overflow-hidden border-r-1 border-r-muted px-1 bg-transparent',
      }}
    >
      <AppBrand collapsed={collapsed} />
      <NavigationMenu onNavigate={onNavigate} />
    </Sider>
  )
}

interface AppHeaderProps {
  isDesktop: boolean
  collapsed: boolean
  onToggleSidebar: () => void
  onOpenNavigation: () => void
}

const AppHeader: React.FC<AppHeaderProps> = ({
  isDesktop,
  collapsed,
  onToggleSidebar,
  onOpenNavigation,
}) => (
  <Header
    className="bg-background z-10 flex shrink-0 items-center justify-between"
    style={{
      paddingInline: isDesktop ? 24 : 16,
    }}
  >
    <div className="flex items-center gap-3">
      {isDesktop ? (
        <Button
          aria-label={collapsed ? '展开侧边栏' : '折叠侧边栏'}
          icon={
            collapsed ? (
              <PanelLeftOpen aria-hidden="true" size={18} />
            ) : (
              <PanelLeftClose aria-hidden="true" size={18} />
            )
          }
          onClick={onToggleSidebar}
          type="text"
        />
      ) : (
        <>
          <Button
            aria-label="打开导航"
            icon={<MenuIcon aria-hidden="true" size={20} />}
            onClick={onOpenNavigation}
            type="text"
          />
          <span className="font-semibold">ATGM</span>
        </>
      )}
    </div>

    <ThemeSwitcher />
  </Header>
)

interface MobileNavigationDrawerProps {
  open: boolean
  onClose: () => void
}

const MobileNavigationDrawer: React.FC<MobileNavigationDrawerProps> = ({
  open,
  onClose,
}) => (
  <Drawer
    closable={{ 'aria-label': '关闭导航' }}
    destroyOnHidden
    onClose={onClose}
    open={open}
    placement="left"
    styles={{ body: { padding: 0 } }}
    size={280}
    title="导航"
  >
    <NavigationMenu onNavigate={onClose} />
  </Drawer>
)

export const AppLayout: React.FC<React.PropsWithChildren> = ({ children }) => {
  const [collapsed, setCollapsed] = useState(false)
  const [drawerOpen, setDrawerOpen] = useState(false)
  const screens = Grid.useBreakpoint()
  const isDesktop = Boolean(screens.md)
  const closeDrawer = () => setDrawerOpen(false)

  return (
    <Layout className="h-dvh overflow-hidden bg-transparent">
      {isDesktop && (
        <DesktopSidebar collapsed={collapsed} onNavigate={closeDrawer} />
      )}

      <Layout className="min-h-0 min-w-0 overflow-hidden bg-transparent">
        <AppHeader
          isDesktop={isDesktop}
          collapsed={collapsed}
          onToggleSidebar={() => setCollapsed((value) => !value)}
          onOpenNavigation={() => setDrawerOpen(true)}
        />

        <Content className="min-h-0 flex-1 overflow-x-hidden overflow-y-auto p-4 md:p-6">
          <div className="mx-auto max-w-[1600px]">{children}</div>
        </Content>
      </Layout>

      {!isDesktop && (
        <MobileNavigationDrawer open={drawerOpen} onClose={closeDrawer} />
      )}
    </Layout>
  )
}
