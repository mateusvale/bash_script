#!/bin/bash

mapeamento="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/mapeamento_com_espaco.txt"    #local onde se estocará todos os conteudos da pasta
movimentacao="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos"   #local onde estao os arquivos
local_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/IDs"   #local de repositorio do txt de ids
local_non_id="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/NON_IDs"   #local de repositorio do txt de nao ids

countID=0
countNONID=0
find $movimentacao -maxdepth 1 -type f -amin +10 >> $mapeamento 
sed -i 's*/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/**g' $mapeamento

echo "pasta:;$movimentacao" >> $local_id/excel_ids.csv
echo "tipo:;IDs" >> $local_id/excel_ids.csv
echo "pasta:;$movimentacao" >> $local_non_id/excel_nonids.csv
echo "tipo:;Não IDs" >> $local_non_id/excel_nonids.csv

while read linha;     
do 
    nome_sem_extensao=${linha%.*} #tirou a extensao do arquivo
    if [[ $nome_sem_extensao =~ ^[0-9]+$ ]] #ira verificar se o nome contem apenas numeros
        then
            let countID=$countID+1
            echo "$countID;$linha" >> $local_id/excel_ids.csv
        else
            let countNONID=$countNONID+1
            echo "$countNONID;$linha" >> $local_non_id/excel_nonids.csv
        fi
    
done < $mapeamento

#echo A quantidade de arquivos são $countID >> $local_id/quantidade_ids.txt
#echo A quantidade de arquivos são $countNONID >> $local_non_id/quantidade_nonids.txt
:> $mapeamento
