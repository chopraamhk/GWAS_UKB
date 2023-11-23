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

#Also, the phenotypes should be normalised 
normalised script :- < https://rpubs.com/chopraamhk/1103403 >

#run gwas for AAo
../gcta-1.94.1 --mbfile fastGWASfiles  --grm-sparse /home/mchopra/data3/ukb_genotype_mri_passed/output/after_pca_wbi/makesparseGRM/sp_grm --fastGWA-mlm --pheno ../../../phenotypes/norm_pheno_aao.txt --qcovar ../makeCovar/qcovars7.txt --covar ../makeCovar/fixed.txt --threads 64 --out ../results/Stats_wbi_aao.orig


#run gwas for DAo
../gcta-1.94.1 --mbfile fastGWASfiles  --grm-sparse /home/mchopra/data3/ukb_genotype_mri_passed/output/after_pca_wbi/makesparseGRM/sp_grm --fastGWA-mlm --pheno ../../../phenotypes/norm_pheno_dao.txt --qcovar ../makeCovar/qcovars7.txt --covar ../makeCovar/fixed.txt --threads 64 --out ../results/Stats_wbi_dao.orig

##for the next PGS steps--
module load Anaconda3
conda activate bcf_env

#split the stat file in 22 chromosome files
for i in {1..22}; do 
	cat Stats_wbi_aao.orig.fastGWA | awk -v chr="$i" '$1 != chr {print $0}' | bgzip -c > prsStat/prsStat_aao_${i}.gz; 
done

for i in {1..22}; do
        cat Stats_wbi_dao.orig.fastGWA | awk -v chr="$i" '$1 != chr {print $0}' | bgzip -c > prsStat/prsStat_dao_${i}.gz;                                     
done
