#!/bin/bash

movimentacao="/home/mateus/Downloads/ubuntu-20.04-desktop-amd64 1.iso"

somatotal=10
# tamanho=$(stat -c %s $movimentacao/ubuntu-20.04-desktop-amd64.iso)
# tamanho=$(echo "$tamanho/1000000000" |bc -l) #transforma em GB
# tamanho=$(echo "$(stat -c %s $movimentacao/ubuntu-20.04-desktop-amd64.iso)/1000000000" |bc -l) #transforma em GB
# tamanho=$(echo "$tamanho" | tr "." ",")
# tamanho=$(echo "$(echo "$(stat -c %s "$movimentacao")/1000000000" |bc -l)" | tr "." ",") #os 4 de cima formaram apenas essa linha
# tamanho=$(printf '%.*f\n' 7 $tamanho)

tamanho=$(printf '%.*f\n' 7 $(echo "$(echo "$(stat -c %s "$movimentacao")/1000000000" |bc -l)" | tr "." ","))
echo $tamanho
tamanho=$(echo "$tamanho" | tr "," ".")
somatotal=$(echo $somatotal+$tamanho |bc -l)
#let somatotal=$somatotal+$tamanho
echo $somatotal



