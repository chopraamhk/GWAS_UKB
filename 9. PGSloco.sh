#!/bin/sh 
#SBATCH --job-name="PGS_dao"
#SBATCH --output PGSLOCO_dao.o%j
#SBATCH -e PGSLOCO_dao.e%j
#SBATCH -n 32
#SBATCH -N 1
#SBATCH -p highmem
#SBATCH --array=1-22

# Generate LOCO PGS scores for aao
./PRSice_linux --thread 64 --base ../results/prsStat/prsStat_aao_${SLURM_ARRAY_TASK_ID}.gz --chr CHR --A1 A1 --A2 A2 --stat BETA --snp SNP --bp POS --pvalue P --target ../wbi_icd10/wbi_removedICD10 --pheno-file ../../../phenotypes/norm_pheno_aao.txt --all-score --fastscore --bar-levels 5e-05 --pheno-col AAo_distensibility --score avg --out PGS_aao.${SLURM_ARRAY_TASK_ID} --clump-p 5e-05

# Generate LOCO PGS scores for dao
./PRSice_linux --thread 64 --base ../results/prsStat/prsStat_dao_${SLURM_ARRAY_TASK_ID}.gz --chr CHR --A1 A1 --A2 A2 --stat BETA --snp SNP --bp POS --pvalue P --target ../wbi_icd10/wbi_removedICD10 --pheno-file ../../../phenotypes/norm_pheno_dao.txt --all-score --fastscore --bar-levels 5e-05 --pheno-col DAo_distensibility --score avg --out PGS_dao.${SLURM_ARRAY_TASK_ID} --clump-p 5e-05

# Generate LOCO PGS scores for dao


# LDpred code for prediction
# Rscript LDpred2.R ${TRAIT} ${results}/prsStat_${SLURM_ARRAY_TASK_ID}.gz ${SLURM_ARRAY_TASK_ID}

#run same for aao but change the files
