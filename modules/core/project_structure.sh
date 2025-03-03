#!/bin/bash

setup_project_structure() {
  log_step "Setting up project structure"

  log_info "Creating standard folder structure..."

  # Create main directories
  mkdir -p src/app
  mkdir -p src/assets/styles
  mkdir -p src/assets/images
  mkdir -p src/components
  mkdir -p src/config
  mkdir -p src/features
  mkdir -p src/hooks
  mkdir -p src/lib
  mkdir -p src/tests
  mkdir -p src/types
  mkdir -p src/utils

  # Add placeholder files to keep directories in git
  touch src/app/.gitkeep
  touch src/assets/styles/.gitkeep
  touch src/assets/images/.gitkeep
  touch src/components/.gitkeep
  touch src/config/.gitkeep
  touch src/features/.gitkeep
  touch src/hooks/.gitkeep
  touch src/lib/.gitkeep
  touch src/tests/.gitkeep
  touch src/types/index.ts
  touch src/utils/index.ts

  # Delete and recreate the public directory
  rm -rf public
  mkdir public
  touch public/.gitkeep

  log_success "Standard project structure created successfully"
}