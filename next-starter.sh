#!/bin/bash

# Get the directory where the script is installed
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Default paths and argument handling
DEFAULT_INSTALL_PATH="$(pwd)"
INSTALL_PATH="${1:-$DEFAULT_INSTALL_PATH}"

# Import base utilities - using absolute paths
source "$SCRIPT_DIR/lib/colors.sh"
source "$SCRIPT_DIR/lib/logging.sh"
source "$SCRIPT_DIR/lib/utils.sh"
source "$SCRIPT_DIR/lib/ascii.sh"
source "$SCRIPT_DIR/lib/prompts.sh"

# Import core functionality - using absolute paths
source "$SCRIPT_DIR/modules/core/project_generator.sh"
source "$SCRIPT_DIR/modules/core/project_dependencies.sh"
source "$SCRIPT_DIR/modules/core/project_structure.sh"
source "$SCRIPT_DIR/modules/core/project_history.sh"

# Import configuration modules - using absolute paths
source "$SCRIPT_DIR/modules/config/setup.sh"
source "$SCRIPT_DIR/modules/config/templates.sh"

# Function to handle path validation and creation
setup_install_path() {
  log_info "Installation path: $INSTALL_PATH"

  # Check if path exists
  if [ ! -d "$INSTALL_PATH" ]; then
    log_warning "Directory does not exist. Creating it now..."
    mkdir -p "$INSTALL_PATH"

    if [ $? -ne 0 ]; then
      log_error "Failed to create directory: $INSTALL_PATH"
      exit 1
    fi

    log_success "Directory created: $INSTALL_PATH"
  fi

  # Navigate to the installation path
  cd "$INSTALL_PATH"; echo || exit 1
}

# Start the script
display_header
display_header_subtitle

# Show the provided path or default
if [ "$INSTALL_PATH" = "$DEFAULT_INSTALL_PATH" ]; then
  log_info "No installation path provided. Using current directory."
else
  log_info "Using provided installation path: $INSTALL_PATH"
fi

# Setup the installation path
setup_install_path

# Continue with the rest of the script
get_project_configuration
validate_environment
create_project
setup_project_structure
install_additional_dependencies
apply_configurations
restart_git_history
finalize_project