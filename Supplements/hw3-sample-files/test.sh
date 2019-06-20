#!/bin/bash

function test_cmd()
{
    if [ $? -ne 0 ];then
        echo -e "\n>>>>>>>>>> failed: \"$1\" <<<<<<<<<<\n"
    else
        echo -e "\n>>>>>>>>>> succeed: \"$1\" <<<<<<<<<<\n"
fi
}

# cd sources
cd ./sources
test_cmd "cd ./sources";

# make
make clean
test_cmd "make clean";

make all
test_cmd "make all";

# run program
echo 'data.bin' | ./hw3_cuda data.bin
test_cmd "echo 'data.bin' | ./hw3_cuda data.bin";

# test tar
cd ../
dir_name=$(echo ${PWD##*/})
cd ../
cp -r $dir_name "$dir_name"_test
if [ $dir_name != "jovyan" -o $dir_name != "home" ];then
    tar zcvf "$dir_name"_test.tar.gz "$dir_name"_test
    test_cmd "tar zcvf \"$dir_name\"_test.tar.gz \"$dir_name\"_test";
    tar zxvf "$dir_name"_test.tar.gz
    test_cmd "tar zxvf \"$dir_name\"_test.tar.gz";
    
    rm -rf "$dir_name"_test
    rm "$dir_name"_test.tar.gz
fi