Demo uint64_t microsecond timestamps Transferred from C++ into Python
=======================================================================

Contents
----------

stamp.h
    C++ header being tested

stamp_test.sh 
    bash script that controls building, running, transfers, ...

stamp_test.cc
    C++ main with unit test functions, including one which 
    saved timestamps into a .npy file 

stamp_test.py 
    python analysis that loads the timestamps 


stamp_test.sh : Simple Test Demonstrating Local/Remote Workflow
-----------------------------------------------------------------

::

    ./stamp_test.sh info   ## list bash variable values
    ./stamp_test.sh build  ## compile C++ test into executable 
    ./stamp_test.sh run    ## run the executable
    ./stamp_test.sh grab   ## rsync FOLD files from remote to local 
    ./stamp_test.sh ana    ## python analysis, plotting 
    ./stamp_test.sh ls     ## list files in FOLD   

Simply by having this same code cloned from a git repo 
on local and remote machines : you can adopt a simple 
Local/Remote workflow. 

The script automates what you could laboriously do
in a manual way.  


Working Across Two Machines
------------------------------

Work is often done across two machines. 

1. remote server, batch job submission, heavy lifting C++ data reduction
2. local laptop(or workstation), python data analysis  

Data analysis is better done locally with small datasets as you can 
then benefit from the capabilities of your laptop(workstation) GPU.
Local analysis is a much better experience because it is so much 
faster than trying to do analysis on a shared remote server. 

However this only becomes practical after you have reduced 
the size of the data by applying selections and data format conversions. 
This data reduction is usually done using C++ tools on the remote server. 
Then you are left with files small enough to transferred 
to your laptop/workstation for detailed analysis, 
which you will often use python for. 

