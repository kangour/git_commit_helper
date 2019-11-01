# commit_helper.sh

> GIT 提交助手，使用统一的提交规范提交优雅的 Commit Message。
> 运行环境：Linux && Language English

## 遵循的格式

```
<type>(<scope>): <subject>
```

通过该格式描述主要修改类型和内容

分别由如下部分构成:

type: commit 的类型

- feat: 新特性
- fix: 修改问题
- refactor: 代码重构
- docs: 文档修改
- style: 代码格式修改, 注意不是 css 修改
- test: 测试用例修改
- chore: 其他修改, 比如构建流程, 依赖管理.

scope: commit 影响的范围, 比如: route, component, utils, build...

subject: commit 的概述, 建议符合  50/72 formatting

## 快速上手

把脚本放到仓库任意目录后启动脚本即可进入自动化提交流程：
```
source commit_helper.sh
```

如果启动失败，可以用 chmod 给文件添加执行权限，例如：
 ```
 chmod 100 commit_helper.sh
 ```

启动后根据提示完成选择和输入即可。

## 需要注意

- 如果是位于 master 分支，会被要求输入一个分支名并自动创建
- 如果没有添加内容，会被要求先添加
- 添加内容后，会被要求选择提交类型，包含 feature fix refactor style docs test chore
- 单文件自动截取（文件夹/文件）作为模块名，多文件以分支名作为模块
- 输入备注信息后，自动提交
