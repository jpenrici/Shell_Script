# Manipular metadados do arquivo PDF
# Preserva a data
# Exemplo
#
# requer
#		 libimage-exiftool-perl

#!/bin/bash

script=$0
pdf=$1
subject=$2
title="Título Alterado"
author="Novo Autor"
keys="Palavra, Chave"

echo "starting script ..."
if [ ! -f "$pdf" ]
then
	echo "use: $script filename.pdf Subject"
	exit 1
fi

if [ ! -n "$subject" ]
then
	echo "use: $script $pdf Subject_Using_Underline" 
	exit 1
fi

echo "$pdf : Processing ..."

# Trocar underline por espaço
subject=`echo $subject | tr '_' ' '`

echo "Subject: $subject"
# Troca Tag's e preserva a data (-P)
exiftool -progress -P -Title="$title" -Author="$author" \
		 -Subject="$subject" -Keywords="$keys" $pdf

exiftool $pdf

echo ""
echo "$pdf: Changed."

# Fechando script
echo ""
echo "Ending script in a few seconds ..."
	
counter=3
while [ $counter -ge 0 ]
	do
		counter=`expr $counter - 1`
		sleep 1
	done
exit 0
