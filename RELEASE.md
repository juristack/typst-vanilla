# Release Process for Vanilla Typst Package

This document outlines the process for creating a new release of the Vanilla Typst package and publishing it to the [typst/packages](https://github.com/typst/packages) repository.

## Prerequisites

Before creating a release, ensure that:

1. Your code changes are completed and tested
2. The version number in `typst.toml` follows [Semantic Versioning](https://semver.org/)
3. The `README.md` is up-to-date with the latest usage examples
4. You have updated the `CHANGELOG.md` (if applicable)

## Release Steps

### 1. Validate Your Package

Run the validation script to ensure your package meets all requirements:

```bash
./scripts/validate-package.sh
```

Fix any issues reported by the validation script before proceeding.

### 2. Test Locally

Test your package locally using the just command:

```bash
just install-preview
```

Create a test document that imports your package from the preview namespace and verify that everything works correctly:

```typst
#import "@preview/vanilla:0.1.1": vanilla

#show: vanilla.with(
  body-line-spacing: "double"
)

= Test Document
This is a test of the vanilla package.
```

### 3. Create and Push a Tag

Once you're satisfied that the package works correctly:

1. Create a git tag with the same version as in `typst.toml`, prefixed with "v":

```bash
git tag v0.1.0  # Replace with your version
```

2. Push the tag to GitHub:

```bash
git push origin v0.1.0
```

### 4. Monitor the GitHub Action

The GitHub Action will be triggered automatically when you push the tag. You can monitor its progress in the "Actions" tab of your GitHub repository.

The action will:
- Validate the package
- Package the files using the justfile
- Create a pull request to the typst/packages repository

### 5. Review the Pull Request

Once the GitHub Action completes, it will create a pull request in the typst/packages repository. The Typst team will review your submission and may provide feedback or request changes.

### After Approval

After your package is approved and merged:
- It will be available to all Typst users via `#import "@preview/vanilla:0.1.1"`
- It will appear in the [Typst Universe](https://typst.app/universe/)

## Troubleshooting

If the GitHub Action fails:
- Check the error message in the action logs
- Make sure your package passes all validation checks
- Ensure the version in typst.toml matches the tag version
- Verify that all required files are present and correctly formatted

## Future Releases

For future releases, simply update the version in `typst.toml` and create a new tag following the same process.
