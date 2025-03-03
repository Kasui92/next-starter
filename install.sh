#!/bin/bash

# Import base utilities
source "$(dirname "$0")/lib/colors.sh"
source "$(dirname "$0")/lib/logging.sh"
source "$(dirname "$0")/lib/utils.sh"
source "$(dirname "$0")/lib/ascii.sh"
source "$(dirname "$0")/lib/prompts.sh"

# Determine if running with sudo privileges
check_sudo() {
  if [ "$(id -u)" -ne 0 ]; then
    log_error "Administrative privileges required"
    log_warning "Please execute: sudo $0"
    exit 1
  fi
}

# Determine the operating system
detect_os() {
  if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    echo "linux"
  elif [[ "$OSTYPE" == "darwin"* ]]; then
    echo "macos"
  else
    echo "unknown"
  fi
}

# Check if already installed
check_if_installed() {
  if [ -f "/usr/local/bin/next-starter" ]; then
    local current_link=$(readlink "/usr/local/bin/next-starter")

    log_warning "Next-Starter is already installed"

    if [ "$current_link" == "$FULL_SCRIPT_PATH" ]; then
      log_info "The current installation points to the same script"

      # Default is "n", so should return false (1) unless user explicitly says yes
      if prompt_yes_no "Do you want to reinstall?" "n"; then
        log_info "Proceeding with reinstallation..."
        echo ''
      else
        log_info "Installation cancelled"
        exit 0
      fi
    else
      log_warning "Current installation points to: $current_link"

      # Default is "n", so should return false (1) unless user explicitly says yes
      if prompt_yes_no "Do you want to overwrite with this version?" "n"; then
        log_info "Proceeding with installation..."
        echo ''
      else
        log_info "Installation cancelled"
        exit 0
      fi
    fi
  fi
}

OS=$(detect_os)

# Get the absolute path of the script
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_NAME="next-starter.sh"
FULL_SCRIPT_PATH="$SCRIPT_PATH/$SCRIPT_NAME"

# Display ASCII art and welcome message
display_header
log_step "Next-Starter Installer"
log_info "Making Next-Starter available system-wide"
echo ''

# Check for sudo privileges
check_sudo

# Check if already installed
check_if_installed

# Verify that the main script exists
if [ ! -f "$FULL_SCRIPT_PATH" ]; then
  log_error "$SCRIPT_NAME not found in $SCRIPT_PATH"
  exit 1
fi

# Make the script executable
chmod +x "$FULL_SCRIPT_PATH"

# Load OS-specific installation module
source "$SCRIPT_PATH/lib/install_os.sh"

# Run the installation based on the operating system
case $OS in
  "linux")
    install_on_linux "$FULL_SCRIPT_PATH"
    ;;
  "macos")
    install_on_macos "$FULL_SCRIPT_PATH"
    ;;
  *)
    log_error "Unsupported operating system: $OS"
    log_warning "Manual installation required: create a symbolic link to the executable"
    exit 1
    ;;
esac

# Uninstallation instructions
echo -e "\n${YELLOW}To uninstall:${NC}"
echo "sudo rm /usr/local/bin/next-starter"

log_step "Usage"
echo "next-starter [path]"
echo "  • Without path: Creates project in current directory"
echo "  • With path: Creates project in the specified directory"
