#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -M pelle
#SBATCH -c 2
#SBATCH -t 01:00:00
#SBATCH -J e745_snp_aus
#SBATCH --output=e745_snp_aus.%j.out

module load BCFtools/1.22.1-GCC-13.3.0

# Use the new reference and the newly mapped BAM file
REF="../00_reference/e_faecium_Aus0004.fasta"
BAM="e745_vs_Aus0004_sorted.bam"

echo "Calling variants..."
bcftools mpileup -Ou -f $REF $BAM | bcftools call -mv -Ov -o e745_vs_Aus0004_variants.vcf

echo "VCF file generated successfully!"
