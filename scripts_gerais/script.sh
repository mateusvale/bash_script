#!/bin/bash

folder="/home/mateus/Desktop/pasta_testes"

NUM_ARQUIVOS=$(ls $folder | wc -l)
echo "A quantidade de arquivos que estão na pasta $folder é $NUM_ARQUIVOS"


