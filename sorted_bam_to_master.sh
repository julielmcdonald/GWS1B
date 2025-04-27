#!/bin/sh
#SBATCH -N 1
#SBATCH -n 4
###################

module add samtools/1.3

experiment_name=$1
sample_list=$2
reference_genome=$3
target_directory=$4

cd $target_directory

echo samtools mpileup -d 10000000 -excl-reads 2052 -f $reference_genome -b $sample_list > $experiment_name'_mpileup.txt'
samtools mpileup -d 10000000 -excl-reads 2052 -f $reference_genome -b $sample_list > $experiment_name'_mpileup.txt'

echo cat $sample_list | perl master_table_header_generator_with_indels.pl > $experiment_name'_master_table.txt'
cat $sample_list | perl master_table_header_generator_with_indels.pl > $experiment_name'_master_table.txt'


echo cat $experiment_name'_mpileup.txt' | perl master_table_generator_indel_counter.pl >>  $experiment_name'_master_table.txt'
cat $experiment_name'_mpileup.txt' | perl master_table_generator_indel_counter.pl >>  $experiment_name'_master_table.txt'
