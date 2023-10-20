#!/bin/sh 
#SBATCH --job-name="1FastGWA"
#SBATCH -o fastgwa.o%j
#SBATCH -e fastgwa.e%j
#SBATCH -n 64
#SBATCH -N 2
#SBATCH -p highmem
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL

#excluding values having sd > 4 from mean. 
R
data <- read.table(".txt", h = T) #.txt is the file where FID IID trait1 is there separated by tab delimited. 
column_data <- data$column_name
mean_value <- mean(column_data)
std_dev <- sd(column_data)
filtered_data <- subset(data, column_name >= mean_value - 4 * std_dev & column_name <= mean_value + 4 * std_dev)
write.csv(filtered_data, file = "filtered_data.csv", row.names = FALSE)
q()

#run gwas
./gcta-1.94.1 --mbfile fastGWASfiles  --grm-sparse /data3/mchopra/ukb_genotype_mri_passed/output/makesparseGRM/sp_grm --fastGWA-mlm --pheno /data3/mchopra/ukb_genotype_mri_passed/phenotypes/filtered_data.csv --qcovar ../makeCovar/qcovars.txt --covar ../makeCovar/fixed.txt --threads 64 --out /data3/mchopra/ukb_genotype_mri_passed/output/results/Stats_aao.orig
