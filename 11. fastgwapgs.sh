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

