## Privilege 权限汇总

AskTao GS 中目前已确认存在 **17 个特殊权限常量**，分为 **GM 特权组、管理特权、DEBUGGER 调试特权** 三类。

> 注意：以下数值为 GS 内部发现的权限常量。目前尚未完全验证 `dl_adb_all.account.privilege` 是否可以直接使用全部这些值。

### 权限常量表

| Privilege | Grant 标识 | 权限常量             | 权限类型  | 含义                      | `grant.list` GM 操作 |
| --------: | ---------- | -------------------- | --------- | ------------------------- | -------------------- |
|     `101` | `G1`       | `GM_GROUP1`          | GM 特权组 | GM 特权组 1               | 允许                 |
|     `102` | `G2`       | `GM_GROUP2`          | GM 特权组 | GM 特权组 2               | 允许                 |
|     `103` | `G3`       | `GM_GROUP3`          | GM 特权组 | GM 特权组 3               | 允许                 |
|     `104` | `G4`       | `GM_GROUP4`          | GM 特权组 | GM 特权组 4               | 允许                 |
|     `105` | `G5`       | `GM_GROUP5`          | GM 特权组 | GM 特权组 5               | 允许                 |
|     `106` | `G6`       | `GM_GROUP6`          | GM 特权组 | GM 特权组 6               | 允许                 |
|     `107` | `G7`       | `GM_GROUP7`          | GM 特权组 | GM 特权组 7               | 允许                 |
|     `108` | `G8`       | `GM_GROUP8`          | GM 特权组 | GM 特权组 8               | 允许                 |
|     `109` | `G9`       | `GM_GROUP9`          | GM 特权组 | GM 特权组 9               | 允许                 |
|     `120` | `GA`       | `ADMINISTRATOR`      | 管理特权  | 管理员                    | 允许                 |
|     `130` | `GA1`      | `OBSERVER`           | 管理特权  | 观察员                    | 允许                 |
|     `140` | `GA2`      | `CUSTOMER_SERVICE_1` | 管理特权  | 一级客服                  | 允许                 |
|     `150` | `GA3`      | `CUSTOMER_SERVICE_2` | 管理特权  | 二级客服                  | 允许                 |
|     `200` | `GB`       | `BEHOLDER`           | 管理特权  | Beholder / 监管类权限     | 允许                 |
|     `300` | `GC`       | `CONTROLLER`         | 管理特权  | Controller / 控制类权限   | 允许                 |
|     `400` | `GC1`      | `CONTROLLER_1`       | 管理特权  | Controller 1 / 控制类权限 | 允许                 |
|    `1000` | `GD`       | `DEBUGGER`           | 调试特权  | 调试器权限                | 未直接列入           |

### 管理权限层级

`grant.list` 中明确给出了以下权限等级关系：

```text
GD > GC > GB > GA3 > GA2 > GA1 > GA
```

对应为：

```text
DEBUGGER
    >
CONTROLLER
    >
BEHOLDER
    >
CUSTOMER_SERVICE_2
    >
CUSTOMER_SERVICE_1
    >
OBSERVER
    >
ADMINISTRATOR
```

对应数值：

```text
1000 > 300 > 200 > 150 > 140 > 130 > 120
```

需要注意：

- `CONTROLLER_1 (400 / GC1)` 没有出现在上述层级注释中。
- `GM_GROUP1 ~ GM_GROUP9 (101~109)` 也没有出现在上述层级关系中。
- 是否按照数值大小自动继承低级权限，需要以 `grant_greater()` 的实际实现为准，不能单纯依据整数大小判断。

### GM 特权组

GM 特权组范围：

| 范围        | 常量                    | 用途                 |
| ----------- | ----------------------- | -------------------- |
| `101 ~ 109` | `GM_GROUP1 ~ GM_GROUP9` | 可配置的 GM 授权分组 |

与 `ADMINISTRATOR`、`OBSERVER`、`CONTROLLER` 等具有明确身份语义的管理特权不同，`GM_GROUP1 ~ GM_GROUP9` 更接近额外的**授权分组标识**。

当前 `grant.list` 并没有给 G1～G9 配置不同的操作集合，因此在现有配置下无法从 `grant.list` 看出 G1～G9 的功能差异。

### 管理特权

| Privilege | 权限                 | 主要定位       |
| --------: | -------------------- | -------------- |
|     `120` | `ADMINISTRATOR`      | 管理员         |
|     `130` | `OBSERVER`           | 观察员         |
|     `140` | `CUSTOMER_SERVICE_1` | 一级客服       |
|     `150` | `CUSTOMER_SERVICE_2` | 二级客服       |
|     `200` | `BEHOLDER`           | 监管类权限     |
|     `300` | `CONTROLLER`         | 控制类权限     |
|     `400` | `CONTROLLER_1`       | 扩展控制类权限 |

当前 `grant.list` 中检查到的 GM 操作，对上述权限均进行了授权。

因此，**从当前 `grant.list` 本身看不出这些管理特权在 GM 命令集合上的明显差异**。实际差异还可能来自 `grant_greater()`、其他代码级权限判断或不同子系统。

### DEBUGGER

| Privilege | Grant 标识 | 常量       | 用途        |
| --------: | ---------- | ---------- | ----------- |
|    `1000` | `GD`       | `DEBUGGER` | GS 调试特权 |

目前已发现与 `DEBUGGER` 相关的机制包括：

- `enable_debugger`
- `debugger_enabled`
- `express_login`
- 调试版本快捷登录相关逻辑

`DEBUGGER` 虽然在 `grant.list` 中定义为 `GD`，但没有直接出现在当前检查的 GM 操作授权列表中。

因此不能简单理解为：

```text
DEBUGGER = 所有 GM 权限
```

它更可能是一种具有特殊处理逻辑的调试级权限。

另外，`start_gs.o` 中存在：

```text
測試
内測
测试
内测
```

以及：

```text
get_config
my_dist
```

等与区组名称相关的数据，但目前尚未证明：

```text
privilege = 1000
```

与“内测区/测试区”的登录准入存在直接绑定关系。

### `grant.list` GM 功能范围

当前分析到的 `grant.list` 包含约 83 项 GM 操作，主要覆盖：

| 功能类别       | 典型功能             |
| -------------- | -------------------- |
| 账号管理       | 查询账号、封号等     |
| 玩家管理       | 踢下线、限制角色等   |
| 角色查询       | 查询角色及相关信息   |
| 聊天管理       | 警告、频道管理等     |
| 角色控制       | 传送、召唤、监狱等   |
| 属性管理       | 修改角色属性         |
| 技能管理       | 修改技能             |
| 任务管理       | 清理或调整任务       |
| 物品管理       | 创建/复制物品和装备  |
| 宠物管理       | 创建/复制宠物        |
| 坐骑管理       | 创建/复制坐骑        |
| NPC / 对象管理 | 移动 NPC、删除对象等 |
| 全服公告       | 广播、定时广播       |
| 登录管理       | 控制服务器登录许可   |
| 服务器管理     | 重启等管理操作       |
| 活动管理       | 节日活动、全局奖励等 |
| 运维诊断       | 网络信息、作弊检测等 |

当前 `grant.list` 对以下 16 个权限均配置了 GM 操作授权：

```text
101 ~ 109
120
130
140
150
200
300
400
```

即：

```text
G1 ~ G9
GA
GA1
GA2
GA3
GB
GC
GC1
```

`DEBUGGER (1000 / GD)` 没有直接列入这些操作的授权列表。

### 当前结论

| 项目                                        | 状态         |
| ------------------------------------------- | ------------ |
| `GM_GROUP1 ~ GM_GROUP9 = 101 ~ 109`         | 已确认       |
| `ADMINISTRATOR = 120`                       | 已确认       |
| `OBSERVER = 130`                            | 已确认       |
| `CUSTOMER_SERVICE_1 = 140`                  | 已确认       |
| `CUSTOMER_SERVICE_2 = 150`                  | 已确认       |
| `BEHOLDER = 200`                            | 已确认       |
| `CONTROLLER = 300`                          | 已确认       |
| `CONTROLLER_1 = 400`                        | 已确认       |
| `DEBUGGER = 1000`                           | 已确认       |
| `grant.list` 操作授权关系                   | 已分析       |
| 普通玩家默认 `privilege`                    | 尚未确认     |
| DB `account.privilege` 是否直接对应 GS 常量 | 尚未完全确认 |
| `grant_greater()` 的精确继承规则            | 尚未还原     |
| `DEBUGGER` 是否拥有普通 GM 操作             | 尚未确认     |
| `DEBUGGER` 是否与测试/内测区登录绑定        | 尚未确认     |
| `GC1 = 400` 在等级体系中的具体位置          | 尚未确认     |

### 简化速查表

```text
101   G1    GM_GROUP1
102   G2    GM_GROUP2
103   G3    GM_GROUP3
104   G4    GM_GROUP4
105   G5    GM_GROUP5
106   G6    GM_GROUP6
107   G7    GM_GROUP7
108   G8    GM_GROUP8
109   G9    GM_GROUP9

120   GA    ADMINISTRATOR
130   GA1   OBSERVER
140   GA2   CUSTOMER_SERVICE_1
150   GA3   CUSTOMER_SERVICE_2
200   GB    BEHOLDER
300   GC    CONTROLLER
400   GC1   CONTROLLER_1

1000  GD    DEBUGGER
```
