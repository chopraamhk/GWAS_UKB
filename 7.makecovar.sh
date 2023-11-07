#!/bin/bash

#21001.txt ##bmi excluding values >15 or < 40 
#have calculated the mean of values and excluded the empty values)
R
data <- read.table("21001.txt", h =T)
filtered_data <- data[data$Mean_21001 > 15 & data$Mean_21001 < 40, ]
write.table(filtered_data, file = "filtered_21001.txt", sep = "\t", row.names = FALSE)

#4079.txt - Diastolic pressure #keeping only the value under 100 that means excluding the diastolic pressure
data1 <- read.table("4079.txt", h =T)
filtered_data <- data1[data1$mean < 100, ]
write.table(filtered_data, file = "filtered_4079.txt", sep = "\t", row.names = FALSE)

#4080.txt - Systolic pressure #keeping only the value under 160 that means excluding the systolic pressure
data2 <- read.table("4080.txt", h =T)
filtered_data <- data2[data2$mean < 160, ]
write.table(filtered_data, file = "filtered_4080.txt", sep = "\t", row.names = FALSE)

##continuous covariates
# hash age file using ID as key and covar as val. print evectors with age covar appended. 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/age.txt.csv ../../output/PCA/pca.eigenvec > qcovars1.txt ##age
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/genotype_measure_batch.csv qcovars1.txt > qcovars2.txt ##batch
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/50.txt qcovars2.txt > qcovars3.txt #height 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/23098.txt qcovars3.txt > qcovars4.txt #weight 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/21001.txt qcovars4.txt > qcovars5.txt #BMI
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/4079.txt qcovars5.txt > qcovars6.txt #Diastolic BP
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/4089.txt qcovars6.txt > qcovars7.txt #Systolic BP

var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch height weight BMI DBP SBP"
sed -i "1s/.*/$var/" qcovars7.txt

##discrete covariates
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' 54_imaging.txt <(awk '{print $1, $1}' path/qcovars7.txt) > path/fixed2.txt #imaging_centres
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1]}' 31.csv path/fixed2.txt > path/fixed.txt #sex
rm ../output/after_pca_wbi/makeCovar/fixed2.txt
rm ../output/after_pca_wbi/makeCovar/qcovars.txt
rm ../output/after_pca_wbi/makeCovar/qcovars1.txt
rm ../output/after_pca_wbi/makeCovar/qcovars2.txt
rm ../output/after_pca_wbi/makeCovar/qcovars3.txt
rm ../output/after_pca_wbi/makeCovar/qcovars4.txt
rm ../output/after_pca_wbi/makeCovar/qcovars5.txt
rm ../output/after_pca_wbi/makeCovar/qcovars6.txt
var2="FID IID centre sex"
sed -i "1s/.*/$var2/" ../output/after_pca_wbi/makeCovar/fixed.txt
