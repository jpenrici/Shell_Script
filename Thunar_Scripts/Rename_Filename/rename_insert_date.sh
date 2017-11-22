#!/bin/bash
# Insere a data ao final do nome do arquivo
# Requer zenity (Display graphical dialog boxes) instalado
# Teste executado com Bash no Debian

arg="$@"    # argumentos de entrada
today=$(date +%Y-%m-%d)

# Escrevendo arquivo de log
echo "Started [ $(date '+%Y-%m-%d %H:%M:%S') ]." > /tmp/"log-$today"

# Checar argumento
if [[ "$arg" = "" ]]; then
    echo "Empty argument!" >> /tmp/"log-$today"
    gdialog --msgbox "Select Files!"
    exit 0
fi

# Percorrendo os argumentos de entrada
for arg
do
    size=${#arg}
    count=$size
    echo "Renaming: $arg" >> /tmp/"log-$today"

    # Procurando extensão
    while [[ $count -ge 0 ]]; do
        if [[ ${arg:((--count)):1} = '.' ]]; then
            break;
        fi
    done

    # Inserir Data
    if [[ $count -ge 1 ]]; then
        temp="${arg:0:$count}-$today${arg:count:size-count}"
    elif [[ $count -eq 0 ]]; then
        temp="$today$arg"
    else
        temp="$arg-$today"
    fi
    if [[ -f $temp ]]; then
        echo "Error: '$temp' already exists!" >> /tmp/"log-$today"
        gdialog --msgbox "Error: '$temp' already exists!"
    else
        echo "Copying..." >> /tmp/"log-$today"
        cp "$arg" "$temp"
        echo "New: $temp" >> /tmp/"log-$today"
    fi
done

gdialog --title "Remove" --center --stdout --yesno \
"Remove original files (y/n)?" \
0 0

if [[ "$?" = "1" ]]; then
      exit 0
fi

# Remover arquivos
for arg
do
    echo "Removing: $arg" >> /tmp/"log-$today"
    rm "$arg"
done

echo "Finished [ $(date '+%Y-%m-%d %H:%M:%S') ]." >> /tmp/"log-$today"
exit 0
