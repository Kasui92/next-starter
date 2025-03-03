#!/bin/bash

display_header() {
  clear
  echo -e "${CYAN}"
  echo -e "  _   _           _      _____ _             _           "
  echo -e " | \ | |         | |    / ____| |           | |          "
  echo -e " |  \| | _____  _| |_  | (___ | |_ __ _ _ __| |_ ___ _ __"
  echo -e " | . \` |/ _ \ \/ / __|  \___ \| __/ _\` | '__| __/ _ \ '__|"
  echo -e " | |\  |  __/>  <| |_   ____) | || (_| | |  | ||  __/ |  "
  echo -e " |_| \_|\___/_/\_\\\\__| |_____/ \__\__,_|_|   \__\___|_|  "
  echo -e "                                                         "
  echo -e "${NC}"
}

display_header_subtitle() {
  echo -e "${CYAN}=== 🚀 Next.js Project Starter 🚀 ===${NC}"
  echo -e "${YELLOW}Create a modern Next.js app with some (${BOLD}absolutely unsolicited and completely questionable${NC}${YELLOW}) opinions.${NC}"
  echo ""
}