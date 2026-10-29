#!/bin/bash
#SBATCH --job-name=fastqc_trimmomatic.sbatch
#SBATCH --output=/home/qo8/z01_output/z01.%x_%j
#SBATCH --mail-type=END,FAIL --mail-user=qo8@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=72:00:00
#SBATCH --mem=4G
#SBATCH --error=/home/qo8/trim_error/error.%x_%j
#-set environment, load module-#
shopt -s expand_aliases
module load trimmomatic/0.39

#-Input files-#
loc_in1="/home/qo8/RNAseq/input_files/WTC2_1.fq"
loc_in2="/home/qo8/RNAseq/input_files/WTC2_2.fq"

#-Output files-#
loc_out="/home/qo8/RNAseq/trim_out/WTC2_trimmed_out"
mkdir -p $loc_out
out1_paired="$loc_out/WTC2_1_paired.fq"
out1_unpaired="$loc_out/WTC2_1_unpaired.fq"
out2_paired="$loc_out/WTC2_2_paired.fq"
out2_unpaired="$loc_out/WTC2_2_unpaired.fq"

#-Adapter file-#
loc_adapters="/home/qo8/Illumina_adapter_file/TruSeq3-PE.fa"

#-run trimmomatic-#
trimmomatic PE \
$loc_in1 \
$loc_in2 \
$out1_paired $out1_unpaired \
$out2_paired $out2_unpaired \
HEADCROP:17 \
TRAILING:15 \
ILLUMINACLIP:$loc_adapters:2:30:10 \
SLIDINGWINDOW:4:15 \
MINLEN:75
#----------------------unload module-----------------#
module unload trimmomatic/0.39
#---------------------end job-----------------------#
