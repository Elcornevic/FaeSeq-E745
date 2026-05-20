#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J e745_bwa_aus
#SBATCH --output=e745_bwa_aus.%j.out

module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# 1. The NCBI Reference
REF="../00_reference/e_faecium_Aus0004.fasta"

# 2. Your cleaned reads
TRIMMED_DIR="../01_preprocessing/illumina_trimmed"
R1="$TRIMMED_DIR/e745_R1_paired.fq.gz"
R2="$TRIMMED_DIR/e745_R2_paired.fq.gz"

echo "Indexing the Aus0004 reference genome..."
bwa index $REF

echo "Mapping reads and creating BAM..."
bwa mem -t 2 $REF $R1 $R2 | samtools view -S -b - > e745_vs_Aus0004_mapped.bam

echo "Sorting and indexing BAM file..."
samtools sort e745_vs_Aus0004_mapped.bam -o e745_vs_Aus0004_sorted.bam
samtools index e745_vs_Aus0004_sorted.bam

echo "Mapping complete!"
