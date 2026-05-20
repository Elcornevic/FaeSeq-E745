#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 100:00:00
#SBATCH -J eggnog_map
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

# Load the module
module load eggnog-mapper/2.1.13-gfbf-2024a

# Go to the working directory
cd /home/vico3159/genome_analyses/analyses/08_deep_annotation/eggnog

# Run EggNOG-mapper
# -i : input protein file
# --output : prefix for the results
# -m diamond : search algorithm
emapper.py -i e745_proteins.faa --output e745_functional -m diamond --cpu 2 --data_dir /sw/data/eggNOG/5.0/rackham
