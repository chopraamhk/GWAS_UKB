##refer declan's pipeline first while using this 
##need to add more covariates here
#!/bin/bash

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
