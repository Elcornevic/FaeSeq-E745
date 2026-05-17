#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -c 2
#SBATCH -t 02:00:00
#SBATCH -J tnseq_map
#SBATCH --mail-type=ALL
#SBATCH --output=%x.%j.out

# Load the required modules
module load BWA/0.7.19-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

# Make sure the job runs in the correct folder
cd /home/vico3159/genome_analyses/analyses/07_tnseq

# The BWA mapping loop
for file in raw_reads/*.fastq.gz; do
    # Extract just the filename without the extension
    base=$(basename $file .fastq.gz)
    
    echo "========================================"
    echo "Starting mapping for: $base"
    echo "========================================"
    
    # Map, sort, and compress into BAM in one single pipeline
    bwa mem -t 2 e745_assembly.fasta $file | samtools sort -@ 2 -o ${base}.bam -
    
    # Create the BAM index
    samtools index alignments/${base}.bam
    
    echo "Finished $base!"
done
