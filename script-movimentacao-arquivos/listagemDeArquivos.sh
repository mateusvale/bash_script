#!/bin/bash


###############################################Script de verificação de arquivos###############################################
#Esse script varre uma pasta e verifica todos os arquivos de dentro dela. Será feita uma distinção entre arquivos que são IDs,
#os quais são formados por apenas numeros e arquivos que não são IDs. Será coletado o nome do arquivo, a extensão e o espaço em
#GB. Todas essas informações serão inseridas em um arquivo .csv. 
###############################################################################################################################
#Para utilização desse script, será preciso mudar 4 variaveis:
    #mapeamento
    #movimentacao
    #local_id
    #local_non_id
#E também será preciso mudar o caminho da variavel movimentação no sed (linha 36) e colocar o path da varivale movimentacao (colocando o / no final):
    #sed -i 's*<</home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/>>**g' $mapeamento
###############################################################################################################################

#localizacao de arquivos
mapeamento="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/mapeamento_com_espaco.txt"    #local onde se estocará todos os conteudos da pasta
movimentacao="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos"   #local onde estao os arquivos
local_id="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/IDs/excel_ids_extensao.csv"   #local de repositorio do csv de ids
local_non_id="/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/NON_IDs/excel_nonids_extensao.csv"   #local de repositorio do csv de nao ids

#contadores
countID=0
countNONID=0

#Soma dos arquivos
somaTotal_ID=0
somaTotal_NON_ID=0

#Fara uma verificacao de arquivos na pasta que foram acessados mais de 10min atras e depois ira inserir os nomes dos conteudos em um arquivo .txt
find $movimentacao -maxdepth 1 -type f -amin +10 >> $mapeamento

#Ira retirar o caminho do arquivo de cada linha, deixando apenas o nome do arquivo
sed -i 's*/home/mateus/PROGRAMACAO/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao_com_espacos/**g' $mapeamento

#Escrito em cada celula com arquivos tipo ID
echo "pasta:;$movimentacao" >> $local_id
echo "tipo:;IDs" >> $local_id
# echo "Soma total de arquivos:;$somaTotal_ID=0" >> $local_id
echo "Quantidade de arquivos;Arquivo;Nome do arquivo;Tamanho [GB];Extensao;Observacao" >> $local_id

#Escrito em cada celula com arquivos tipo NAO ID
echo "pasta:;$movimentacao" >> $local_non_id
echo "tipo:;Não IDs" >> $local_non_id
# echo "Soma total de arquivos:;$somaTotal_NON_ID=0" >> $local_non_id
echo "Quantidade de arquivos;Arquivo;Nome do arquivo;Tamanho [GB];Extensao;Observacao" >> $local_non_id

while read linha;     
do
    
    nome_sem_extensao=${linha%.*}  #tirou a extensao do arquivo
    extensao=${linha##*.}          #deixou apenas a extensão do arquivo
    tamanho="$movimentacao/$linha" #pegou o path do arquivo
    tamanho=$(printf '%.*f\n' 7 $(echo "$(echo "$(stat -c %s "$tamanho")/1000000000" |bc -l)" | tr "." ",")) #pega o size do arquivo, coloca em GB, troca os pontos por virgular e coloca com 7 casas decimais. 
    tamanho=$(echo "$tamanho" | tr "," ".") # muda a virgula para ponto pois a virgula é como se fosse um tab no csv
    
    if [[ $nome_sem_extensao = $extensao ]] #se nao existir extensao
    then
        extensao="n/a" 
    fi
    if [[ $nome_sem_extensao =~ ^[0-9]+$ ]] #ira verificar se o nome contem apenas numeros
        then
            let countID=$countID+1
            somaTotal_ID=$(echo $somaTotal_ID+$tamanho |bc -l)
            echo "$countID;$linha;$nome_sem_extensao;$tamanho;$extensao" >> $local_id
        else
            let countNONID=$countNONID+1
            somaTotal_NON_ID=$(echo $somaTotal_NON_ID+$tamanho |bc -l)
            echo "$countNONID;$linha;$nome_sem_extensao;$tamanho;$extensao" >> $local_non_id
        fi
    
done < $mapeamento #será lido esse arquivo

:> $mapeamento #ira apagar o arquivo de mapeamento

echo "" >> $local_id
echo "" >> $local_non_id
echo "Soma total de arquivos [GB]:;$somaTotal_ID" >> $local_id
echo "Soma total de arquivos [GB]:;$somaTotal_NON_ID" >> $local_non_id

