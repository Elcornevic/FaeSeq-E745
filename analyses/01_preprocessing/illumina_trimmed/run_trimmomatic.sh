#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 00:15:00
#SBATCH -J e745_trim
#SBATCH --output=e745_trim.%j.out

# Load the module
module load Trimmomatic

# Define paths
RAW_DIR="/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/genomics_data/Illumina"

echo "Starting Trimmomatic..."

trimmomatic PE -threads 2 \
  $RAW_DIR/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz \
  $RAW_DIR/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz \
  e745_R1_paired.fq.gz e745_R1_unpaired.fq.gz \
  e745_R2_paired.fq.gz e745_R2_unpaired.fq.gz \
  SLIDINGWINDOW:4:15 MINLEN:36

echo "Trimming complete!"
