#!/bin/bash 

#for aao
for i in {1..22}; do
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/age.txt.csv ../../../output/after_pca_wbi/PCA/pca.eigenvec > qcovars1_${i}.txt ##age
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/genotype_measure_batch.csv qcovars1_${i}.txt > qcovars2_${i}.txt ##batch
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/50.txt.csv qcovars2_${i}.txt > qcovars3_${i}.txt #height 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/23098.txt qcovars3_${i}.txt > qcovars4_${i}.txt #weight 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/21001.txt qcovars4_${i}.txt > qcovars5_${i}.txt #BMI
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/4079.txt qcovars5_${i}.txt > qcovars6_${i}.txt #Diastolic BP
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/4080.txt qcovars6_${i}.txt > qcovars7_${i}.txt #Systolic BP
awk 'NR==FNR{a[$1]=$3;next}{print $0,a[$1] ? a[$1] : "NA"}' ../PGSloco/PGS_aao.${i}.all_score qcovars7_${i}.txt > qcovars_aao_${i}  # This line include PRSice LOCO-PGS

var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch height weight BMI DBP SBP PGS"
sed -i "1s/.*/$var/" qcovars_aao_${i}

rm qcovars1_${i}.txt
rm qcovars2_${i}.txt
rm qcovars3_${i}.txt
rm qcovars4_${i}.txt
rm qcovars5_${i}.txt
rm qcovars6_${i}.txt
rm qcovars7_${i}.txt

done

##for dao
for i in {1..22}; do
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/age.txt.csv ../../../output/after_pca_wbi/PCA/pca.eigenvec > qcovars1_${i}.txt ##age
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/genotype_measure_batch.csv qcovars1_${i}.txt > qcovars2_${i}.txt ##batch
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/50.txt qcovars2_${i}.txt > qcovars3_${i}.txt #height 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/23098.txt qcovars3_${i}.txt > qcovars4_${i}.txt #weight 
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/21001.txt qcovars4_${i}.txt > qcovars5_${i}.txt #BMI
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/4079.txt qcovars5_${i}.txt > qcovars6_${i}.txt #Diastolic BP
awk 'NR==FNR{a[$1]=$2;next}{print $0,a[$1] ? a[$1] : "NA"}' ../../../phenotypes/4080.txt qcovars6_${i}.txt > qcovars7_${i}.txt #Systolic BP
awk 'NR==FNR{a[$1]=$3;next}{print $0,a[$1] ? a[$1] : "NA"}' ../PGSloco/PGS_dao.${i}.all_score qcovars7_${i}.txt > qcovars_dao_${i}  # This line include PRSice LOCO-PGS

var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch height weight BMI DBP SBP PGS"
sed -i "1s/.*/$var/" qcovars_dao_${i}

rm qcovars1_${i}.txt
rm qcovars2_${i}.txt
rm qcovars3_${i}.txt
rm qcovars4_${i}.txt
rm qcovars5_${i}.txt
rm qcovars6_${i}.txt
rm qcovars7_${i}.txt

done



