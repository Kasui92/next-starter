#!/bin/bash

# Check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Check if the script is being run from the right directory
check_directory() {
  if [ ! -f "$(dirname "$0")/next-starter.sh" ]; then
    log_error "Please run this script from the main project directory"
    exit 1
  fi
}

# Create a file from a template
create_file_from_template() {
  local template_file="$1"
  local output_file="$2"

  if [ -f "$template_file" ]; then
    cp "$template_file" "$output_file"
    return 0
  else
    log_error "Template file not found: $template_file"
    return 1
  fi
}