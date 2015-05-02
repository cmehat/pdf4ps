#!/bin/bash

# convert .pdf slides into ps files with 4 slides/page

# takes   : PDF documents in landscape (-l) or portrait (-p) orientation
# returns : PS document with 4 slides per page [file names $PREFIX*.ps]
#
# pages to be read in rows: [1] [2]
#                           [3] [4] 

PREFIX=p4-
FORMAT=a4
MODULO=2:1,0
#

while getopts "lpb:f:h" opt ; do
    case $opt in 
  f)FORMAT=$OPTARG;;
  p)echo "Potrait mode";   MODULO=4:0,2,1,3;;#MODULO=4:1,3,2,0 ;;
  l)echo "Landscape mode"; MODULO=2:1,0 ;;
  b)PREFIX=$OPTARG;;
 h)
cat << EOF
convert .pdf slides into ps files with 4 slides/page
usage   : $0 [-f] [-l|-p] [-h]
options :
-l          landscape document          (default)
-p          portrait document
-f=FORMAT   paper format                (default is a4)
-p=PREFIX   prefix appened to filename  (default is "p4-")
-h          this help message

For a fast use, just use 'pdf4ps file1.pdf file2.pdf', 
and it will produce 'p4-file1.ps' and 'p4-file2.ps'.
EOF
     exit;;

 ?)echo "Error : bad option. Try $0 -h"
     exit;;
    esac
done

shift $(($OPTIND - 1))

for i in "$*" ; do
    if [ ! -f "$i" ]; then
 echo "No file $i"
    else
 OUTFILE=$PREFIX`basename "$i" .pdf`.ps
 if [ ! -f "$OUTFILE" ]; then
     pdftops "$i" - \
  | pstops "$MODULO" \
  | psnup -4 -d1 -m0.2 -s0.5 -c \
  | psresize -P"$FORMAT" -p"$FORMAT">"$OUTFILE"
 else
     echo "$PREFIX version of \"$i\" already exist ($OUTFILE)"
 fi
    fi
done

# Corentin Mehat oct2005-oct2006
# please send all bugs & ameliorations

# pdftops $i - \      # softs are to use ps files, convert the file to ps
# | pstops 2:1,0 \                        # reorder mod 2 : odd, even
# | psnup -4 -d1 -m0.2 -s0.5 -c \         # border=1 margin=0.2 scale=0.5
# | psresize -Pletter -pletter>$OUTFILE   # recenter

