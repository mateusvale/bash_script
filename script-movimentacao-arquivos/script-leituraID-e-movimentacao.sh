#!/bin/bash

movimentacao="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao/"
local_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao/IDs"
local_non_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao/NON_IDs"

nome_do_arquivo () { #ira pegar o nome do arquivo, sem extensao

    #echo ${movimentacao##*.}
    arquivo=$movimentacao$1
    nome_com_extensao=${arquivo##*/}
    #echo ${nome_com_extensao%.*}
    nome_sem_extensao=${nome_com_extensao%.*}

}

for File in $(ls $movimentacao)
    do
        nome_do_arquivo $File 
        if [[ $nome_sem_extensao =~ ^[0-9]+$ ]] #ira verificar se o nome contem apenas numeros
        then
            cp $movimentacao$File $local_id
        else
            cp $movimentacao$File $local_non_id
        fi
    done



# nome_do_arquivo
# #echo $nome_sem_extensao
# if [[ $nome_sem_extensao =~ ^[0-9]+$ ]]
# then
#     echo "ok"
# else
#     echo "no"
# fi