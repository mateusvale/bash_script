#!/bin/bash

local="/home/mateus/CURSO_UDEMY_JAVASCRIPT/fundamentos/"
arquivo_texto="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/arquivo_texto.txt"

for File in $(find $local -type f -amin +60)
do
    
        echo $File >> $arquivo_texto
    
done