#!/bin/bash

set -u

GIT_CLONE_DESTINATION_ROOT_DIR="${HOME}/.ghq"

GITHUB_REPOSITORY_PATH="github.com/tanishi/dotfiles"

GIT_CLONE_DESTINATION_DIR="${GIT_CLONE_DESTINATION_ROOT_DIR}/${GITHUB_REPOSITORY_PATH}"
DOTFILES_REPOSITORY_URL="https://${GITHUB_REPOSITORY_PATH}"

IGNORE_FILE_LIST_NAME="${GIT_CLONE_DESTINATION_DIR}/etc/ignore_files.txt"

function download_dotfiles() {
  if [ -d $GIT_CLONE_DESTINATION_ROOT_DIR ]; then
    echo "dotfiles already exists"
  else
    git clone $DOTFILES_REPOSITORY_URL $GIT_CLONE_DESTINATION_DIR
  fi
}

function deploy_dotfiles() {
  cd $GIT_CLONE_DESTINATION_DIR

  files=$(find .??* -type f | grep -v -f $IGNORE_FILE_LIST_NAME)
  dirs=$(find .??* -type d | grep -v -f $IGNORE_FILE_LIST_NAME)

  for d in $dirs; do
    echo -p "${HOME}/${d}"
    mkdir -p "${HOME}/${d}"
  done

  for f in $files; do
    echo "${GIT_CLONE_DESTINATION_DIR}/${f}" "${HOME}/${f}"
    ln -s "${GIT_CLONE_DESTINATION_DIR}/${f}" "${HOME}/${f}"
  done
}

download_dotfiles && deploy_dotfiles
