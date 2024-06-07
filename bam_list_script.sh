#!/bin/sh
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --nice=100000
#SBATCH --exclude=c[5-22]
#SBATCH --mail-type=END
#SBATCH --mail-user=jlmcd@mit.edu
###################

sample_no_zeros=$1
out=$2

ls 240408Shodata_"$sample_no_zeros"__out.dn10pct.bam > /net/bmc-pub14/data/shoulders/users/jlmcd/240408Sho/"$out"_bam_list.txt


