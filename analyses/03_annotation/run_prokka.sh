#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 4
#SBATCH -t 01:00:00
#SBATCH -J e745_prokka
#SBATCH --mail-type=ALL
#SBATCH --output=e745_prokka.%j.out

# Load the Prokka module 
module load prokka

# Run the Prokka annotation pipeline
prokka \
  --outdir prokka_e745 \
  --prefix e745_annot \
  --genus Enterococcus \
  --species faecium \
  --strain E745 \
  --cpus 4 \
  ../02_assembly/e745_assembly/e745.contigs.fasta
