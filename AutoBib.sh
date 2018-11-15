#! /bin/bash
#

FILENAME="./Bibliography.bib"

doi() {

    pdftotext $1 temp.txt -q
    cat temp.txt | grep doi: | cut -d: -f 2 | head -n 1 >> dois.txt
    rm -rf temp.txt
}
bibmaker() {

    for i in $(cat dois.txt); 
    do 
        curl -LH "Accept: application/x-bibtex" http://dx.doi.org/$i >> $1; 
        echo $'\n' >> $1 
    done

}

echo "`date` User `whoami` started the script."$'\n' 
LSTPDF=$(ls $1)
for i in $LSTPDF; do
    doi $1$i
done

bibmaker $FILENAME
