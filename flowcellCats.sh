#!/bin/sh
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --nice=100000
#SBATCH --exclude=c[5-22]
#SBATCH --mail-type=END
#SBATCH --mail-user=jlmcd@mit.edu
###################

file1=$1
file2=$2
fileCat=$3

cat $file1 $file2 > $fileCat