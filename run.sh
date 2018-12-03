#!/bin/bash

set -e

# Make the folder of the file if it doesn't exist
function dirmk
{
  dirPath=$(dirname ${1})
  if [ ! -d ${dirPath} ]; then
    mkdir ${dirPath}
  fi
}

# Make a symlink pointing to these environment files
# No destination assumes that we want to keep the path structure and our
# files to the home directory
function plink
{
  src="${1}"
  dst="${2}"

  if [ ! -f "${src}" ]; then
    echo "Error: Could not find: ${src}"
    exit
  fi

  if [ -z "${dst}" ]; then
    dst="${HOME}/${src}"
  fi

  # Back up origianl files
  if [[ -f ${dst} && ! -f "${dst}.orig" ]]; then
    cp -p "${dst}" "${dst}.orig"
  fi

  if [ -f "${dst}" ]; then
    rm ${dst}
  fi

  dirmk $dst
  ln -sfr "${src}" "${dst}"
}

function setupenv
{
  plink .vimrc
  plink .gvimrc
  plink .bashrc
  plink .inputrc

  plink .vim/iroPlugin.vim
  plink .vim/thirdPartyPlugin.vim

  plink scripts/bashTemplate
  plink scripts/cygwin.bashrc.sh

}

setupenv
source ~/.bashrc
