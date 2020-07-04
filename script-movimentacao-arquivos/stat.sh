#!/bin/bash

movimentacao="/home/mateus/Downloads"

arquivo="/home/mateus/Downloads/ubuntu-20.04-desktop-amd64 1.iso"
# arquivo="/home/mateus/Downloads/ubuntu-20.04-desktop-amd64\ 1.iso"
#arquivo=$(echo "/home/mateus/Downloads/ubuntu-20.04-desktop-amd64 1.iso")
#arquivo=$(printf "/home/mateus/Downloads/ubuntu-20.04-desktop-amd64 1.iso")
echo $arquivo
echo $(stat -c %s "$arquivo")
