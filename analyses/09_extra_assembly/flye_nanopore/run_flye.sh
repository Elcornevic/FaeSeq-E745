#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 10:00:00
#SBATCH -J flye_assembly
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

module load Flye/2.9.6-GCC-13.3.0

cd /home/vico3159/genome_analyses/analyses/09_extra_assembly/flye_nanopore

# Updated command for the .fasta.gz file
flye --nano-raw nanopore_clean.fasta.gz --out-dir flye_output --threads 2
