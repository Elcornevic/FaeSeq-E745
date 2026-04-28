#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J e745_snp
#SBATCH --output=e745_snp.%j.out

# Load the module
module load BCFtools/1.22.1-GCC-13.3.0

# Define files
REF="../02_assembly/e745_assembly/e745.contigs.fasta"
BAM="e745_illumina_sorted.bam"

echo "Step 1: Stacking reads and calculating variations (mpileup)..."
echo "Step 2: Calling the actual SNPs (call)..."

# Pipe mpileup directly into call to generate the final VCF file
bcftools mpileup -Ou -f $REF $BAM | bcftools call -mv -Ov -o e745_variants.vcf

echo "SNP Calling complete! Check the e745_variants.vcf file."
