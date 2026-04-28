#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 4
#SBATCH -t 04:00:00
#SBATCH -J e745_canu_assembly
#SBATCH --mail-type=ALL
#SBATCH --output=e745_canu.%j.out

# Avoid local Pearl conflicts
unset PERL5LIB

# Load Canu and its missing dependency, SAMtools
module load canu/2.3
module load SAMtools

# Run the Canu assembly
canu -p e745 -d e745_assembly genomeSize=2.8m \
  useGrid=false \
  maxThreads=4 \
  -pacbio ../../data/raw_data/*.fastq.gz
