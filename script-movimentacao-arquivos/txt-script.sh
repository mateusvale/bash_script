#!/bin/bash

mapeamento="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/mapeamento_com_espaco.txt"    #local onde se estocará todos os conteudos da pasta
movimentacao="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos"   #local onde estao os arquivos
local_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/IDs"   #local de repositorio do txt de ids
local_non_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/NON_IDs"   #local de repositorio do txt de nao ids

countID=0
countNONID=0
find $movimentacao -maxdepth 1 -type f -amin +10 >> $mapeamento 
sed -i 's*/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/**g' $mapeamento

while read linha;     
do 
    nome_sem_extensao=${linha%.*} #tirou a extensao do arquivo
    if [[ $nome_sem_extensao =~ ^[0-9]+$ ]] #ira verificar se o nome contem apenas numeros
        then
            echo $linha >> $local_id/quantidade_ids.txt
            let countID=$countID+1
        else
            echo $linha >> $local_non_id/quantidade_nonids.txt
            let countNONID=$countNONID+1
        fi
    
done < $mapeamento

echo A quantidade de arquivos são $countID >> $local_id/quantidade_ids.txt
echo A quantidade de arquivos são $countNONID >> $local_non_id/quantidade_nonids.txt
:> $mapeamento
