movimentacao="/home/mateus/fabricas-de-scripts/script-movimentacao-arquivos/movimentacao";

num_arquivos=20;

for ((a=1; a <= num_arquivos ; a++ ));
do
    arquivo="$movimentacao/teste$a.txt"
    touch $arquivo
    chmod 774 $arquivo
done

