#!/usr/bin/env bash

WORKING_DIR=~/.dotfiles
BACKUP_DIR="$WORKING_DIR/.backup"

# Create a backup folder where all existing dotfiles will be saved to
mkdir -p $BACKUP_DIR

BACKUP_DIR=~/.dotfiles/.backup
# Create a backup folder where all existing dotfiles will be saved to
mkdir -p $BACKUP_DIR

checkOs() {
	if [[ "$(uname)" == "Darwin" ]]; then
		return 0
	else
		return 1
	fi
}

checkRuntime() {
	if [[ ! checkOs ]]; then
		echo "Unsupported OS"
		exit 1
	fi

	if [[ -z "$BASH_VERSINFO" ]]; then
		echo "Please run the script in bash"
		exit 0
	fi

	local BASH_VERSION_PARSED

	BASH_VERSION_PARSED=$(echo "$BASH_VERSION" | grep -Eo '[0-9]+\.[0-9]+')

	if [[ "${BASH_VERSION_PARSED:-0}" -le 5 ]]; then
		echo "Bash version is too old. Please upgrade to v5 or higher."
		exit 1
	fi
}

installPackageManager() {
	# Install brew if needed
	if (!(isPackageInstalled "brew")); then
		echo "Installing brew ..."
		bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	fi
}

bootstrap() {
	installPackageManager

  if [[ ! -d ~/.config ]]; then
    mkdir -p ~/.config
  fi

  if (!(isPackageInstalled "stow")); then
    installPackage "stow"
  fi
}

isPackageInstalled() {
	test $(type -t "$1") || brew list -q -1 "$1" 2>/dev/null
}

installPackage() {
	brew install "$1"
}

installPackages() {
	local -n packages_ref=$1
	local packages_to_install=""

	for c in "${!packages_ref[@]}"; do
		if ( ! (isPackageInstalled "$c")); then
			if [[ -n "$packages_to_install" ]]; then
				packages_to_install="$packages_to_install ${packages_ref[$c]}"
			else
				packages_to_install="${packages_ref[$c]}"
			fi
		fi
	done

	if [[ -n "$packages_to_install" ]]; then
		installPackage $packages_to_install
	fi
}

createSimlink() {
	# $source should be either a full path or a relative path under ~/.dotfiles
	local source="$1"
	local target="$2"

	# If no target is provided - use the name of the source
	if [[ -z "$target" ]]; then
		target="~/.$source"
	fi

	if [[ $source != *"$WORKING_DIR"* ]]; then
		source="${WORKING_DIR}/${source}"
	fi

	if [[ ! -L "$target" && -e "$source" ]]; then
		local target_dir=$(dirname $target)

		if [[ -e "$target" && -f "$target" ]]; then
			mv $target $BACKUP_DIR &>/dev/null
		fi

		if [[ ! -d "$target_dir" ]]; then
			mkdir -p $target_dir
		fi

		ln -sf $source $target
	fi
}
