#!/bin/bash

get_project_configuration() {
  # Get project name
  prompt_user "📝 Enter your project name:" "project_name"

  if [ -z "$project_name" ]; then
    log_error "Project name is required"
    exit 1
  fi

  # Get project description
  prompt_user "📄 Enter a short project description (optional):" "project_description" "A modern Next.js application"

  # Select package manager
  prompt_select "📦 Select a package manager:" "package_manager_name" "npm" "yarn" "pnpm"

  case "$package_manager_name" in
    "npm")
      package_manager_flag=""
      install_cmd="npm install --save"
      dev_install_cmd="npm install --save-dev"
      ;;
    "yarn")
      package_manager_flag="--use-yarn"
      install_cmd="yarn add"
      dev_install_cmd="yarn add -D"
      ;;
    "pnpm")
      package_manager_flag="--use-pnpm"
      install_cmd="pnpm add"
      dev_install_cmd="pnpm add -D"
      ;;
  esac
}

validate_environment() {
  log_step "Validating environment"

  # Check if Node.js is installed
  if ! command_exists "node"; then
    log_error "Node.js is required but not installed. Please install Node.js and try again."
    exit 1
  fi

  # Check if npx is installed
  if ! command_exists "npx"; then
    log_error "npx is required but not installed. Please install npm (comes with Node.js) and try again."
    exit 1
  fi

  # Check if the selected package manager is installed
  if [ -n "$package_manager_flag" ]; then
    if ! command_exists "${package_manager_name}"; then
      log_error "${package_manager_name} is not installed. Please install it first."
      exit 1
    fi
  fi

  log_success "Environment validation passed"
}

create_project() {
  log_step "Creating Next.js project"

  # Use the selected package manager flag if applicable
  local cmd="npx create-next-app@latest $project_name --typescript --eslint --app --tailwind --no-turbopack --src-dir --import-alias '@/*' $package_manager_flag"

  log_info "Running: $cmd"
  eval $cmd

  if [ $? -ne 0 ]; then
    log_error "Failed to create Next.js project. Please check the error messages above."
    exit 1
  fi

  # Navigate into the project directory
  cd "$project_name" || exit

  log_success "Project created successfully in $(pwd)"
}

finalize_project() {
  echo -e "\n${GREEN}✅ Project initialization complete!${NC}"
  echo -e "${YELLOW}💻 To start developing:${NC}"
  echo -e "${CYAN}cd $project_name${NC}"
  echo -e "${CYAN}${package_manager_name} run dev${NC}"

  echo -e "\n${BLUE}🎉 Happy coding! 🎉${NC}"
}