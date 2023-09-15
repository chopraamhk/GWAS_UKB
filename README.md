# ukb_GWAS

#installation of miniconda::
```
mkdir -p ~/miniconda3
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda3/miniconda.sh
bash ~/miniconda3/miniconda.sh -b -u -p ~/miniconda3
rm -rf ~/miniconda3/miniconda.sh
```

After installing, initialize your newly-installed Miniconda. The following commands initialize for bash and zsh shells:

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

#STEP3:
PLINK QC

#STEP4:
Merge all the chromosome files to one file using plink 

#STEP4:
GWAS ANALYSIS
