## Description of Project Experimental Design
We are working with data obtained from Candida albicans (commensal yeast) grown in thiamine deplete (Thi-) and replete (Thi+) conditions to induce stress/virulence. 

- This is paired end data obtained from biological triplicates A, B and C.
- A1/B1/C1 all represent data from replicates/isolates grown in (Thi+) and A2/B2/C2 represent data from replicates/isolates grown in (Thi-).
- _1 & _2 are read pairs.
- Files with which I'll be working: WTC1_1.fq, WTC1_2.fq, WTC2_1.fq, WTC2_2.fq

### Workflow
 <br>
 
1. Files (WTC1_1.fq, WTC1_2.fq, WTC2_1.fq, WTC2_2.fq) were analyzed by FastQC Report and cleaned accordingly using trimmomatic (removing sporadic base calling in the first ~17 bp of reads and adapter contamination, sequence duplication levels were deemed unproblematic at the levels reported and ignored).
   
  a. Scripts used to generate the FastQC Report .html files:

[WTC1_1 FastQC Script](Scripts/FastQC/WTC1_1_fastqc.sbatch)<br>
[WTC1_2 FastQC Script](Scripts/FastQC/WTC1_2_fastqc.sbatch)<br>
[WTC2_1 FastQC Script](Scripts/FastQC/WTC2_1_fastqc.sbatch)<br>
[WTC2_2 FastQC Script](Scripts/FastQC/WTC2_2_fastqc.sbatch)<br>
[WTC1 Trimmomatic Script](Scripts/Trimmomatic/WTC1_trim.sbatch)<br>
[WTC2 Trimmomatic Script](Scripts/Trimmomatic/WTC2_trim.sbatch)<br>
 <br>
  b. FastQC Report .html files:<br>
  
  [WTC1_1 FastQC Report](Files/Input_File_FastQC/WTC1_1_fastqc.html)<br>
  [WTC1_2 FastQC Report](Files/Input_File_FastQC/WTC1_2_fastqc.html)<br>
  [WTC2_1 FastQC Report](Files/Input_File_FastQC/WTC2_1_fastqc.html)<br>
  [WTC2_2 FastQC Report](Files/Input_File_FastQC/WTC2_2_fastqc.html)<br>
  <br>
  c. Trimmomatic scripts: <br>
  
[WTC1 Trimmomatic Script](Scripts/Trimmomatic/WTC1_trim.sbatch)<br>
[WTC2 Trimmomatic Script](Scripts/Trimmomatic/WTC2_trim.sbatch)<br>

 b. These scripts generated files:<br>
 
WTC1_1_paired.fq<br>
WTC1_1_unpaired.fq<br>
WTC1_2_paired.fq<br>
WTC1_2_unpaired.fq<br>

WTC2_1_paired.fq<br>
WTC2_1_unpaired.fq<br>
WTC2_2_paired.fq<br>
WTC2_2_unpaired.fq<br>
 <br>
 _
 <br>
 <br>

2. Cleaned files were then analyzed again via FastQC Report and their effectiveness assessed. After analysis, trimmomatic results were deemed sufficient to proceed with workflow (minor adapter contamination remained, sequence duplication levels were deemed unproblematic at the levels reported and ignored). Only paired.fq files/trimmomatic outputs were considered.

  a. Scripts used to generate the FastQC Report .html files:

[WTC1_1 Paired Trimmomatic Output Script](Scripts/WTC1_1_paired_fastqc.sbatch)<br>
[WTC1_2 Paired Trimmomatic Output Script](Scripts/WTC1_2_paired_fastqc.sbatch)<br>
[WTC2_1 Paired Trimmomatic Output Script](Scripts/WTC2_1_paired_fastqc.sbatch)<br>
[WTC2_2 Paired Trimmomatic Output Script](Scripts/WTC2_2_paired_fastqc.sbatch)<br>

  b. FastQC Report .html files: <br>

[WTC1_1 Trimmed FastQC Report](Files/Trimmed_FastQC/WTC1_1_paired_fastqc.html)<br>
[WTC1_2 Trimmed FastQC Report](Files/Trimmed_FastQC/WTC1_2_paired_fastqc.html)<br>
[WTC2_1 Trimmed FastQC Report](Files/Trimmed_FastQC/WTC2_1_paired_fastqc.html)<br>
[WTC2_2 Trimmed FastQC Report](Files/Trimmed_FastQC/WTC2_2_paired_fastqc.html)<br>
 <br>
_
 <br>
 <br>
 
3. Aligned reads to C. albicans reference genome assembly ASM18296v3 from NCBI (fasta file GCF_000182965.3_ASM18296v3_genomic.fna) using bowtie2/2.5.4 and samtools/1.24

  a. First, we built an index to run the alignment using this UNIX command on the Georgetown University HPC cluster:
  
qo8@m12-base1-4 $ bowtie2-build GCF_000182965.3_ASM18296v3_genomic.fna C_alb

  b. Index files generated:<br>
  
C_alb.1.bt2<br>
C_alb.2.bt2<br>
C_alb.3.bt2<br>
C_alb.4.bt2<br>
C_alb.rev.1.bt2<br>
C_alb.rev.2.bt2<br>

  c. After index construction, trimmed reads were aligned and put into SAM format using the scripts below:<br>
  
[WTC1 Alignment Script](Scripts/RNAseq_bowtie2_WTC1.sbatch)<br>
[WTC2 Alignment Script](Scripts/RNAseq_bowtie2_WTC2.sbatch)<br>
 <br>
  d. Scripts generated files:<br>
  
WTC1.sam<br>
WTC2.sam<br>
 <br>
_
 <br>
 <br>

4. SAM files were converted to BAM files for more efficient analysis using samtools/1.24. After conversion to BAM format, files were sorted and indexed.<br>

  a. UNIX commands used for conversion from SAM to BAM format:<br>

qo8@m12-base1-4 $ samtools view -S -b WTC1.sam > WTC1.bam<br>
qo8@m12-base1-4 $ samtools view -S -b WTC2.sam > WTC2.bam<br>

  b. Files generated from these commands:<br>

WTC1.bam<br>
WTC2.bam<br>

  c. UNIX commands used for the sorting of BAM files:<br>

qo8@m12-base1-4 $ samtools sort WTC1.bam -o WTC1.srt.bam<br>
qo8@m12-base1-4 $ samtools sort WTC2.bam -o WTC2.srt.bam<br>

  d. Files generated from these commands:<br>

WTC1.srt.bam<br>
WTC2.srt.bam<br>

  e. UNIX commands used for the indexing of BAM files:<br>

qo8@m12-base1-4 $ samtools index WTC1.srt.bam<br>
qo8@m12-base1-4 $ samtools index WTC2.srt.bam<br>
 <br>
 *Additionally these steps can be included in and written into the scripts used to generate the SAM files without going through this intermediate.
 <br>
_
 <br>
 <br>

 


  


