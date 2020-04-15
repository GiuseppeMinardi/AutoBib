# What is AutoBIb
Imagine to write a long scientific article and you need to cite 100 other articles or books.
With LaTeX is easier than any other program for writing documents, but 100 articles are 100 articles to put in your _.bib_ file. 
Now imagine to take all the pdfs, extracting the **doi** and let a script download all the bib entry. This script does all of this.

## Requirement
The script uses `getopts` and `pdfinfo`, therefore it may cause problems. 

## How to use

```
   bash AutoBib.sh -p PdfFolder/*.pdf
```
With this example all documents presents in the folder are passed to the script and all bib entries are stored in a file called _bibliography.bib_.
You can specify the output file, if the file exist the script will append the new entries to the file, otherwise a new file will be created.
```
    bash AutoBib.sh -p PdfFolder/*.pdf -b mydb.bib
```
Here all biber entries will be stored in the file _mydb.bib_.

In order to use **AutoBib** you need to be connected to internet.
The option `-o` allows the user to run the script offline.
**WARNING**: the offline mode create only the mandatory entries for an article (author, title, journal and year) but it can miss some parameters. 
It is recommendeed to not use the `-o` option.
