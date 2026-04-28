#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 4
#SBATCH -t 02:00:00
#SBATCH -J e745_eval
#SBATCH --mail-type=ALL
#SBATCH --output=e745_eval.%j.out

# 1. RUN QUAST
# Use module spider quast to check the exact version/capitalization if this fails
module load QUAST/5.3.0

echo "Starting QUAST..."
quast.py ../e745_assembly/e745.contigs.fasta \
  -o quast_output \
  -t 4

# 2. RUN BUSCO
# I use the Singularity container
# -l lactobacillales_odb10 specifies the closest bacterial lineage for E. faecium
echo "Starting BUSCO..."
singularity exec /proj/uppmax2026-1-61/Genome_Analysis/busco.sif busco \
  -i ../e745_assembly/e745.contigs.fasta \
  -o busco_output \
  -m genome \
  -l lactobacillales_odb10 \
  -c 4

# 3. RUN MUMmerplot
# Load the specific MUMmer module
module load MUMmer/4.0.1

# Align the Canu assembly against the DO reference genome
nucmer --prefix=e745_align E_faecium_DO_ref.fasta ../e745_assembly/e745.contigs.fasta

# Generate the dot plot image
mummerplot --png --large --prefix=e745_plot e745_align.delta

echo "Evaluation complete!"
