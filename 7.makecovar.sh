##refer declan's pipeline first while using this 
##need to add more covariates here
#!/bin/bash

#21001.txt ##bmi excluding values >=16 or <=40 
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
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/50.txt qcovars2.txt > qcovars3.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/23098.txt qcovars3.txt > qcovars4.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/21001.txt qcovars4.txt > qcovars5.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/4079.txt qcovars5.txt > qcovars6.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/4089.txt qcovars6.txt > qcovars7.txt

var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch height weight BMI DBP SBP"
sed -i "1s/.*/$var/" qcovars7.txt

##discrete covariates
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' 54.txt <(awk '{print $1, $1}' ${traits}/qcovars7.txt) > ${traits}/fixed2.txt
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1]}' 31.csv ${traits}/fixed2.txt > ${traits}/fixed.txt
rm ${traits}/fixed2.txt
rm ${traits}/qcovars.txt
rm ${traits}/qcovars1.txt
rm ${traits}/qcovars2.txt
rm ${traits}/qcovars3.txt
rm ${traits}/qcovars4.txt
rm ${traits}/qcovars5.txt
rm ${traits}/qcovars6.txt
var2="FID IID centre sex"
sed -i "1s/.*/$var2/" ${traits}/fixed.txt
