#!/bin/sh 
#SBATCH --job-name="bolt"
#SBATCH --mail-user=<>
#SBATCH --mail-type=ALL
#SBATCH -o bolt.o%j
#SBATCH -e bolt.e%j
#SBATCH --partition="highmem"
#SBATCH -a 1-22

# Run lmm on all chromosomes to generate summ statistics to be used by bolt
../../../../BOLT-LMM_v2.4.1/bolt --bfile=../../wbi_removedicd10_pruned/ld_${SLURM_ARRAY_TASK_ID} \
        --phenoFile=/data3/mchopra/ukb_genotype_mri_passed/phenotypes/norm_pheno_aao.txt \
        --phenoCol=AAo_distensibility \
        --geneticMapFile=/data3/mchopra/BOLT-LMM_v2.4.1/tables/genetic_map_hg19_withX.txt.gz \
        --LDscoresFile=/data3/mchopra/BOLT-LMM_v2.4.1/tables/LDSCORE.1000G_EUR.tab.gz \
        --numThreads=${SLURM_ARRAY_TASK_ID} \
        --covarMaxLevels=100 \
        --statsFile=results/ao_GRM_bfile_${SLURM_ARRAY_TASK_ID} \
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
        --sampleFile=/data3/mchopra/ukb_genotype_mri_passed/output/wbi_removedICD10/bgen/chr1.sample \
        --bgenFile=/data3/mchopra/ukb_genotype_mri_passed/output/wbi_removedICD10/bgen/chr${SLURM_ARRAY_TASK_ID}.bgen \
        --statsFileBgenSnps=results/ao_bgen_${SLURM_ARRAY_TASK_ID}.stats \
        --bgenMinMAF=1e-3 \
        --bgenMinINFO=0.3 \
        --LDscoresMatchBp \
        --lmm \
        --verboseStats \
        --numLeaveOutChunks 2 \
        --covarUseMissingIndic \
        --maxModelSnps 4000000
