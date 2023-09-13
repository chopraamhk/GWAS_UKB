#!/bin/bash
#
#SBATCH --job-name="plink"
#SBATCH -o plink.o%j
#SBATCH -e plink.e%j
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -n 32
#SBATCH -N 1

#code
for i in {1..22}
do
plink2 --bfile ukb_genotypic_files/ukb22418_c"$i"_b0_v2 --keep ukb_genotypic_files/keep.txt --make-bed --out ukb_distensibility_genotypic_files/ukb_distensibility_c_"$i"
done
