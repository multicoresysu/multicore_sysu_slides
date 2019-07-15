#!/bin/bash

cuda_app=./hw3_cuda
omp_app=./hw1_omp
current_path=$(pwd)


#search all sub-directories to find makefile
search_makefile()
{
  #echo start searching $1 .....................
  for f in $1/*
  do
    if [ -f $f ]
    then
      #echo ${f##*/}
      name=$(echo ${f##*/} | tr [a-z] [A-Z])
      #echo "file:"$name
      if [ $name != MAKEFILE ]
      then
        continue
      else
        echo "make "${f%/*}" and report to "$2
        echo $2 >>${current_path}/homework.txt
        cd ${f%/*}
        make clean & make all
        if [ -e $cuda_app ]
        then
          rm ./data.bin ./gold.bin ./output.bin
          ${current_path}/generate 1000000
          echo "data.bin" |nvprof --log-file ${current_path}/$2_cuda_report.txt $cuda_app data.bin > answer.txt
          ${current_path}/judge $2 output.bin gold.bin >>${current_path}/correct.txt
        fi
        cd ${current_path}
        #return 0
      
    elif [ -d $f ]
    then
      #echo search $f
      search_makefile $f $2
    fi
  done
  #echo end searching $1 .....................
}

rm ./homework.txt
for f in ./*
do
  if [ -d $f ]
  then
    echo
    search_makefile $f ${f#*/}
  fi
done
exit 0
