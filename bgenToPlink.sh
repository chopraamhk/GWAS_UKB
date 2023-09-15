#!/bin/bash
#
#SBATCH --job-name="imputed"
#SBATCH -o imputed.o%j
#SBATCH -e imputed.e%j
#SBATCH --mail-user= <>
#SBATCH --mail-type=ALL
#SBATCH --partition="normal"
#SBATCH -n 16
#SBATCH -N 1 
#datasets download to /data3 instead of the default /home
TFDS_DATA_DIR=/data4/UKB/Genotypes/Imputed

module load plink2
#code 
for i in {1..22};
do
plink2 --threads 16 --bgen Imputed/ukb22828_c"$i"_b0_v3.bgen ref-first --sample Imputed/ukb22828_c"$i"_b0_v3_s487150.sample --remove remove.txt --make-pgen --out Imputed_plink/chr"$i"
done
