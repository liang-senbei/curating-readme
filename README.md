# curating-readme —— README / 文档整理技能

一个 [Claude Agent Skill](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview)：
让 AI **把仓库里已经存在的信息**(manifest、代码、脚本、配置、git 历史、现有文档)整理成
**规范、结构化**的 README 和相关文档(CONTRIBUTING / CHANGELOG / docs/ / SECURITY 等)。

结构参照大公司 / 大项目通行规范:
[standard-readme 规范](https://github.com/RichardLitt/standard-readme) +
[Anthropic 官方 skill 编写最佳实践](https://platform.claude.com/docs/en/agents-and-tools/agent-skills/best-practices)。

## 核心理念

- **一切以仓库为准**:每条特性 / 命令 / 配置 / 徽章 / 链接都要能在仓库里找到出处,**绝不编造**。查不到就问,不猜。
- **是更新不是覆盖**:保留人工写的内容,只补缺、修过时、按规范重排。
- **跟随仓库语言**:中文仓库就写中文,沿用其语气与术语。

## 目录结构

```
curating-readme/
├── SKILL.md                      # 技能主体:流程 + 检查清单(AI 触发后先读这个)
├── README.md                     # 本文件(给人看)
├── references/                   # 按需加载的参考(渐进式披露)
│   ├── readme-structure.md       # README 各章节的规范顺序 / 必选可选 / 各写什么
│   ├── doc-style-guide.md        # 文风 / 徽章 / 标题 / 代码块 / 链接 / 表格规范
│   └── related-files.md          # CONTRIBUTING/CHANGELOG/LICENSE/SECURITY/docs 的写法 + 骨架
├── assets/
│   └── README.template.md        # 可直接套用的 README 骨架(含填写提示)
└── scripts/
    └── audit-repo.sh             # 只读的仓库信息盘点脚本(流程第 1 步先跑它)
```

## 怎么用

### 作为 Claude Code 技能安装

技能从 `~/.claude/skills/`(用户级)或项目内 `.claude/skills/` 加载。克隆后软链(或复制)过去即可:

```bash
git clone https://github.com/liang-senbei/curating-readme.git
mkdir -p ~/.claude/skills
ln -s "$(pwd)/curating-readme" ~/.claude/skills/curating-readme   # 或 cp -r curating-readme ~/.claude/skills/
```

之后在目标仓库里说「整理 / 更新 README」「把文档规范一下」,AI 会自动触发本技能。
也可显式调用 `/curating-readme`。技能在会话启动时加载,已在跑的会话需重开 / `/clear` 才生效。

### 直接看盘点结果(不装也能用脚本)

```bash
bash scripts/audit-repo.sh /path/to/your/repo
```

输出一份「这个仓库到底有什么」的清单(项目类型、入口、脚本、现有文档、目录结构、环境变量、
git 元数据、语言分布、CI 线索),AI 据此落地文档、人也能快速对账。

## 流程(SKILL.md 里的检查清单)

1. **盘点**:跑 `audit-repo.sh`,读现有 README / manifest / 入口代码。
2. **定型**:判断项目类型(库 / CLI / 服务 / monorepo / 文档),决定用哪些章节。
3. **写 README**:按 `references/readme-structure.md` 的规范顺序起草 / 刷新。
4. **同步相关文件**:按 `references/related-files.md` 更新 CONTRIBUTING / CHANGELOG / docs 等。
5. **校验**:链接通、命令真、目录(TOC)对得上、术语一致、语言一致、出处可追溯。

详见 [SKILL.md](./SKILL.md)。
