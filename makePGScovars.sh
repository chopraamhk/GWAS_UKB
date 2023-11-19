awk 'NR==FNR{a[$1]=$3;next}{print $0,a[$1] ? a[$1] : "NA"}' ../PGSloco/PGS.wbi.all_score  qcovars7.txt > qcovars_aao_pgs.txt
awk 'NR==FNR{a[$1]=$3;next}{print $0,a[$1] ? a[$1] : "NA"}' ../PGSloco/PGS_dao.wbi.all_score  qcovars7.txt > qcovars_dao_pgs.txt
var="FID IID PC1 PC2 PC3 PC4 PC5 PC6 PC7 PC8 PC9 PC10 age batch height weight BMI DBP SBP PGS"
sed -i "1s/.*/$var/" qcovars_aao_pgs.txt
sed -i "1s/.*/$var/" qcovars_dao_pgs.txt



