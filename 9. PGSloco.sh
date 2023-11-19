#!/bin/sh 
#SBATCH --job-name="PGS_dao"
#SBATCH --output PGSLOCO_dao.o%j
#SBATCH -e PGSLOCO_dao.e%j
#SBATCH -n 64
#SBATCH -N 2
#SBATCH -p highmem

# Generate LOCO PGS scores
./PRSice_linux --thread 64 --base ../results/Stats_wbi_dao.orig.fastGWA --chr CHR --A1 A1 --A2 A2 --stat BETA --snp SNP --bp POS --pvalue P --target ../wbi_icd10/wbi_removedICD10 --pheno-file ../../../phenotypes/norm_pheno_dao.txt --all-score --fastscore --bar-levels 5e-05 --pheno-col DAo_distensibility --score avg --out PGS_dao.wbi --clump-p 5e-05

# LDpred code for prediction
# Rscript LDpred2.R ${TRAIT} ${results}/prsStat_${SLURM_ARRAY_TASK_ID}.gz ${SLURM_ARRAY_TASK_ID}

#run same for aao but change the files
