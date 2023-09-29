#!/bin/sh 
#SBATCH --job-name="ld"
#SBATCH -o ld_prune.o%j
#SBATCH -e ld_prune.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -n 64
#SBATCH -N 2

module load plink2

#code 

for i in {1..22};
do
plink2 --threads 64 --bfile /data3/mchopra/ukb_genotype_mri_passed/output/QC/QC_"$i"  --maf 0.001 --hwe 0.00005 midp --extract /data3/mchopra/ukb_genotype_mri_passed/output/QC/QC_"$i".prune.in --make-bed --out ld_"$i"
done
