#!/bin/bash

# Color variables

BOLD="\e[1m"

LIGHT_RED="\e[91m"
LIGHT_GREEN="\e[92m"
LIGHT_MAGENTA="\e[95m"
LIGHT_CYAN="\e[96m"

RESET="\e[0m"

# Functions

error() {
  echo -e "\n${LIGHT_RED}$1"
  echo -e "Exiting...${RESET}"
  echo -e "\n"
  exit 1
}

verify_execution() {
  echo -e "\n$1 [y/${BOLD}${LIGHT_CYAN}N${RESET}]"

  read verification

  verification=${verification,,}

  if [[ $verification != "y" ]] && [[ $verification != "yes" ]];
  then 
      error "Aborted mission."
  fi
}

print_command() {
  echo -e "\n${LIGHT_GREEN}❯ $1${RESET}"
}

# Header

echo -e "\n"
echo -e "${BOLD}${LIGHT_GREEN}NPM PACKAGE PUBLISH SCRIPT${RESET}"

# Verifications

case $1 in
  "patch" | "minor" | "major")
    if [[ $2 ]] 
    then
      error "More than one argument was passed."
    fi

    echo -e "\n${BOLD}You chose to publish a ${BOLD}${LIGHT_RED}${1^^}${RESET} ${BOLD}release.${RESET}"

    echo -e "${LIGHT_MAGENTA}Please, before proceeding, create a commit in case there are any pending changes.${RESET}"
    
    sleep 5

    verify_execution "Do you wish to continue?"

    verify_execution "Are you ${BOLD}really sure${RESET} you want to do this???"

    echo -e "\n${BOLD}I really hope you know what you're doing.${RESET}"
  ;;
  "")
    error "No arguments found."
  ;;
  *)
    error "Unrecognized argument."
  ;;
esac

# Reloa specific code

# git checkout next
# git add .
# git commit -m "Pre-Publish Commit"
# git checkout main
# git merge next
# git pull
# git push

# General code

print_command "npm ci"
npm ci

print_command "npm run build"
npm run build

print_command "npm version $1"
npm version $1

print_command "npm publish"
npm publish

print_command "git push"
git push

print_command "git push --tags"
git push --tags

echo -e "\n"
