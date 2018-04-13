#!/bin/bash
# Excluir arquivos recursivamente usando o comando Shred
# Requer pacote Zenity
# Testado em Thunar (Debian 9 - XFCE4)

function clean() {
    for file in "$1"/*
    do
        if [[ ! -d "${file}" ]] ; then
            if [[ -L "${file}" ]] ; then
                rm -f "${file}"
                echo "removed link: ${file}" >> ${output}
            elif [[ -f "${file}" ]] ; then
                shred -u "${file}"
                echo "removed file: ${file}" >> ${output}
            fi
        else
            clean "${file}"
        fi
    done
    if [[ "$1" != "$path" ]]; then
        rmdir "${1}"
        echo "removed directory: ${1}"
        echo "removed directory: ${1}"  >> ${output}
    fi
}

function main() {
    path=$1
    if [[ "$path" = "" ]]; then
        gdialog --msgbox "Select file or directory!"
        echo "Finished."
        exit 0
    fi

    gdialog --title "Warning" --center --stdout --yesno \
    "Remove files?" \
    100 100

    if [[ $? = "0" ]]; then
        echo "Removed..."
        echo "remove_files.sh:" > ${output}
        clean "$path"
        gdialog --title "Warning" --msgbox "Done."
    fi
}

output="/tmp/list_removed"
echo "Started..."
main $1
echo "Finished."
