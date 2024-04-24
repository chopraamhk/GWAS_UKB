#!/bin/sh 
#SBATCH --job-name="2FASTGWA"
#SBATCH -o fastgwa_pgs.o%j
#SBATCH -e fastgwa_pgs.e%j
#SBATCH --array=1-22
#SBATCH -n 32 
#SBATCH -N 1
#SBATCH -p highmem
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL

../gcta-1.94.1 --bfile /home/mchopra/data3/ukb_genotype_mri_passed/output/wbi_removedICD10/c_${SLURM_ARRAY_TASK_ID} --grm-sparse /home/mchopra/data3/ukb_genotype_mri_passed/output/after_pca_wbi/makesparseGRM/sp_grm --fastGWA-mlm --pheno ../../../phenotypes/norm_pheno_aao.txt --qcovar ../makepgsCovars/qcovars_aao_${SLURM_ARRAY_TASK_ID}  --covar ../makeCovar/fixed.txt --threads 32 --out ../results_pgs/PGS_adj_lmm.aao.${SLURM_ARRAY_TASK_ID}

../gcta-1.94.1 --bfile /home/mchopra/data3/ukb_genotype_mri_passed/output/wbi_removedICD10/c_${SLURM_ARRAY_TASK_ID} --grm-sparse /home/mchopra/data3/ukb_genotype_mri_passed/output/after_pca_wbi/makesparseGRM/sp_grm --fastGWA-mlm --pheno ../../../phenotypes/norm_pheno_dao.txt --qcovar ../makepgsCovars/qcovars_dao_${SLURM_ARRAY_TASK_ID}  --covar ../makeCovar/fixed.txt --threads 32 --out ../results_pgs/PGS_adj_lmm.dao.${SLURM_ARRAY_TASK_ID}



#!/bin/bash

awk 'FNR > 1' PGS_adj_lmm.aao.1.fastGWA  PGS_adj_lmm.aao.2.fastGWA PGS_adj_lmm.aao.3.fastGWA PGS_adj_lmm.aao.4.fastGWA PGS_adj_lmm.aao.5.fastGWA PGS_adj_lmm.aao.6.fastGWA PGS_adj_lmm.aao.7.fastGWA PGS_adj_lmm.aao.8.fastGWA PGS_adj_lmm.aao.9.fastGWA PGS_adj_lmm.aao.10.fastGWA PGS_adj_lmm.aao.11.fastGWA PGS_adj_lmm.aao.12.fastGWA PGS_adj_lmm.aao.13.fastGWA PGS_adj_lmm.aao.14.fastGWA PGS_adj_lmm.aao.15.fastGWA PGS_adj_lmm.aao.16.fastGWA PGS_adj_lmm.aao.17.fastGWA PGS_adj_lmm.aao.18.fastGWA PGS_adj_lmm.aao.19.fastGWA PGS_adj_lmm.aao.20.fastGWA PGS_adj_lmm.aao.21.fastGWA PGS_adj_lmm.aao.22.fastGWA > results/PGS_adj_lmm_aao

var="CHR	SNP	POS	A1	A2	N	AF1	BETA	SE	P"
sed -i "1s/.*/$var/" results/PGS_adj_lmm_aao


awk 'FNR > 1' PGS_adj_lmm.dao.1.fastGWA  PGS_adj_lmm.dao.2.fastGWA PGS_adj_lmm.dao.3.fastGWA PGS_adj_lmm.dao.4.fastGWA PGS_adj_lmm.dao.5.fastGWA PGS_adj_lmm.dao.6.fastGWA PGS_adj_lmm.dao.7.fastGWA PGS_adj_lmm.dao.8.fastGWA PGS_adj_lmm.dao.9.fastGWA PGS_adj_lmm.dao.10.fastGWA PGS_adj_lmm.dao.11.fastGWA PGS_adj_lmm.dao.12.fastGWA PGS_adj_lmm.dao.13.fastGWA PGS_adj_lmm.dao.14.fastGWA PGS_adj_lmm.dao.15.fastGWA PGS_adj_lmm.dao.16.fastGWA PGS_adj_lmm.dao.17.fastGWA PGS_adj_lmm.dao.18.fastGWA PGS_adj_lmm.dao.19.fastGWA PGS_adj_lmm.dao.20.fastGWA PGS_adj_lmm.dao.21.fastGWA PGS_adj_lmm.dao.22.fastGWA > results/PGS_adj_lmm_dao

var="CHR      SNP     POS     A1      A2      N       AF1     BETA    SE      P"
sed -i "1s/.*/$var/" results/PGS_adj_lmm_dao
