#! /bin/bash
#
usage() {
    echo "usage $0 -p <pdf file/s> [-b bibliography name]"
    exit 1
}

offline=0
bibliography=./bibliography.bib
while getopts ":hp:b:o" options; do              
    case "${options}" in                         
        h)                                      
            usage
            exit 1
            ;;
        b) bibliography=${OPTARG} ;;
        p) 
            articles=${OPTARG} 
            ;;
        o) offline=1 ;;
        ?)                                   
            echo "Error: -${OPTARG} requires an argument."
            usage
            exit 1
            ;;
    esac
done


if [ $offline -eq 1 ]; then

    for article in $articles; do
        [ -e "$article" ] || continue
        echo "Downloading bibliography for $article"
        info=$(pdfinfo $article)
        journal=$(echo "$info" | grep Subject: | sed -e 's/Subject:\(.*\),.*$/\1/' | sed -e 's/^[ \t]*//')
        title=$(echo "$info" | sed -n 's/^Title://p' | sed -e 's/^[ \t]*//')
        author=$(echo "$info" | sed -n 's/^Author://p' | sed -e 's/^[ \t]*//')
        year=$(echo "$info" | awk '/CreationDate/ {print $6}' | sed -e 's/^[ \t]*//')

        echo -e "@article{$(basename "article" | cut -f 1 -d '.'),
                year = $year,
                author = {$author},
                title = {$title},
                journal = {$journal}
        }\n" >> "$bibliography"
    done
else
    for article in $articles; do
        [ -e "$article" ] || continue
        doi=$(pdfinfo "$article" | sed -n 's/.*doi://p')
        if [ -n '$doi' ]; then
            echo "Downloading bibliography for $article"
            curl -sfLH "Accept: application/x-bibtex" http://dx.doi.org/$doi >> "$bibliography"
            echo -e "\n" >> "$bibliography"
        else
            echo "Cannot find doi for $article"
        fi
    done
fi
