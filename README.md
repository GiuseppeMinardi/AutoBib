# What is AutoBIb
Imagine to write a long scientific article and you need to cite 100 other articles or books.
With LaTeX is easier than any other well knows word manager, but 100 articles are 100 articles to put in your _.bib_ file. 
Now imagine to take all the pdfs, extracting the **doi** and let a script download all the bib entry. This script does all of this.

## Requirement
 - _pdftotext:_ is a program that converts .pdf files to .txt files. It is necessary, but if you already hav _ranger_ as your file manager you will not need to install it.
 - _internet connection_: This program uses internet in order to retrieve entries

## How to use

```
   ./Autobib.sh ./PdfFolder/
```
All pdfs must be in a single folder, switch _./PdfFolder/_ with your directory containing your articles.
