#!/bin/sh 
#SBATCH --job-name="QC"
#SBATCH -o qc.o%j
#SBATCH -e qc.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -n 64
#SBATCH -N 2

module load plink2

#code 

for i in {1..22};
do
plink2 --threads 64 --bfile /data3/mchopra/ukb_genotype_mri_passed/distensibility_c_"$i" --mach-r2-filter 0.2 --maf 0.001 --geno 0.02 --hwe 0.0000005 midp --indep-pairwise 1000 100 0.8 --rm-dup exclude-all list --make-bed --out QC_"$i"
done

