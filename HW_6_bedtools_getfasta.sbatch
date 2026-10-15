#!/bin/bash
#SBATCH --job-name=bedtools_getfasta
#SBATCH --output=/home/qo8/z01_output/z01.%x_%j
#SBATCH --mail-type=END,FAIL --mail-user=qo8@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=72:00:00
#SBATCH --mem=4G
#-#
# This script runs bedtools getfasta to pull sequence from full assembly #
#-#

module load bedtools

# Location of the input fasta
loc_fasta="/home/qo8/HW_6/GCF_002204515.2_AaegL5.0_genomic.fna"

# Location of input bed file (can be bed/gff/vcf) format
loc_bed="/home/qo8/HW_6/A_egypti_odorant-binding.gff"

#Location of the output results
loc_output="/home/qo8/HW_6/A_egypti_odorant-binding_seqs.fa"

#-Run bedtools getfasta-#
bedtools getfasta -fo $loc_output -s  -name \
-fi $loc_fasta \
-bed $loc_bed

#-module unload-#

module unload bedtools

#-end job-#
