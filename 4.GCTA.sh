#!/bin/sh 
#SBATCH --job-name="QC"
#SBATCH -o qc.o%j
#SBATCH -e qc.e%j
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH --partition="normal"
#SBATCH -n 16
#SBATCH -N 1
#SBATCH -a 1-250

./gcta-1.94.1 --bfile /data3/mchopra/ukb_genotype_mri_passed/output/PCA/plink --make-grm-part 250 ${SLURM_ARRAY_TASK_ID} --thread-num 8 --out /data3/mchopra/ukb_genotype_mri_passed/output/GCTA/grm_prt
