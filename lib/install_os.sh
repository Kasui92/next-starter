#!/bin/bash

# Function to install on Linux
install_on_linux() {
  local script_path="$1"
  log_info "Installing for Linux..."
  echo ''

  # Create a symbolic link in the /usr/local/bin directory
  ln -sf "$script_path" /usr/local/bin/next-starter

  if [ $? -eq 0 ]; then
    log_success "Installation successful!"
    log_info "You can now use 'next-starter [path]' from anywhere."
  else
    log_error "Installation failed. Please check permissions."
    log_warning "Try running: sudo ln -sf \"$script_path\" /usr/local/bin/next-starter"
  fi
}

# Function to install on macOS
install_on_macos() {
  local script_path="$1"
  log_info "Installing for macOS..."
  echo ''

  # Create a symbolic link in the /usr/local/bin directory
  ln -sf "$script_path" /usr/local/bin/next-starter

  if [ $? -eq 0 ]; then
    log_success "Installation successful!"
    log_info "You can now use 'next-starter [path]' from anywhere."
  else
    log_error "Installation failed. Please check permissions."
    log_warning "Try running: sudo ln -sf \"$script_path\" /usr/local/bin/next-starter"
  fi
}