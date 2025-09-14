# CodeGuide

> A comprehensive guide to coding practices and standards for hotdog-werx

CodeGuide provides pre-configured tools, standards, and best practices to ensure
consistent, high-quality code across all hotdog-werx projects. Get up and
running with Python development quickly using battle-tested configurations for
linting, formatting, type checking, and testing.

## 🚀 Quick Start

### Installation

Link CodeGuide to your project using pkglink:

```bash
uvx pkglink github:hotdog-werx/codeguide
```

### Setup

Create configuration files to inherit CodeGuide's standards:

**1. Create `poe_tasks.toml`:**

```toml
[tool.poe]
include = [
  ".codeguide/poe/ci-checks.toml",
  ".codeguide/poe/dev-setup.toml",
]
```

**2. Create `toolbelt.yaml`:**

```yaml
include:
  - .codeguide/toolbelt/toolbelt.yaml

variables:
  TB_PROJECT_SOURCE: src # adjust to your package location
```

### Usage

Format your Python code:

```bash
uvx tbelt format python
```

That's it! Your project now follows hotdog-werx coding standards.

## 📖 Documentation

For detailed guides, customization options, and best practices, visit:

**[📚 Full Documentation](https://hotdog-werx.github.io/codeguide/)**
