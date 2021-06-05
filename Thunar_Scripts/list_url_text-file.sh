#!/bin/bash
# Lista URL de arquivo TXT
# Requer Zenity

# argumentos de entrada
arg="$@"
script=$(basename $0)
today=$(date +%Y-%m-%d)

# Checar argumento
if [[ "$arg" = "" ]]; then
    echo "Empty argument!" >> /tmp/"log-$script-$today"
    zenity --info --text="Select Files!"
    exit 0
fi

# Detalhes iniciais
elements="$#"
local=$(dirname $1)
ext_array=("TXT txt")

# Confirmando ação
zenity --question \
--title="Script" \
--text="Execute: $script" \
--ok-label="Yes" \
--cancel-label="No"
temp=$?

if [[ $temp -eq 1 ]]; then
      exit 0
fi

# Escrevendo arquivo de log
echo "Started [ $(date '+%Y-%m-%d %H:%M:%S') ]." > /tmp/"log-$script-$today"

# Percorrendo os argumentos de entrada
for arg
do
    # argumento
    size=${#arg}
    count=$size

    # Procurando extensão
    while [[ $count -ge 0 ]]; do
        if [[ ${arg:((--count)):1} = '.' ]]; then
            break;
        fi
    done

    # Checar extensão
    ext_temp="${arg:count:size - count}"
    for ext in ${ext_array[@]}; do
        if [[ $ext_temp == ".$ext" ]]; then
            echo "file: $arg OK" >> /tmp/"log-$script-$today"
            # nome do arquivo
            last=$count
            while [[ $count -ge 0 ]]; do
                if [[ ${arg:((--count)):1} = '/' ]]; then
                    break;
                fi
            done
            name="result_url_${arg:count + 1:last - count - 1}.txt"
            # extrair url
            perl -ne 's#.*(https*://[^"]*).*#\1# && print' $arg > $name
            echo "saved: $name"
        fi
    done
done

echo "Finished [ $(date '+%Y-%m-%d %H:%M:%S') ]." >> /tmp/"log-$script-$today"
exit 0