# GitHub Actions Workflows

This guide explains the workflow conventions and structure used across
hotdog-werx repositories.

## Workflow Naming Convention

We use a naming convention to distinguish between **callable workflows**
(reusable implementations) and **event-driven workflows** (entry points that get
triggered).

### Callable Workflows (Prefixed with `_`)

Callable workflows contain the actual implementation logic and are designed to
be called by other workflows. They are prefixed with an underscore (`_`) to
signal that they are "internal" and not meant to be triggered directly by
events.

**Examples:**

- `_build-docs.yaml` - Builds and deploys documentation
- `_run-checks.yaml` - Runs CI checks (linting, type checking, tests)
- `_create-release.yaml` - Creates a new release
- `_publish-package.yaml` - Publishes package to PyPI

**Characteristics:**

- Use `on: workflow_call:` trigger
- Contain the actual implementation logic
- Can accept inputs and produce outputs
- Are called by event-driven workflows

### Event-Driven Workflows (No Prefix)

Event-driven workflows are triggered by GitHub events and serve as entry points.
They typically call one or more callable workflows.

**Examples:**

- `ci-checks.yaml` - Triggered on push/PR, calls `_run-checks.yaml`
- `deploy-docs.yaml` - Triggered on push to master, calls `_build-docs.yaml`
- `auto-release.yaml` - Triggered on PR merge, calls `_create-release.yaml` and
  `_publish-package.yaml`

**Characteristics:**

- Use event triggers (`on: push:`, `on: pull_request:`, etc.)
- Short and focused - primarily just call callable workflows
- Define when and why workflows run
- Easy to customize per repository

## Why This Convention?

The underscore prefix convention offers several benefits:

1. **Visual Clarity** - Immediately distinguish implementation from entry points
   when scanning files
2. **Intent Signaling** - Like Python's `_` convention, it signals "internal
   use"
3. **Prevents Confusion** - Clear which workflow to edit vs which to leave alone
4. **Consistency** - Applies across all hotdog-werx repositories
5. **File Grouping** - Callable workflows sort together in file listings

## Example Structure

```
.github/workflows/
├── _build-docs.yaml          # Callable: Documentation build/deploy logic
├── _create-release.yaml      # Callable: Release creation logic
├── _publish-package.yaml     # Callable: Package publishing logic
├── _run-checks.yaml          # Callable: CI checks logic
├── auto-release.yaml         # Event-driven: Runs on PR merge
├── ci-checks.yaml            # Event-driven: Runs on push/PR
└── deploy-docs.yaml          # Event-driven: Runs on push to master
```

## Using Callable Workflows

### From the Same Repository

```yaml
name: ci-checks

on:
  push:
    branches: [master, main]
  pull_request:

jobs:
  checks:
    uses: ./.github/workflows/_run-checks.yaml
```

### From codeguide Repository

Other hotdog-werx repositories can use the callable workflows from codeguide:

```yaml
name: ci-checks

on:
  push:
    branches: [master]
  pull_request:

jobs:
  checks:
    uses: hotdog-werx/codeguide/.github/workflows/_run-checks.yaml@ref
```

## Template Generation with Repolish

The [repolish](../getting-started/quick-start.md) tool can automatically
generate the event-driven workflows for your repository. It creates short,
focused workflows that call the appropriate callable workflows from codeguide.

This ensures:

- Consistent CI/CD across all repositories
- Easy updates when callable workflows improve
- Minimal boilerplate in each repository
- Customization only where needed
