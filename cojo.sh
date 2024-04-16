#!/bin/sh 
#SBATCH --job-name="cojo"
#SBATCH -o cojo.o%j
#SBATCH -e cojo.e%j
#SBATCH -p normal
#SBATCH --mail-user=<>
#SBATCH -a 1-22 # give me 2 cores
#SBATCH -n 4
#SBATCH -N 1 # make sure cores on same machine
## CMD here

../gcta-1.94.1 --bfile /data3/mchopra/ukb_genotype_mri_passed/output/wbi_removedICD10/c_${SLURM_ARRAY_TASK_ID} --chr ${SLURM_ARRAY_TASK_ID} --maf 0.01 --cojo-file stats_aao.ma --cojo-slct --out cojo/aao_${SLURM_ARRAY_TASK_ID}
