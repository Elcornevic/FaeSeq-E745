#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J e745_bwa
#SBATCH --output=e745_bwa.%j.out

# Load necessary modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Define file paths
REF="../02_assembly/e745_assembly/e745.contigs.fasta"
TRIMMED_DIR="../01_preprocessing/illumina_trimmed"
R1="$TRIMMED_DIR/e745_R1_paired.fq.gz"
R2="$TRIMMED_DIR/e745_R2_paired.fq.gz"

echo "Step 1: Indexing the reference genome..."
bwa index $REF

echo "Step 2: Mapping reads and converting to BAM..."
# I pipe (|) the BWA output directly into samtools to save hard drive space
bwa mem -t 2 $REF $R1 $R2 | samtools view -S -b - > e745_illumina_mapped.bam

echo "Step 3: Sorting and indexing the BAM file..."
samtools sort e745_illumina_mapped.bam -o e745_illumina_sorted.bam
samtools index e745_illumina_sorted.bam

echo "Mapping pipeline complete!"
