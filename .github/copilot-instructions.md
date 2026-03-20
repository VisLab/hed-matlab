# HED-MATLAB developer instructions

This repository contains MATLAB tools and utilities for working with HED (Hierarchical Event Descriptors).

> **Local environment**: If `.status/local-environment.md` exists in this repository, read it first for platform-specific setup (virtual environment activation, shell, paths).

**Markdown style**: Use sentence case for all markdown headers — only the first letter of the first word (and proper nouns/acronyms such as MATLAB, HED, Python) should be capitalized.

When you create summaries of what you did, put them in the `.status/` directory at the root of the repository. Trust the instructions in this file; only search the codebase if something here appears incomplete or incorrect.

## Repository overview

This repository provides MATLAB tools and demonstrations for HED integration, including:

- MATLAB wrapper functions for HED validation and services
- Web service demonstrations and client examples
- Event data remodeling and processing utilities
- Integration examples with EEGLAB and other MATLAB-based tools
- Unit tests for MATLAB functionality
- Comprehensive API documentation

## Project context

- **Primary language**: MATLAB (tools and demonstrations)
- **Build system**: Python (documentation and utilities), managed with `uv`
- **Documentation framework**: Sphinx with MyST parser for markdown
- **MATLAB support**: Sphinx MATLAB domain for auto-generated API docs
- **Output formats**: HTML documentation (via Sphinx and ReadTheDocs)
- **Target audience**: MATLAB users, HED tool integrators, neuroscience researchers

## Bootstrap and build

Always activate the virtual environment before running any Python or Sphinx commands (see `.status/local-environment.md` for the platform-specific activation command).

### Bootstrap (first time setup)

```bash
uv venv --clear .venv
# activate the venv (platform-specific — see .status/local-environment.md)
uv pip install -e ".[docs]"
python docs/patch_matlabdomain.py   # required after every install of sphinxcontrib-matlabdomain
```

### Build documentation

```bash
sphinx-build -b html docs docs/_build/html
# Output: docs/_build/html/index.html
```

Note: the Sphinx source root is `docs/` (not `docs/source/`).

### Run tests and linting

- **MATLAB tests**: Run `run_tests.m` in MATLAB, or via CI with `addpath(genpath("hedmat")), addpath(genpath("tests")), run_tests`
- **Spelling**: `uvx typos`
- **Lint**: `ruff check .`

## CI/CD workflows

GitHub Actions workflows live in `.github/workflows/`:

- **`deploy-docs.yaml`**: Builds Sphinx docs on every push/PR to `main`; deploys to GitHub Pages only on push to `main`
  - Uses `uv` with Python 3.10, installs `.[docs]`, runs `patch_matlabdomain.py`, then `sphinx-build`
  - `actions/checkout@v6`, `astral-sh/setup-uv@v7`, `actions/configure-pages@v5`, `actions/upload-pages-artifact@v4`, `actions/deploy-pages@v4`
- **`typos.yaml`**: Checks spelling on every push/PR to `main` using `uvx typos`
- **MATLAB tests**: Run via `matlab-actions/run-command@v2` with `addpath(genpath("hedmat")), addpath(genpath("tests")), run_tests`

## Key principles

### 1. MATLAB code standards

- Use clear, descriptive function and variable names
- Include comprehensive doc comments using `%%` section markers
- Follow MATLAB naming conventions: camelCase for functions, UPPER_CASE for constants
- Include examples in function documentation
- Test MATLAB functions with the unit test framework in `tests/`

### 2. HED annotation standards

- HED uses hierarchical vocabulary organized in tag trees
- Tags are case-sensitive and use forward slashes for hierarchy (e.g., `Sensory-event/Visual/Color/Red`)
- Groups use parentheses for semantic association
- Definitions allow reusable annotation patterns with placeholders

### 3. Documentation standards

- Write technical documentation for advanced MATLAB users
- Include code examples with proper MATLAB syntax
- Use Sphinx-generated API documentation for auto-documented functions
- Link to external HED resources: [HED Tags](https://www.hedtags.org)

### 4. Testing standards

- Unit tests are in `tests/` as MATLAB files following the `Test*.m` naming convention
- Use MATLAB's unit testing framework; test both valid and invalid inputs

### 5. File organization

- **`hedmat/`**: Main MATLAB code (tools, utilities, web service demos)
- **`hedmat/hedtools/`**: HED tool wrappers and interfaces
- **`hedmat/web_services_demos/`**: Examples using HED web services
- **`hedmat/remodeling_demos/`**: Event remodeling examples
- **`hedmat/utilities/`**: Helper functions for common operations
- **`docs/`**: Sphinx documentation source (markdown and `.rst`); source root is `docs/`
- **`docs/_static/`**: Static assets, images, and data examples
- **`tests/`**: MATLAB unit test files
- **`.status/`**: Development notes and local environment config
- **`data/`**: Sample data and schema files for demonstrations

## Common tasks

### When writing documentation

- Follow the structure in existing markdown files in `docs/`
- Use proper markdown heading hierarchy and sentence case for all headers
- Include code blocks with `matlab` language tag for MATLAB examples
- Include code blocks with `hed` language tag for HED annotation examples
- Reference the current specification version (3.3.0)

### When writing MATLAB code

- Document functions with `%%` section headers including syntax, input, output, and examples
- Include error handling for invalid inputs
- Test code with the unit test framework

### When writing Python helper scripts

- Use type hints for function parameters and return values
- Include docstrings for modules, classes, and functions
- Handle file paths using `pathlib.Path` for cross-platform compatibility

### When working with HED schema

- HED schema files are XML with `.xml` extension; format: `HED{major}.{minor}.{patch}.xml`
- Latest stable schema: https://raw.githubusercontent.com/hed-standard/hed-schemas/main/standard_schema/hedxml/HEDLatest.xml

## Important conventions

### HED syntax examples

- Use backticks for inline HED tags: `Sensory-event`
- Use code blocks with `hed` language tag for multi-line HED strings
- Show both short form (e.g., `Red`) and long form (e.g., `Property/Sensory-property/.../Red`)

### MATLAB code examples

- Use proper MATLAB syntax highlighting in markdown
- Include complete working examples where possible
- Reference related functions using full path names

### Version references

- Always specify which specification version introduces or modifies features
- Distinguish between specification version (3.x.x) and schema version (8.x.x)

## Avoid

- Don't modify HED schema XML files in `data/schema_data/` (these are for reference)
- Don't introduce breaking changes to MATLAB function signatures without discussion
- Don't use ambiguous or informal language in documentation
- Don't commit the `.venv` virtual environment to version control (it's in `.gitignore`)
- Don't use title case for markdown headers

## Related resources

- [HED specification (ReadTheDocs)](https://hed-specification.readthedocs.io)
- [HED resources](https://www.hedtags.org/hed-resources)
- [HED schemas repository](https://github.com/hed-standard/hed-schemas)
- [HED standard organization](https://github.com/hed-standard)
- [HED tags website](https://www.hedtags.org)
- [MATLAB documentation](https://www.mathworks.com/help/matlab/)
- [Sphinx documentation](https://www.sphinx-doc.org/)

______________________________________________________________________

*This file provides context for GitHub Copilot to better assist with hed-matlab development.*
