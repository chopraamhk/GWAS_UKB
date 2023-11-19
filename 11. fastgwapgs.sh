#!/bin/sh 
#SBATCH --job-name="2FASTGWA"
#SBATCH -o fastgwa_pgs.o%j
#SBATCH -e fastgwa_pgs.e%j
#SBATCH -n 64 
#SBATCH -N 2
#SBATCH -p highmem
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL

../gcta-1.94.1 --mbfile ../fastgwafull/fastGWASfiles --grm-sparse /home/mchopra/data3/ukb_genotype_mri_passed/output/after_pca_wbi/makesparseGRM/sp_grm --fastGWA-mlm --pheno ../../../phenotypes/norm_pheno_aao.txt --qcovar ../makepgsCovars/qcovars_aao_pgs.txt  --covar ../makeCovar/fixed.txt --threads 32 --out ../results_pgs/PGS_adj_aao

../gcta-1.94.1 --mbfile ../fastgwafull/fastGWASfiles --grm-sparse /home/mchopra/data3/ukb_genotype_mri_passed/output/after_pca_wbi/makesparseGRM/sp_grm --fastGWA-mlm --pheno ../../../phenotypes/norm_pheno_dao.txt --qcovar ../makepgsCovars/qcovars_dao_pgs.txt  --covar ../makeCovar/fixed.txt --threads 32 --out ../results_pgs/PGS_adj_dao
