data_dir := if os() == "linux" {
    env_var_or_default("XDG_DATA_HOME", home_directory() / ".local/share")
} else if os() == "macos" {
    home_directory() / "Library/Application Support"
} else {
    env_var("APPDATA")
}

name := `cat typst.toml | grep '^name = ' | cut -d'"' -f2`
version := `cat typst.toml | grep '^version = ' | cut -d'"' -f2`
preview_target_path := data_dir / "typst/packages/preview" / name / version

# List of all files that get packaged
files := '''
    src/
    examples/
    template/
    typst.toml
    LICENSE
    README.md
    CHANGELOG.md
    thumbnail.png
'''

[private]
default:
 @just --list --unsorted

# package the library into the specified destination folder 
package target="target":
    @echo "Package dir: {{target}}"
    @echo "{{files}}" | while IFS= read -r file; do \
        if [ -n "$file" ]; then \
            dir="$(dirname "{{target}}/$file")"; \
            mkdir -p "$dir"; \
            cp -r "$file" "{{target}}/$file"; \
            echo "Copied $file"; \
        fi \
    done
    @echo "Installed to {{target}}"

# install for pre-release testing in @preview
install-preview: (package preview_target_path)

# remove @preview pre-release testing folder
uninstall-preview:
    read -p "Are you sure you want to remove {{preview_target_path}}? [y/N] " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then \
        rm -rf "{{preview_target_path}}"
    fi

# validate the package
validate:
    ./scripts/validate-package.sh

# clean the "target" folder
clean:
    rm -rf ./target

