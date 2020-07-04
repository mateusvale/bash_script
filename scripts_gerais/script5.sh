#!/bin/bash
dirname="/home/mateus/Desktop/pasta_testes"

NUM_ARQUIVOS=$(ls $dirname | wc -l)

if [ $NUM_ARQUIVOS = 4 ]; then
    echo "Opa, tem 5 arquivos na pasta"
    $(touch "$dirname/arquivonovo.sh")
else
    echo "nao tem 5 arquivos"
fi
