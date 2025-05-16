# GitHub Action for Typst Package Publishing

This repository includes GitHub Actions for:

1. **Validation** - Runs on every push and PR to validate the package.
2. **Publishing** - Creates a PR to typst/packages when a version tag is pushed.

## Quick Start

To publish a new version:

1. Update the version in `typst.toml`
2. Run `./scripts/validate-package.sh` to check everything
3. Create and push a tag: `git tag v0.1.0 && git push origin v0.1.0`
4. GitHub Action will create a PR to github.com/typst/packages

## Action Details

The publishing action:
- Validates your package and version
- Packages files using your justfile
- Creates a PR to typst/packages with proper formatting

## Troubleshooting

If the action fails, check:
- Action logs in the GitHub UI
- Whether your package passes validation
- If all required files exist and are formatted correctly

For more details, see [RELEASE.md](RELEASE.md).
