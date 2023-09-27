#!/bin/sh 
#SBATCH --job-name="PCA"
#SBATCH -o pca.o%j
#SBATCH -e pca.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="normal"
#SBATCH -n 64
#SBATCH -N 4

module load plink2

#merging of files
#cat data3/mchopra/ukb_genotype_mri_passed/output/ld_prune/ld_1.fam > data3/mchopra/ukb_genotype_mri_passed/output/PCA/plink.fam

for i in {1..22}; 
do cat /data3/mchopra/ukb_genotype_mri_passed/output/ld_prune/ld_"$i".bim; done > /data3/mchopra/ukb_genotype_mri_passed/output/PCA/plink.bim

(echo -en "\x6C\x1B\x01"; 
for i in {1..22}; do tail -c +4 /data3/mchopra/ukb_genotype_mri_passed/output/ld_prune/ld_"$i".bed; done) > /data3/mchopra/ukb_genotype_mri_passed/output/PCA/plink.bed

#pca
plink2 --threads 64 --bfile /data3/mchopra/ukb_genotype_mri_passed/output/PCA/plink --pca approx --out /data3/mchopra/ukb_genotype_mri_passed/output/PCA/pca
