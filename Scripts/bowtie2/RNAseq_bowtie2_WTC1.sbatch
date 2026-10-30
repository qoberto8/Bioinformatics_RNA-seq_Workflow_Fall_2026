#!/bin/bash
#SBATCH --job-name=RNAseq_bowtie2_WTC2
#SBATCH --output=/home/qo8/z01_output/z01.%x_%j
#SBATCH --mail-type=END,FAIL --mail-user=qo8@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=4 --time=72:00:00
#SBATCH --mem=4G
#-#
#-This script runs bowtie2 on paired-end.fq files-#
#-#
#-module load-#
module load bowtie2/2.5.4
module load samtools/1.24
#-set variables-#
loc_index="/home/qo8/RNAseq/C_alb_index/C_alb"
loc_m1="/home/qo8/RNAseq/trim_out/WTC1_trimmed_out/WTC1_1_paired.fq"
loc_m2="/home/qo8/RNAseq/trim_out/WTC1_trimmed_out/WTC1_2_paired.fq"
loc_outdir="/home/qo8/RNAseq/sam_out"
loc_out="$loc_outdir/WTC1.sam"
mkdir -p $loc_outdir
#-#
#-Run bowtie2-#
bowtie2 -p 4 -x \
${loc_index} \
-1 ${loc_m1} \
-2 ${loc_m2} \
-S ${loc_out}
#-#
#-module unload-#
module unload bowtie2/2.5.4
module unload samtools/1.24
#-#
#-JOB FINISHED-#
