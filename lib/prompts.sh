#!/bin/bash

# Get user input with a prompt
prompt_user() {
  local prompt="$1"
  local variable_name="$2"
  local default_value="$3"

  echo -e "${YELLOW}${prompt}${NC}"
  if [ -n "$default_value" ]; then
    echo -e "${DIM}Default: $default_value${NC}"
    echo -e "${PURPLE}> ${NC}\c"
    read -r input
    if [ -z "$input" ]; then
      input="$default_value"
    fi
  else
    echo -e "${PURPLE}> ${NC}\c"
    read -r input
  fi

  # Export the variable to the parent shell
  eval "$variable_name=\"$input\""
}

# Get user selection from options
prompt_select() {
  local prompt="$1"
  local variable_name="$2"
  local options=("${@:3}")

  echo -e "${YELLOW}${prompt}${NC}"

  for i in "${!options[@]}"; do
    echo "$((i+1))) ${options[$i]}"
  done

  echo -e "${PURPLE}> ${NC}\c"
  read -r selection

  # Export the selection to the parent shell
  if [ "$selection" -ge 1 ] && [ "$selection" -le "${#options[@]}" ]; then
    eval "$variable_name=\"${options[$((selection-1))]}\""
  else
    log_error "Invalid selection"
    prompt_select "$prompt" "$variable_name" "${options[@]}"
  fi
}

# Prompt for yes/no response
# $1: Question to ask
# $2: Default answer (y/n)
# Returns: 0 for yes, 1 for no
prompt_yes_no() {
  local question=$1
  local default=${2:-y}  # Default to "y" if not provided

  local prompt
  local default_upper

  # Format prompt based on default
  if [[ $default == "y" || $default == "Y" ]]; then
    prompt="$question [Y/n]: "
    default_upper="Y"
  else
    prompt="$question [y/N]: "
    default_upper="N"
  fi

  # Keep asking until we get a valid response
  local answer
  while true; do
    echo -e "${PURPLE}> ${NC}\c"
    read -r -p "$prompt" answer

    # Empty response means use default
    if [[ -z $answer ]]; then
      answer=$default_upper
    fi

    # Check answer and return appropriate value
    case "${answer,,}" in
      y|yes) return 0 ;;
      n|no)  return 1 ;;
      *)     echo "Please answer 'y' or 'n'" ;;
    esac
  done
}