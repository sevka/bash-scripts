#!/bin/bash
DIFF_TOOL=/usr/bin/meld
#DIFF_TOOL="diff -y -w" 
if [[ -z "$1" || -z "$2" || "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: $0 FILE1 FILE2"
    exit 0
fi

function get_conv {
    filename=$(basename "$1")
    extension="${filename##*.}"
    extension="${extension,,}"
    if [[ "$extension" == "pdf" ]]; then
	echo "pdf2txt"
    elif [[ "$extension" == "doc" ]]; then
	echo "antiword"
#	echo "catdoc"
    elif [[ "$extension" == "rtf" ]]; then
	echo "catdoc"
    elif [[ "$extension" == "odt" ]]; then
	echo "odt2txt"
    elif [[ "$extension" == "docx" ]]; then
	echo "unoconv -f text --stdout"
    elif [[ "$extension" == "ods" || "$extension" == "xls" || "$extension" == "xlsx" ]]; then
	echo "unoconv -f csv --stdout"
    else
	echo "Error! Unsupported file type"
	exit 1
    fi
}
filename1=$(basename "$1").txt
filename2=$(basename "$2").txt

command=$(get_conv "$1")
$command "$1" > "/tmp/$filename1"
RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo "Error!"
    exit 1
fi

command=$(get_conv "$2")
$command "$2" > "/tmp/$filename2"
RESULT=$?
if [ $RESULT -ne 0 ]; then
    echo "Error!"
    exit 1
fi

$DIFF_TOOL "/tmp/$filename1" "/tmp/$filename2"

rm "/tmp/$filename1"
rm "/tmp/$filename2"
