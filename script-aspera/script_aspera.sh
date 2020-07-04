#!/bin/bash

origem="/home/mateus/fabricas-de-scripts/script-aspera/origem"
destino="/home/mateus/fabricas-de-scripts/script-aspera/destino"

NUM_ARQUIVOS_ORIGEM=$(ls $origem | wc -l)   #Quantidade de arquivos no folder de origem
NUM_ARQUIVOS_DESTINO=$(ls $destino | wc -l) #Quantidade de arquivos no folder de destino

count=0         #Servira para contar o terceiro elemento
EXECUCAO=0      #se for 1 quer dizer que pode mover o conteudo no final

if [ $NUM_ARQUIVOS_ORIGEM -ge 3 -a $NUM_ARQUIVOS_DESTINO = 0 ]; then
    EXECUCAO=1
    
    for File in $(ls -tr $origem)      #Vai varrer um arquivo por vez, do primeiro a entrar até o ultimo
    do
        #echo $File
        #$((++count))
        let count=$count+1              #somar o count
        if [ $count = 3 ]; then
            #echo $File
            ARQUIVO_MANDAR=$File        #Pegar o terceiro arquivo
        fi
    done
fi

if  [ $EXECUCAO = 1 ]; then

    echo $ARQUIVO_MANDAR
    ORIGEM_ARQUIVO="$origem/$ARQUIVO_MANDAR"    #Pegar o caminho da midia que será movida
    echo $ORIGEM_ARQUIVO
    mv $ORIGEM_ARQUIVO $destino                 #mover o arquivo
fi

#echo $count

#for File in $(ls -tr)
#do
#    echo $File
#done