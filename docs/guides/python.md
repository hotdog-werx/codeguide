# Python Projects

Best practices and standards for Python development at hotdog-werx.

## Project Structure

CodeGuide supports both flat and src-based project layouts:

**Flat Layout (Recommended for most projects):**

```
my-python-project/
├── my_package/               # Your package code
│   ├── __init__.py
│   └── main.py
├── tests/                    # Test files
│   └── test_main.py
├── pyproject.toml           # Project configuration
├── README.md                # Project documentation
└── .codeguide/              # CodeGuide configuration (generated)
```

**Src Layout (For complex projects with multiple packages):**

```
my-python-project/
├── src/
│   ├── my_package/
│   └── utils_package/
├── tests/
├── pyproject.toml
└── .codeguide/
```

!!! tip "Choose What Makes Sense" Use the flat layout for most projects. Only
use `src/` if you have multiple packages or complex build requirements. Don't
add unnecessary layers just because it's "modern".

## Code Quality Tools

CodeGuide provides pre-configured tools for maintaining high code quality:

### Ruff - Linting & Formatting

Ruff is an extremely fast Python linter and formatter that replaces multiple
tools (flake8, black, isort, etc.).

**Format your code:**

```bash
uvx tbelt format python
```

**Or use the poe task:**

```bash
poe format-python
```

**Check your configuration:**

```bash
uvx tbelt config python
```

This shows you the exact commands `tbelt` runs and which variables you can
override.

Example output:

```
Property              Value                                              
 Tool Name             ruff-format                                        
 Description           Final Python formatting pass                       
 Raw Command           uvx ruff@${TB_RUFF_VERSION:latest} --config        
                       ${TB_RUFF_CONFIG:.codeguide/configs/ruff.toml}     
                       format                                             
 Expanded Command      uvx ruff@0.13.0 --config                           
                       .codeguide/configs/ruff.toml format                
 File Mode             batch                                              
 Default Target        .
```

### Customizing Ruff Configuration

CodeGuide provides sensible defaults, but you can customize them per project:

1. **Create your own config file:**
   ```bash
   touch ruff.toml
   ```

2. **Update your toolbelt configuration:**
   ```yaml
   # toolbelt.yaml
   variables:
     TB_RUFF_CONFIG: ruff.toml # Point to your custom config
   ```

3. **Extend CodeGuide defaults:**
   ```toml
   # ruff.toml
   extend = ".codeguide/configs/ruff.toml"

   [lint.extend-per-file-ignores]
   "src/notebooks/*.py" = ["ALL"] # Ignore all rules in notebooks
   "tests/*" = ["S101"] # Allow assert statements in tests
   ```

This approach lets you customize rules while inheriting CodeGuide's
battle-tested defaults.

### Pyright - Type Checking

Static type analysis for Python with excellent performance:

```bash
uvx tbelt check basedpyright
```

CodeGuide configures Pyright with strict settings to catch type-related bugs
early.

### Coverage - Test Coverage

Measure and enforce test coverage:

```bash
uvx tbelt check coverage  # Runs tests with coverage
```
