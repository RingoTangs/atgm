import type { MenuProps } from 'antd'
import { useLocation, useNavigate } from '@tanstack/react-router'
import { Button, Drawer, Dropdown, Grid, Layout, Menu, Tooltip } from 'antd'
import {
  Gamepad2,
  LayoutDashboard,
  Menu as MenuIcon,
  Moon,
  PanelLeftClose,
  PanelLeftOpen,
  Sun,
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

export const AppLayout: React.FC<React.PropsWithChildren> = ({ children }) => {
  const [collapsed, setCollapsed] = useState(false)
  const [drawerOpen, setDrawerOpen] = useState(false)
  const screens = Grid.useBreakpoint()
  const isDesktop = Boolean(screens.md)
  const pathname = useLocation({ select: (location) => location.pathname })
  const navigate = useNavigate()
  const { theme, resolvedTheme, setTheme } = useTheme()
  const dashboardSelected = pathname === '/'

  const navigationItems: MenuProps['items'] = [
    {
      key: '/',
      icon: <LayoutDashboard aria-hidden="true" size={18} />,
      label: (
        <span aria-current={dashboardSelected ? 'page' : undefined}>
          Dashboard
        </span>
      ),
    },
  ]

  const handleNavigation: MenuProps['onClick'] = ({ key }) => {
    setDrawerOpen(false)

    if (key === '/') {
      void navigate({ to: '/' })
    }
  }

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

  const navigationMenu = (
    <Menu
      classNames={{
        root: 'border-e-0',
      }}
      items={navigationItems}
      mode="inline"
      onClick={handleNavigation}
      selectedKeys={dashboardSelected ? ['/'] : []}
      theme={resolvedTheme}
    />
  )

  return (
    <Layout className="min-h-screen bg-transparent">
      {isDesktop && (
        <Sider
          collapsed={collapsed}
          collapsedWidth={72}
          width={240}
          theme="light"
          classNames={{
            root: 'border-r-1 border-r-muted px-2'
          }}
        >
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
          {navigationMenu}
        </Sider>
      )}

      <Layout className="bg-transparent">
        <Header
          className="bg-background sticky top-0 z-10 flex items-center justify-between"
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
                onClick={() => setCollapsed((value) => !value)}
                type="text"
              />
            ) : (
              <>
                <Tooltip title="打开导航">
                  <Button
                    aria-label="打开导航"
                    icon={<MenuIcon aria-hidden="true" size={20} />}
                    onClick={() => setDrawerOpen(true)}
                    type="text"
                  />
                </Tooltip>
                <span className="font-semibold">ATGM</span>
              </>
            )}
          </div>

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
        </Header>

        <Content className="p-4 md:p-6">
          <div className="mx-auto max-w-[1600px]">{children}</div>
        </Content>
      </Layout>

      {!isDesktop && (
        <Drawer
          closable={{ 'aria-label': '关闭导航' }}
          destroyOnHidden
          onClose={() => setDrawerOpen(false)}
          open={drawerOpen}
          placement="left"
          styles={{ body: { padding: 0 } }}
          size={280}
          title="导航"
        >
          {navigationMenu}
        </Drawer>
      )}
    </Layout>
  )
}
