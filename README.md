# ukb_GWAS
#installation of miniconda::
```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
```

After you install it, you can just initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells:

```
~/miniconda3/bin/conda init bash
~/miniconda3/bin/conda init zsh
```

required repositories: PLINK 
```
conda install -c bioconda plink2
```

UKBB DATA -> <https://biobank.ctsu.ox.ac.uk/crystal/label.cgi?id=263>

#Working with genopic files -> Less variants
Step1:
Download genotypic calls .bim, .bed, .fam files
```
sinfo bed.sh
sinfo fam.sh
sinfo bim.sh
```

Step2:
extract only 60604 samples from file keep.txt and use the below bash script with the plink command. Note that we have chromosome files not merged. 
```
sinfo extract_keep.sh
```

#Working with Imputed data -> More variants
Need imputed data instead of genotypic calls as the axiom data has less than 1 million variants. In contrast, the Imputed data uses haplotype data from 1KG, UK10K, and HRC (haplotype data from ~80,000 samples) giving ~90 million variants in the imputed dataset.

Step1:
```
sinfo imputed.sh
```

#Step2
The imputed data gives the data in bgen format. It is best to convert the files to plink2 format (pgen, pvar & psam) as they are fast to process. Remember to remove the participants who have withdrawn from the study. Sample files can be downloaded from 
```
for i in {1..26};
do
gfetch 22828 -m -akeyfile -c"$i"
done
```
```
sinfo bgenToPlink.sh 
```

#Step3
Extract only 54,725 samples with imaging phenotype with available Genotypic data.
```
sbatch extract_keep.sh
```

#STEP3:
PLINK QC and LD pruning 
```
sbatch 1.qc.sh ##output of this step will be used in the next step
sbatch 2.ld_prune.sh ##ld_pruning 
```

#STEP4:
Merging and PCA
Merge all the chromosome files into one file and run PCA 
```
sbatch 3.pca.sh
```

#STEP5:
Making GRM
```
sbatch 4.GCTA.sh
```

#STEP6:
Creating sparse GRM for fastGWA
```
sbatch 5.makesparseGRM.sh
```

#STEP7:
covar files
```
sbatch 7.covar.sh
```

#STEP8:
GCTA fastGWA
```
sbatch 8.fastGWA.sh
```

##further if want to do the PRS analysis 
- polygenic score calculation
- phenotype and LOCO PGS covars
- FastGWAS PGS adjusted

##Reference : <https://github.com/declan93/PGS-LMM>

In Covariates, need to consider following points.. After the aortic segmentation, stahe 1 exclusion of phenotypic/genotypic data:
Stage 1 exclusions:
```
• 19 aortic diagnoses (ICD 10 and
self-reported)
• 707 grade IV or greater
hypertension at imaging visit
• 349 extremes of BMI (<16 or >40)
• 551 outlying aortic phenotype
values (>4SDs from mean, which
gives a cut off for AA diameter
around 45mm).
• 930 without genotyped data or fail
genotype QC
• 62 fail heterozygosity/missingness
• 25 sex mismatch
• 823 individuals without height data
```

Stage 2 exclusions:
```
restrict to Caucasian individuals
(“White”, “British”, “Irish”, “Any other
white background”)
```

```
excluded data for distensibility calculation, i.e., PWA
```

```
In the paper, GWAS has been performed with Areas and distensibility
```
