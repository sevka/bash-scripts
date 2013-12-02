bash-scripts
============

Usefull bash scripts

officediff
------------
Text diff for office files: doc,odt,docx,pdf,xls,xlsx,ods,rtf. 

Usage: officediff FILE1 FILE2

This script convert office (binary) files to plain text and then compare it using diff tool (meld).
There are a lot of dependencies:
 * catdoc for rtf (you can use it for doc also, but I prefer antiword)
 * pdf2txt for pdf (packet: python-pdfminer)
 * odt2txt for odt
 * antiword for doc
 * unoconv for all the rest

Actually, you can use only unoconv for all conversions but it pretty slow.

Command to install all dependencies in Ubuntu:

    sudo apt-get install odt2txt python-pdfminer catdoc antiword unoconv
    
I use it in Eclipse locally and in plugin Subversive for comparing files from SVN. Subversive have a function 'External diff'.
To compare your local files in the pure Eclipse you have to install plugin: 

External diff tool (http://sourceforge.net/projects/externaldiff/?source=dlp)
