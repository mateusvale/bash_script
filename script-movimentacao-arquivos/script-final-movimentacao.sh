#!/bin/bash

movimentacao="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao/"
local_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao/IDs"
local_non_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao/NON_IDs"

nome_do_arquivo () { #function - ira pegar o nome do arquivo, sem extensao

    #echo ${movimentacao##*.}
    arquivo=$movimentacao$1
    nome_com_extensao=${arquivo##*/}
    #echo ${nome_com_extensao%.*}
    nome_sem_extensao=${nome_com_extensao%.*}

}

for File in $(find $movimentacao -type f -amin +10)
    do
        nome_do_arquivo $File 
        if [[ $nome_sem_extensao =~ ^[0-9]+$ ]] #ira verificar se o nome contem apenas numeros
        then
            cp $File $local_id
        else
            cp $File $local_non_id
        fi
    done