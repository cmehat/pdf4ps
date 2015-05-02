# pdf4ps
Convert .pdf slides file into .ps file with 4 slides per page (in command line)

takes   : PDF documents in landscape (-l) or portrait (-p) orientation

returns : PS document with 4 slides per page [file names $PREFIX*.ps]

pages to be read in rows: 
<pre>[1] [2]
[3] [4]</pre>


# usage message
<pre>
usage   : $0 [-f] [-l|-p] [-p]
options :
-l          landscape document          (default)
-p          portrait document
-f=FORMAT   paper format                (default is a4)
-p=PREFIX   prefix appened to filename  (default is "p4-")
-h          this help message

For a fast use, just use 'pdf4ps file1.pdf file2.pdf', 
and it will produce 'p4-file1.ps' and 'p4-file2.ps'.</pre>
