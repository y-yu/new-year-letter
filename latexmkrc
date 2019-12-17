#!/usr/bin/env perl

$latex= 'uplatex %O -interaction=nonstopmode -shell-escape %B';
$pdflatex='lualatex %O -interaction=nonstopmode -shell-escape %B';
$bibtex = 'pbibtex %O -kanji=utf8 %B';
$dvipdf= 'dvipdfmx %O -o %D %S';
$makeindex= 'mendex %O -s %S %S';
$pdf_mode = 3;
$pdf_update_method = 3;
