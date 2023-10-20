#!/bin/sh 
#SBATCH --job-name="1FastGWA"
#SBATCH -o fastgwa.o%j
#SBATCH -e fastgwa.e%j
#SBATCH -n 50
#SBATCH -N 1
#SBATCH -p gpu
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL

./gcta-1.94.1 --mbfile fastGWASfiles  --grm-sparse /data3/mchopra/ukb_genotype_mri_passed/output/makesparseGRM/sp_grm --fastGWA-mlm --pheno /data3/mchopra/ukb_genotype_mri_passed/phenotypes/pheno_aao.txt --qcovar ../makeCovar/qcovars.txt --covar ../makeCovar/fixed.txt --threads 64 --out /data3/mchopra/ukb_genotype_mri_passed/output/results/Stats_aao.orig
