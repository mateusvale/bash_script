#!/bin/bash

dirname="/home/mateus/Desktop/pasta_teste3"
[ -e $dirname ] && echo O diretorio $dirname ja existe || mkdir $dirname 