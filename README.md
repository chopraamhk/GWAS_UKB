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

#STEP 1:
Download .bim, .bed, .fam files
```
sinfo bed.sh
sinfo fam.sh
sinfo bim.sh
```

#STEP 2:
extract only 60604 samples from file keep.txt and use the below bash script with the plink command. Note that we have chromosome files not merged. 
```
sinfo extract_keep.sh
```

#STEP3:
PLINK QC

#STEP4:
Merge all the chromosome files to one file using plink 

#STEP4:
GWAS ANALYSIS
