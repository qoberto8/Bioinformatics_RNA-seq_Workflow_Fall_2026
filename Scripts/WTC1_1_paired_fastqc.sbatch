#!/bin/bash
#SBATCH --job-name=fastqc_trimmomatic.sbatch
#SBATCH --output=/home/qo8/z01_output/z01.%x_%j
#SBATCH --mail-type=END,FAIL --mail-user=qo8@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=72:00:00
#SBATCH --mem=4G
#SBATCH --error=/home/qo8/trim_error/error.%x_%j
#-#
#-This script runs FastQC on raw RNA-seq reads-#
#-#
module load fastqc/0.12.0 

loc_input="/home/qo8/RNAseq/trim_out/WTC1_trimmed_out/WTC1_1_paired.fq"
loc_output="/home/qo8/RNAseq/fastqc_out/WTC1_1_paired_fastqc_out"

mkdir -p $loc_output
fastqc $loc_input -o $loc_output

module unload fastqc
#--------------------run fastqc----------------------#
