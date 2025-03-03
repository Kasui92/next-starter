#!/bin/bash

install_additional_dependencies() {
  log_step "Installing additional dependencies"

  ################
  # ADD HERE YOUR ADDITIONAL DEPENDENCIES
  ################

  # Always install prettier
  log_info "Adding Prettier..."
  $dev_install_cmd prettier eslint-plugin-prettier eslint-config-prettier prettier-plugin-tailwindcss

  log_success "Dependencies installed successfully"
}