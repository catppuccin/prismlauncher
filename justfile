_default:
  @just --list

clean:
  rm -rf upstream themes

build: clean
  whiskers templates/theme.tera

build-upstream: build
  #!/usr/bin/env bash
  whiskers templates/upstream.tera
  for flavor in $(whiskers --list-flavors -o plain); do
    upstream_dir="upstream/Catppuccin-${flavor^}"
    cp "assets/$flavor.png" "$upstream_dir/preview.png"
    cp themes/catppuccin-$flavor-mauve/* "$upstream_dir/"
  done

[unix]
install: build
  cp -r themes/* ~/.local/share/PrismLauncher/themes/
