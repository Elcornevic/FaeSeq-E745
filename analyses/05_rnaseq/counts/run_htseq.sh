#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 07:00:00
#SBATCH -J rna_count
#SBATCH --output=rna_count.%j.out

# Load the HTSeq module
module load HTSeq/2.1.2-gfbf-2024a

# Define the files
GFF="e745_annot_clean.gff"
BAM_DIR="../mapping"

echo "Starting HTSeq Read Counting..."

# Loop through all 6 sorted BAM files
for BAM in $BAM_DIR/*_sorted.bam; do

    # Extract just the sample name (e.g., ERR1797969)
    SAMPLE=$(basename $BAM | cut -d'_' -f1)
    
    echo "========================================"
    echo "Counting reads for $SAMPLE..."
    
    # Run the counting tool
    htseq-count -f bam -r pos -s no -t CDS -i locus_tag $BAM $GFF > ${SAMPLE}_counts.txt
    
    echo "Finished $SAMPLE"
done

echo "All samples successfully counted!"
