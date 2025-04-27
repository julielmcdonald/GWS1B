#!/bin/sh
#SBATCH -N 1
#SBATCH -n 4
###################

sample_no_zeros=$1
out=$2

ls "$sample_no_zeros"__out.dn10pct.bam > "$out"_bam_list.txt


