# Microssonoba org defaults

This public repo holds defaults shared by every repo in the Microssonoba org. Keep secrets and internal details out of it.

## What lives here

| Path | Purpose |
| --- | --- |
| `ISSUE_TEMPLATE/` | Default issue templates: agent task, bug, platform request |
| `pull_request_template.md` | Default PR template for human-authored PRs |
| `scripts/labels.txt` | The org-wide label set |
| `scripts/sync-labels.sh` | Creates or updates those labels in a repo |
| `.github/workflows/node-ci.yml` | Reusable CI workflow for Node repos |

## How defaults apply

GitHub uses these templates only in repos that have no template of their own. A repo with its own `.github/ISSUE_TEMPLATE/` folder ignores every issue template here, and the same applies to the PR template.

## Branches

`development` is the default branch and where changes land, through feature-branch PRs. `production` is the live version, updated by promotion PRs from `development` merged with a merge commit.

Products call the reusable workflow at `@production`, so CI changes reach them only after promotion. Issue and PR templates are read from the default branch, so they go live on merge into `development`.

## Labels

The `agent:*` labels must match what the agent orchestrator expects. Change them there first, then update `scripts/labels.txt`.

Sync labels into a repo after creating it or after editing the list:

```bash
./scripts/sync-labels.sh Microssonoba/<repo>
```

## Reusable CI

```yaml
jobs:
  verify:
    uses: Microssonoba/.github/.github/workflows/node-ci.yml@production
    with:
      install: npm ci
      verify: npm test
```
