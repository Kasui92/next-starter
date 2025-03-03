#!/bin/bash

# Import colors if not already done
if [ -z "$BLUE" ]; then
  source "$(dirname "$0")/colors.sh"
fi

# Utility functions for logging
log_info() {
  echo -e "${BLUE}🔹 ${NC}${1}"
}

log_success() {
  echo -e "${GREEN}✅ ${NC}${1}"
}

log_warning() {
  echo -e "${YELLOW}⚠️ ${NC}${1}"
}

log_error() {
  echo -e "${RED}❌ ${1}${NC}"
}

log_step() {
  echo -e "\n${CYAN}🔷 ${BOLD}${1}${NC}"
}

log_debug() {
  if [ "$DEBUG" = true ]; then
    echo -e "${DIM}🔍 ${1}${NC}"
  fi
}