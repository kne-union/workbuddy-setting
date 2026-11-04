# workbuddy-setting

个人 [WorkBuddy](https://www.workbuddy.cn) 用户级技能（Skills）配置库，可一键安装到自己或其他人的电脑上。

包含 **13 个技能**：2 个工作流技能 + 11 条由 Cursor 规则（.mdc）转换而来的开发约定规则。

## 技能清单

### 工作流技能

| 技能 | 说明 |
|------|------|
| `weekly-report` | 用 developer-document MCP 的 `search_worklog` 拉取工作日志，整理成周报 |
| `qa-regression-report` | 从 `search_worklog` 生成给测试的功能回归报告（冒烟 + 用例表 + 追溯） |

### 规则类技能（源自 Cursor 规则库）

| 技能 | 说明 |
|------|------|
| `business-development-workflow` | 非 kne-union 业务项目：拷贝到 `~/.cursor_workplace` 开发，验收后拷回归档，输出 `DEVELOPMENT_COMPLETE` |
| `development-workflow` | 仅 kne-union：开发交付流程，结束后发出 `DEVELOPMENT_COMPLETE` 供 worklog 规则消费 |
| `experience-distill-write` | 收到 `WORKLOG_WRITTEN` 后提炼可复用经验，按 business/library/process 分层沉淀 |
| `experience-similar-search` | 动手前先在本地经验库与 MCP「Prompts」npm 包内检索可复用经验 |
| `kne-document-remote-storage` | kne_document 双写同步：本地落盘 + MCP 上传（REST 脚本兜底） |
| `kne-document-search` | 查 @kne / remote 文档时优先 MCP `search_document_index`，本地索引兜底 |
| `no-restart-user-services` | 禁止擅自重启用户本地开发服务，只告知用户自行操作 |
| `project-prompts-compliance` | 项目含 `prompts/` 时须先读并按其中规范编写 |
| `prompts-update-workflow` | 更新 prompts 须先本地草稿确认，同意后再改源包并发 PR |
| `responsive-utils-mobile` | KNE 前端移动端适配统一使用 `@kne/responsive-utils` |
| `worklog-write` | 仅在收到 `DEVELOPMENT_COMPLETE`（或用户明确要求）时写入工作日志 JSON |

## 安装

### 一键安装（推荐）

```bash
git clone git@github.com:zhipenglin/workbuddy-setting.git
cd workbuddy-setting
./install.sh
```

安装到 `~/.workbuddy/skills/`（用户级，所有项目生效）。已存在的同名技能会自动备份为 `<name>.bak.<时间戳>`。

只安装部分技能：

```bash
./install.sh weekly-report qa-regression-report
```

安装到项目级（仅当前项目生效）：

```bash
WORKBUDDY_SKILLS_DIR="$(pwd)/.workbuddy/skills" ./install.sh
```

安装后**重启 WorkBuddy（或新开会话）**即可生效，可在「设置 → 技能管理」中确认加载。

### 卸载

```bash
./uninstall.sh              # 卸载全部
./uninstall.sh weekly-report  # 卸载指定技能
```

## 注意事项

- 部分技能依赖 `user-developer-document` MCP（如 `weekly-report`、`qa-regression-report`、`worklog-write`）以及本地 `~/.kne_document/` 目录，不满足环境时相关技能会按其内置的降级说明提示，不会误报数据。
- 规则类技能的「适用范围」约束写在各自 SKILL.md 正文里（如仅 kne-union 仓库生效），请勿在无关项目中强加执行。

## 目录结构

```
workbuddy-setting/
├── README.md
├── install.sh       # 一键安装
├── uninstall.sh     # 卸载
└── skills/
    ├── <skill-name>/
    │   └── SKILL.md # 技能定义（frontmatter: name / description）
    └── ...
```
