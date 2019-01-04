#!/bin/env bash
rsync_with_cloud.sh $crypto_key fedora_vm.rwc .ssh .vim .vimrc .Xdefaults .Xresources .bash_profile .bashrc
git config --global --replace-all user.email dsopscak@gmail.com 
git config --global --replace-all  user.name "Skip Sopscak"
