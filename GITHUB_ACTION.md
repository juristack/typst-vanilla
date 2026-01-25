# GitHub Actions for Typst Package Publishing

This repository includes GitHub Actions for automated package validation and publishing.

## What's Included

1. **GitHub Action Workflows**:
   - `.github/workflows/typst-publish.yml` - Creates a PR to typst/packages when a tag is pushed
   - `.github/workflows/validate.yml` - Validates the package on every push and PR

2. **Documentation**:
   - `RELEASE.md` - Detailed release process guide
   - `CHANGELOG.md` - Track changes between versions

3. **Validation Script**:
   - `validate-package.sh` - Checks that your package meets all requirements

## Quick Start

To publish a new version:

1. Update the version in `typst.toml`
2. Run `./scripts/validate-package.sh` to check everything
3. Create and push a tag: `git tag v0.1.0 && git push origin v0.1.0`
4. GitHub Action will create a PR to github.com/typst/packages

## How It Works

The publishing action:
- Validates your package and version
- Packages files using your justfile
- Creates a PR to typst/packages with proper formatting

## Important Notes

- The GitHub Action uses the `peter-evans/create-pull-request` action which requires `GITHUB_TOKEN` permissions
- For full functionality, make sure your repository has proper permissions configured
- The workflow uses your `justfile` to package the files before submission

## Troubleshooting

If the action fails, check:
- Action logs in the GitHub UI
- Whether your package passes validation
- If all required files exist and are formatted correctly

For more details, see [RELEASE.md](RELEASE.md).
