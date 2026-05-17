#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J tnseq_count
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

# Load the required module
module load Subread/2.1.1-GCC-13.3.0

# Go to the working directory
cd /home/vico3159/genome_analyses/analyses/07_tnseq

# Run featureCounts on ALL bam files in the alignments folder at once
# -F : Tell this is a GFF3 file
# -t gene : count reads that land inside 'CDS'
# -g ID : use the 'ID' attribute in the GFF file to name the genes
# -a : annotation file
# -o : output table name
featureCounts -F GFF -t CDS -g ID -a e745_annot.gff -o tnseq_master_counts.txt alignments/*.bam
