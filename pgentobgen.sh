#!/bin/bash
#
#SBATCH --job-name="bgen"
#SBATCH -o bgen.o%j
#SBATCH -e bgen.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -n 32
#SBATCH -N 1

module load plink2
plink2 --pfile /data4/UKB/Genotypes/Imputed/chr22 --export bgen-1.1 --out chr22


