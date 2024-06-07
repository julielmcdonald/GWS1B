#!/bin/sh
#SBATCH -N 1
#SBATCH -n 4
#SBATCH --nice=100000
#SBATCH --exclude=c[5-22]

###################

module load bwa/0.7.12
module add samtools/1.3

sample=$1
FQ1=$2
FQ2=$3
target_dir=$4
genome_index=$5
genome=$6

echo bwa mem -t 16 $genome_index $FQ1 $FQ2  | samtools view -Sb - > $target_dir/$sample"_bwa_"$genome"_mapped.bam"
bwa mem -t 16 $genome_index $FQ1 $FQ2 | samtools view -Sb - > $target_dir/$sample"_bwa_"$genome"_mapped.bam"

echo samtools sort $target_dir/$sample"_bwa_"$genome"_mapped.bam" -o $target_dir/$sample"_bwa_"$genome"_mapped.sorted.bam" 
samtools sort $target_dir/$sample"_bwa_"$genome"_mapped.bam" -o $target_dir/$sample"_bwa_"$genome"_mapped.sorted.bam"

echo samtools index $target_dir/$sample"_bwa_"$genome"_mapped.sorted.bam"
samtools index $target_dir/$sample"_bwa_"$genome"_mapped.sorted.bam"

echo samtools view -h -s 10.10 -o $target_dir"data_"$sample"_"$genome"_out.dn10pct.bam" $target_dir"/"$sample"_bwa_"$genome"_mapped.sorted.bam"
samtools view -h -s 10.10 -o $target_dir"data_"$sample"_"$genome"_out.dn10pct.bam" $target_dir"/"$sample"_bwa_"$genome"_mapped.sorted.bam"

echo samtools sort -o $target_dir"data_"$sample"_"$genome"_out.dn10pct.sorted.bam" $target_dir"/"$sample"_bwa_"$genome"_mapped.sorted.bam"
samtools sort -o $target_dir"data_"$sample"_"$genome"_out.dn10pct.sorted.bam" $target_dir"/"$sample"_bwa_"$genome"_out.dn10pct.bam"

echo samtools index $target_dir"/"$sample"_bwa_"$genome"_out.dn10pct.sorted.bam"
samtools index $target_dir"/"$sample"_bwa_"$genome"_out.dn10pct.sorted.bam"
