os := `cat /etc/os-release | grep "^NAME=" | cut -d "=" -f2 | tr -d '"'`

default:
  just --list

install-deps:
  #!/bin/bash
  if [ "{{os}}" = "Debian GNU/Linux" ] || [ "{{os}}" = "Ubuntu" ]; then
    sudo add-apt-repository ppa:keyd-team/ppa
    sudo apt-get update
    sudo apt-get install keyd
  elif [ "{{os}}" = "Arch Linux" ]; then
    sudo pacman -S keyd
  fi
  sudo systemctl enable keyd --now

install: install-deps

config:
  mkdir -p /etc/keyd
  sudo stow -t /etc/keyd .
  sudo systemctl restart keyd

unset-config:
  sudo stow -D -t /etc/keyd .
  sudo systemctl restart keyd
