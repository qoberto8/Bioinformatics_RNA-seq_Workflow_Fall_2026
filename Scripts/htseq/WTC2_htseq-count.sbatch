#!/bin/bash
#SBATCH --job-name=WTC2_htseq-count
#SBATCH --output=/home/qo8/z01_output/z01.%x_%j
#SBATCH --mail-type=END,FAIL --mail-user=qo8@georgetown.edu
#SBATCH --nodes=1 --ntasks=1 --cpus-per-task=1 --time=72:00:00
#SBATCH --mem=4G

#-module load-#
module load anaconda3/3.13

#-This script runs htseq-count on paired-end.fq files-#

#-source activate-#
source activate htseq
#-set variables-#
htseq="/home/qo8/.conda/envs/htseq/bin/htseq-count"
loc_bam="/home/qo8/RNAseq/bam_files/WTC2.bam"
loc_gtf="/home/qo8/RNAseq/ref_genome_files/GCF_000182965.3_ASM18296v3_genomic.gtf"

#-Run htseq-count-#
${htseq} -f bam -r pos -s no -t exon -i gene_id ${loc_bam} ${loc_gtf} > /home/qo8/RNAseq/htseq-count_files/WTC2.htseq

#-deactivate htseq environment-#
source deactivate

#-module unload-#
module unload anaconda3/3.13
#-end job-#
