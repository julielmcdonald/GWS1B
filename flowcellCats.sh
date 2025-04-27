#!/bin/sh
#SBATCH -N 1
#SBATCH -n 4
###################

file1=$1
file2=$2
fileCat=$3

cat $file1 $file2 > $fileCat
