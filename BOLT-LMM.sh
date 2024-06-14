#!/bin/sh 
#SBATCH -n 16
#SBATCH -N 1

mkdir -p results

# Run lmm on all chromosomes to generate summ statistics to be used by bolt
bolt --bfile=Brit/plink \
        --phenoFile=height/height.pheno \
        --phenoCol=height \
        --geneticMapFile=/home/dbennett/bin/BOLT-LMM/tables/genetic_map_hg19_withX.txt.gz \
        --LDscoresFile=/home/dbennett/bin/BOLT-LMM/tables/LDSCORE.1000G_EUR.tab.gz \
        --numThreads 32 \
        --covarMaxLevels=200 \
        --statsFile=height/results/Stats.height.GRM \
        --qCovarCol=PC{1:10} \
        --covarCol=centre \
        --qCovarCol=batch \
        --qCovarCol=age \
        --covarCol=sex \
        --covarFile=height/BOLTLMM.covars \
        --LDscoresMatchBp \
        --lmmForceNonInf 
## generate sum stat files with out the chromosome in the name. These are used by PRSice to generate the PRS score
#for i in {1..22}; do cat results/Stats.${1}.GRM | awk -v chr="$i" '$2 != chr {print $0}' | bgzip -c > PGS/pgsStat_${1}_${i}.gz; done
