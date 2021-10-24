#!/usr/bin/env perl
$pdf_mode       = 3;
$latex          = 'uplatex -synctex=1 -halt-on-error';
$bibtex         = 'upbibtex';
$biber          = 'biber --bblencoding=utf8 -u -U --output_safechars';
$dvipdf         = 'dvipdfmx %O -o %D %S';
$makeindex      = 'mendex %O -o %D %S';
$max_repeat     = 5;
$pvc_view_file_via_temporary    = 0;
