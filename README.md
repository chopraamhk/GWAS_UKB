##Reference -> https://github.com/declan93/PGS-LMM
https://www.nature.com/articles/s41598-021-99031-3

##major studies i have focused on -> https://www.nature.com/articles/s41467-022-32219-x
https://www.nature.com/articles/s41588-021-00962-4

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
Before running the fastGWA, i recommend checking the normality of the phenotypes and running the inverse normal distribution 
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
• 19 aortic diagnoses (ICD 10 and self-reported)
• 707 grade IV or greater hypertension at imaging visit
• 349 extremes of BMI (<16 or >40)
• 551 outlying aortic phenotype values (>4SDs from mean, which gives a cut off for AA diameter around 45mm).
• 930 without genotyped data or fail genotype QC
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
In the paper, GWAS has been performed with Areas and distensibility. The genetic model was adjusted for age at the time of imaging, sex, mean arterial pressure, height, and weight.
```

```
lambda = round(median((qnorm(gwasResults$P / 2) ) ^2 ) / 0.454, 3)
It can be used to assess whether there is any genomic inflation in your GWAS results. In a well-conducted GWAS with no systematic bias, you would expect the lambda value to be close to 1.0.

Lambda ≈ 1.0: This is ideal and suggests that there is no significant genomic inflation. Your test statistics are not overly influenced by factors like population structure or other biases.

Lambda < 1.0: A lambda value less than 1.0 can indicate that the test statistics are deflated. This could be due to factors like overcorrection for population structure or other biases.

Lambda > 1.0: A lambda value greater than 1.0 can indicate that the test statistics are inflated. This could be due to population structure, cryptic relatedness, or other sources of bias in your analysis.
```

```
Tutorial PRS -> <https://choishingwan.github.io/PRS-Tutorial/>
```

# Post-GWAS

Step 1: Create a conda env: conda create -n crossmap python=3 pip3 install Crossmap pip3 install Crossmap --upgrade

Step 2: Run the crossmap to convert from GRCh37 to GRCh38 (following : https://crossmap.sourceforge.net/) CrossMap bed hg19ToHg38.over.chain.gz input_crossmap_ao.bed output.bed

myfile.bed looks like (rename .txt to .bed) chr start_pos end_pos 1 2560 2560 ##if end position is not there then you can add end position same
```
awk '{print "chr" $1, $3, $3}' abi_ao_snps.txt > input_crossmap_ao.txt and remove header after that.
```
Download liftover file from  https://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/ 
```
wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz
```
##i have also changed the id in vcf file to chr_position using plink2

```
plink2  --set-missing-var-ids @:# --vcf GTEx_Analysis_2017-06-05_v8_WholeGenomeSeq_838Indiv_Analysis_Freeze.SHAPEIT2_phased.vcf --out outputfile
 ```
#To extract the variants from GTEx file 
#GTEx file is in hg38 and ukb variants are in hg37. Use crossmap to liftover the variants. 
```
module load singularity singularity shell -B ../../../data3/mchopra/ /data/containers/depot.galaxyproject.org-singularity-bcftools-1.16--hfe4b78e_1.img bcftools view -i'ID=@snps_list_ao.txt' GTEx_chr_PosID.vcf > output.vcf OR bcftools filter --include 'ID=@MySNPs.list' .phased.vcf.gz > output.vcf
```

Step 2: Run the crossmap to convert from GRCh37 to GRCh38 (following : https://crossmap.sourceforge.net/) CrossMap bed 
```
hg19ToHg38.over.chain.gz input_crossmap_ao.bed output.bed
```
myfile.bed looks like (rename .txt to .bed) chr start_pos end_pos 1 2560 2560 ##if end position is not there then you can add the end position same

```
awk '{print "chr" $1, $3, $3}' abi_ao_snps.txt > input_crossmap_ao.txt
```
and remove the header after that.

Download liftover file from https://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/ wget https://hgdownload.soe.ucsc.edu/goldenPath/hg19/liftOver/hg19ToHg38.over.chain.gz

##i have also changed the id in vcf file to chr_position using plink2
```
module load singularity singularity shell -B ../../../data3/mchopra/ /data/containers/depot.galaxyproject.org-singularity-bcftools-1.16--hfe4b78e_1.img bcftools view -i'ID=@snps_list_ao.txt' GTEx_chr_PosID.vcf > output.vcf OR bcftools filter --include 'ID=@MySNPs.list' .phased.vcf.gz > output.vcf
```

# Later, do the regression analysis


[if need to use crossmap on vcf files: 
CrossMap.py vcf hg38ToHg19.over.chain.gz GTEx_chr_posID.vcf Homo_sapiens.GRCh37.dna.primary_assembly.fa  output.vcf 
]
