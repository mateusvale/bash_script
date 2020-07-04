#!/bin/bash

#localizacao de arquivos
mapeamento="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/mapeamento_com_espaco.txt"    #local onde se estocará todos os conteudos da pasta
movimentacao="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos"   #local onde estao os arquivos
local_id="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/IDs/excel_ids_extensao.csv"   #local de repositorio do txt de ids
local_non_id="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/NON_IDs/excel_nonids_extensao.csv"   #local de repositorio do txt de nao ids

#contadores
countID=0
countNONID=0

#Fara uma verificacao de arquivos na pasta e depois ira inserir os nomes dos conteudos em um arquivo .txt
find $movimentacao -maxdepth 1 -type f -amin +10 >> $mapeamento

#Ira retirar o caminho do arquivo de cada linha, deixando apenas o nome do arquivo
sed -i 's*/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/**g' $mapeamento

#Escrito em cada celula com arquivos tipo ID
echo "pasta:;$movimentacao" >> $local_id
echo "tipo:;IDs" >> $local_id
echo "Quantidade de arquivos;Arquivo;Nome do arquivos;Tamanho;Extensao" >> $local_id

#Escrito em cada celula com arquivos tipo NAO ID
echo "pasta:;$movimentacao" >> $local_non_id
echo "tipo:;Não IDs" >> $local_non_id
echo "Quantidade de arquivos;Arquivo;Nome do arquivos;Tamanho[GB];Extensao" >> $local_non_id

while read linha;     
do
    nome_sem_extensao=${linha%.*} #tirou a extensao do arquivo
    extensao=${linha##*.}
    tamanho=$(printf '%.*f\n' 7 $(echo "$(echo "$(stat -c %s $movimentacao/$linha)/1000000000" |bc -l)" | tr "." ",")) #pega o tamanho do arquivo e coloca em GB com 7 casas decimais
    tamanho=$(echo "$tamanho" | tr "," ".")
    if [[ $nome_sem_extensao = $extensao ]]
    then
        extensao="n/a"
    fi
    if [[ $nome_sem_extensao =~ ^[0-9]+$ ]] #ira verificar se o nome contem apenas numeros
        then
            let countID=$countID+1
            echo "$countID;$linha;$nome_sem_extensao;$tamanho;$extensao" >> $local_id
        else
            let countNONID=$countNONID+1
            echo "$countNONID;$linha;$nome_sem_extensao;$tamanho;$extensao" >> $local_non_id
        fi
    
done < $mapeamento

:> $mapeamento
