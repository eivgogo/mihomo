# AGENTS.md

**改写任何 git 历史之前，先读完本文件。**

---

## 1. 铁律：我自己的提交永远位于 `my-alpha` 最新提交的最上面

`origin/Alpha` 一旦前进，**必须用 `rebase`** 把我自己的提交重新叠到上游最新提交之上。

### 禁止事项

- ❌ **不要 `git merge origin/Alpha`** —— 会在历史里留下合并提交，破坏线性
- ❌ 不要用裸 `git push --force`，只用 `--force-with-lease`
- ❌ 不要在 detached HEAD（例如停在某个 tag 上）时提交，否则提交会变成游离对象
