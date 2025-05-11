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

# enumerate all the files in the current directory except hidden dotfiles and
# what is listed in .typstignore
files := `find . -type f | grep -v '^\./\.' | while read file; do \
    ignored=false; \
    if [ -f ".typstignore" ]; then \
        while IFS= read -r pattern || [[ -n "$pattern" ]]; do \
            if [[ -n "$pattern" && "$pattern" != "#"* && "$file" =~ $pattern ]]; then \
                ignored=true; \
                break; \
            fi; \
        done < .typstignore; \
    fi; \
    if [[ "$ignored" == "false" ]]; then \
        echo "${file#./}"; \
    fi; \
done`

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
            cp "$file" "{{target}}/$file"; \
            echo "Copied $file"; \
        fi \
    done
    @echo "Installed to {{target}}"

# install for pre-release testing in @preview
install-preview: (package preview_target_path)

# remove @preview pre-release testing folder
uninstall-preview:
    rm -rf {{preview_target_path}}

# clean the "target" folder
clean:
    rm -rf ./target

