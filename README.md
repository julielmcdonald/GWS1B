# GWS1B 2025
## Workflow for processing next-generation sequencing of directed evolution libraries
The following processing is appropriate for demultiplexed, paired-end .fastq files received from Illumina or Element short-read sequencing. It assumes your environment contains bwa and samtools. 

The output will be a .csv file with the frequency of each base called relative to the reference sequence at each position. A sample of the first few lines of this file is below. 

## Output .csv sample
![image](https://github.com/julielmcdonald/GbR/assets/56400444/616fecb6-78f0-45ec-ae7d-03f6791218e8)

## Description and usage for each file:

### 1. flowcellCats.sh 
**Purpose:** Concatenate one of two paired reads from different flowcells.  
**Usage (slurm):** sbatch flowcellCats.sh file1.fastq file2 fastq. output.fastq 

### 2. mapping_script_fast_PE_withdownsample.sh
**Purpose:** Map fastq files to reference DNA sequence using Burrows-Wheeler Aligner.  
**Usage (slurm):** sbatch mapping_script_fast_PE_withdownsample.sh fasta1.fastq fasta2.fastq output_directory refseq.fa refseq_name 
**Notes:** 
* Mapping includes downsampling of reads to 10% to account for compute power.  
* Reference sequence must first be indexed using bwa.  
  `>module load bwa`  
  `>bwa index refseq.fa`

### 3. bam_list_script.sh
**Purpose:** Create empty file with header to use for master table generation.  
**Usage (slurm):** sbatch bam_list_script.sh sample_name sample_name

### 4. sorted_bam_to_master.sh
**Purpose:** Compiles alignment files using Samtools to .mpileup.  
**Usage (slurm):** sbatch sorted_bam_to_master.sh sample_name bam_list.txt ref_sequence.fa output_directory

### 5. master_table_generator_indel_counter.pl and master_table_header_generator_with_indels.pl  
**Purpose:** Custom-written Perl scripts to assemble master table .csv file. Do not need to be changed. 
