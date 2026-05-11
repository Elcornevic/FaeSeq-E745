#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J rna_bwa
#SBATCH --output=rna_bwa.%j.out

# Load necessary modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Define reference and data directories
REF="../../02_assembly/e745_assembly/e745.contigs.fasta"
DATA_DIR="/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/transcriptomics_data"

echo "Starting Automated RNA-Seq Mapping..."

# Loop through all paired forward reads (pass_1) in both BH and Serum trimmed folders
for R1 in $DATA_DIR/RNA-Seq_*/trimmed/trim_paired_*_pass_1.fastq.gz; do

    # Magic bash string manipulation to extract just the sample ID (e.g., ERR1797969)
    SAMPLE=$(basename $R1 | cut -d'_' -f3)

    # Define the matching reverse read by replacing 'pass_1' with 'pass_2'
    R2="${R1/_pass_1.fastq.gz/_pass_2.fastq.gz}"

    echo "========================================"
    echo "Processing sample: $SAMPLE"
    echo "========================================"

    # Map reads and convert directly to BAM
    bwa mem -t 2 $REF $R1 $R2 | samtools view -S -b - > ${SAMPLE}_mapped.bam
    
    # Sort and index the BAM file
    samtools sort ${SAMPLE}_mapped.bam -o ${SAMPLE}_sorted.bam
    samtools index ${SAMPLE}_sorted.bam

    # Clean up the unsorted BAM immediately to save your disk quota
    rm ${SAMPLE}_mapped.bam

    echo "Finished $SAMPLE"
done

echo "All 6 RNA-Seq samples successfully mapped and sorted!"
