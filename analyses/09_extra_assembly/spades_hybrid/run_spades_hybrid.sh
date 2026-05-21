#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 8                 # SPAdes is resource-heavy, giving it 8 cores
#SBATCH -t 24:00:00          # Hybrid assembly takes much longer than Flye
#SBATCH -J hybrid_spades
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

# Load the SPAdes module
module load SPAdes/4.2.0-GCC-13.3.0

# Navigate to the working directory
cd /home/vico3159/genome_analyses/analyses/09_extra_assembly/spades_hybrid

# Define variables for the input files
ILLUMINA_R1="../../01_preprocessing/illumina_trimmed/e745_R1_paired.fq.gz"
ILLUMINA_R2="../../01_preprocessing/illumina_trimmed/e745_R2_paired.fq.gz"
NANOPORE="../flye_nanopore/nanopore_clean.fasta.gz"

# Run the hybrid assembly
spades.py \
    -1 $ILLUMINA_R1 \
    -2 $ILLUMINA_R2 \
    --nanopore $NANOPORE \
    -o spades_hybrid_output \
    -t 8 \
    -m 64  # Requesting 64GB of RAM
