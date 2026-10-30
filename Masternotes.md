## Description of Project Experimental Design
We are working with data obtained from Candida albicans (commensal yeast) grown in thiamine deplete (Thi-) and replete (Thi+) conditions to induce stress/virulence. 

- This is paired end data obtained from biological triplicates A, B and C.
- A1/B1/C1 all represent data from replicates/isolates grown in (Thi+) and A2/B2/C2 represent data from replicates/isolates grown in (Thi-).
- _1 & _2 are read pairs.
- Files with which I'll be working: WTC1_1.fq, WTC1_2.fq, WTC2_1.fq, WTC2_2.fq

### Workflow

1. Files (WTC1_1.fq, WTC1_2.fq, WTC2_1.fq, WTC2_2.fq) were analyzed by FastQC Report and cleaned accordingly using trimmomatic (removing sporadic base calling in the first ~17 bp of reads and removing adapter contamination).
  a. Scripts used to generate these timmed fastq files are: 
[WTC1_1 FastQC Script](Scripts/WTC1_1_fastqc.sbatch)
[WTC1_2 FastQC Script](Scripts/WTC1_2_fastqc.sbatch)
[WTC2_1 FastQC Script](Scripts/WTC2_1_fastqc.sbatch)
[WTC2_2 FastQC Script](Scripts/WTC2_2_fastqc.sbatch)
[WTC1 Trimmomatic Script](Scripts/WTC1_trim.sbatch)
[WTC2 Trimmomatic Script](Scripts/WTC2_trim.sbatch)

3. Cleaned files were then analyzed again via FastQC Report and their effectiveness assessed.
  a. Scripts used for this process are: 
[WTC1_1 Paired Trimmomatic Output Script](Scripts/WTC1_1_paired_fastqc.sbatch)
[WTC1_2 Paired Trimmomatic Output Script](Scripts/WTC1_2_paired_fastqc.sbatch)
[WTC2_1 Paired Trimmomatic Output Script](Scripts/WTC2_1_paired_fastqc.sbatch)
[WTC2_2 Paired Trimmomatic Output Script](Scripts/WTC2_2_paired_fastqc.sbatch)
  b. Trimmomatic results analyzed in FastQC Report deemed accurate and proceeded with workflow (minor adapter contamination remained).

4. Aligned reads to C. albicans reference genome assembly ASM18296v3 from NCBI (fasta file GCF_000182965.3_ASM18296v3_genomic.fna) using bowtie2/2.5.4 and samtools/1.24
  a. First, we built an index to run the alignment using UNIX command:
qo8@m12-base1-4 $ bowtie2-build GCF_000182965.3_ASM18296v3_genomic.fna C_alb
  b. After index construction, trimmed reads were aligned and put into SAM format using the scripts below:
[WTC1 Alignment Script](RNAseq_bowtie2_WTC1.sbatch)
[WTC2 Alignment Script](RNAseq_bowtie2_WTC2.sbatch)
