#!/bin/bash

file_type=$1
folder=$2
tar_file=${folder}.tar.gz

rm -rf ${folder}
mkdir ${folder}
mv *.${file_type} ${folder}
rm ${tar_file}
tar zcvf ${tar_file} ${folder}
rm -rf ${folder}
