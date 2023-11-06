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
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/age.txt.csv ../../output/PCA/pca.eigenvec > qcovars2.txt ##age
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../phenotypes/genotype_measure_batch.csv qcovars2.txt > qcovars.txt ##batch

var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch"
sed -i "1s/.*/$var/" qcovars.txt

##discrete covariates  ##haven't considered centre information --need to add that
awk 'NR==FNR{a[$1]=$2;next}{print $0,(a[$1] == 0 ? 0 : (a[$1] ? a[$1] : "NA"))}' ../../phenotypes/31.csv <(awk '{print $1, $1}' qcovars.txt) > fixed2.txt
#awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1]}' $sex ${traits}/fixed2.txt > ${traits}/fixed.txt
#rm fixed2.txt
rm qcovars2.txt
var2="FID IID sex"
sed -i "1s/.*/$var2/" fixed.txt
