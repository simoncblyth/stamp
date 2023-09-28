#!/bin/bash -l 
usage(){ cat << EOU
stamp_test.sh : Simple Test Demonstrating Local/Remote Workflow
=================================================================

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

EOU
}

cd $(dirname $BASH_SOURCE)
name=stamp_test 

export FOLD=/tmp/$USER/$name
export IDENTITY="$BASH_SOURCE $(uname -n) $(date)"
mkdir -p $FOLD
bin=$FOLD/$name

defarg="info_build_run_ls"
arg=${1:-$defarg}

REMOTE=lxslc708.ihep.ac.cn

np_base=..
NP_BASE=${NP_BASE:-$np_base}

vars="BASH_SOURCE arg bin FOLD REMOTE"

if [ "${arg/info}" != "$arg" ]; then 
    for var in $vars ; do printf "%20s : %s \n" "$var" "${!var}" ; done 
fi 

if [ "${arg/build}" != "$arg" ]; then 
    gcc $name.cc -std=c++11 -lstdc++ -lm -I$NP_BASE/np -I.. -o $bin
    [ $? -ne 0 ] && echo $BASH_SOURCE build error && exit 1 
fi 

if [ "${arg/run}" != "$arg" ]; then 
    $bin
    [ $? -ne 0 ] && echo $BASH_SOURCE run  error && exit 2
fi 

if [ "${arg/grab}" != "$arg" ]; then 
    rsync -zarv --progress  \
          --include="*.npy" \
          --include="*.txt" \
          --include="*.jpg" \
          --include="*.png" \
          "$REMOTE:$FOLD/" "$FOLD"

    [ $? -ne 0 ] && echo $BASH_SOURCE grab error && exit 3
fi 

if [ "${arg/ana}" != "$arg" ]; then 
    ${IPYTHON:-ipython} --pdb -i $name.py 
    [ $? -ne 0 ] && echo $BASH_SOURCE ana  error && exit 5
fi 

if [ "${arg/ls}" != "$arg" ]; then 
    find "$FOLD" -type f
    [ $? -ne 0 ] && echo $BASH_SOURCE ls error && exit 5
fi 


exit 0 

