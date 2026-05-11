#!/bin/bash

module load BLAST+/2.17.0-gompi-2024a

makeblastdb -in reference_AUS0004.fasta -dbtype nucl -title "AUS0004_Ref" -out AUS0004_db

blastn -query e745_assembly.fasta -db AUS0004_db -outfmt 6 -out e745_vs_aus0004.blast -num_threads 2
