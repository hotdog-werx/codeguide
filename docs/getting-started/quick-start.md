# Quick Start

## 1. Install CodeGuide

```bash
uvx pkglink github:hotdog-werx/codeguide
```

## 2. Set Up Your Project

Create `poe_tasks.toml` in your project root with the following content:

```toml
[tool.poe]
include = [
  ".codeguide/poe/ci-checks.toml",
  ".codeguide/poe/dev-setup.toml",
  ".codeguide/poe/docs.toml",
]

[tool.poe.tasks]
ci-checks.help = "run all checks for CI"
ci-checks.sequence = [
  "check-python",
  "check-dprint",
  "check-basedpyright",
  "check-complexity",
  # "check-coverage"
]
```

In this file you will be able to inherit and customize tasks as needed, define
your ci-checks accordingly.

Create a `toolbelt.yaml` file in your project root with the following content:

```yaml
include:
  - .codeguide/toolbelt/toolbelt.yaml

variables:
  TB_PROJECT_SOURCE: src # adjust to match your python package
```

In here you can define any additional variables or overrides for your toolbelt
configuration.

## 3. Start Coding

Your project now has:

- ✅ Linting configuration
- ✅ Formatting setup
- ✅ Testing standards

```
poe ci-checks
```
