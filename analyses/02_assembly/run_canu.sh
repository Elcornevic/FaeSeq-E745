#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 04:00:00
#SBATCH -J e745_canu_assembly
#SBATCH --mail-type=ALL
#SBATCH --output=e745_canu.%j.out

# Load Canu and its missing dependency, SAMtools
module load canu/2.3
module load SAMtools

# Run the Canu assembly
canu -p e745 -d e745_assembly genomeSize=2.8m \
  gridOptions="-A uppmax2026-1-61 -M pelle -t 12:00:00" \
  maxThreads=2 corThreads=2 oeaThreads=2 cnsThreads=2 \
  -pacbio ../../data/raw_data/*.fastq.gz
