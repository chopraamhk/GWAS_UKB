#!/bin/sh 
#SBATCH --job-name="bolt_m"
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH -o bolt_m.o%j
#SBATCH -e bolt_m.e%j
#SBATCH --partition="normal","highmem"

# Run lmm on all chromosomes to generate sum statistics to be used by bolt
../../../../BOLT-LMM_v2.4.1/bolt --bed=/data3/mchopra/ukb_genotype_mri_passed/output/wbi_removedICD10/c_{1:22}.bed \
        --bim=/data3/mchopra/ukb_genotype_mri_passed/output/wbi_removedICD10/c_{1:22}.bim \
        --fam=/data3/mchopra/ukb_genotype_mri_passed/output/wbi_removedICD10/c_1.fam \
        --phenoFile=/data3/mchopra/ukb_genotype_mri_passed/phenotypes/norm_pheno_aao.txt \
        --phenoCol=AAo_distensibility \
        --geneticMapFile=/data3/mchopra/BOLT-LMM_v2.4.1/tables/genetic_map_hg19_withX.txt.gz \
        --LDscoresFile=/data3/mchopra/BOLT-LMM_v2.4.1/tables/LDSCORE.1000G_EUR.tab.gz \
        --numThreads 32 \
        --covarMaxLevels=200 \
        --statsFile=results/ao_GRM_with_imputed \
        --qCovarCol=PC{1:10} \
        --qCovarCol=CENTRE \
        --qCovarCol=BATCH \
        --qCovarCol=AGE \
        --covarCol=SEX \
        --qCovarCol=HEIGHT \
        --qCovarCol=WEIGHT \
        --qCovarCol=BMI \
        --qCovarCol=DBP \
        --qCovarCol=SBP \
        --covarFile=bolt_covars.txt \
        --bgenFile=/data4/UKB/Genotypes/Imputed/bgen/chr{1:22}.bgen \
        --remove=in.plink_but_not_bgen.sample \
        --noBgenIDcheck \
        --statsFileBgenSnps=results/ao_Stats.imputed.bgen \
        --bgenMinMAF=1e-4 \
        --bgenMinINFO=0.4 \
        --sampleFile=/data4/UKB/Genotypes/Imputed/bgen/chr1.sample \
        --LDscoresMatchBp \
        --lmmForceNonInf \
        --verboseStats \
        --covarUseMissingIndic \
        --maxModelSnps 4000000
