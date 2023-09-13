# ukb_data_extract

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

#STEP 2:
extract only 60604 samples from file keep.txt and use the below bash script with the plink command. Note that we have chromosome files not merged. 
```
#!/bin/bash
#
#SBATCH --job-name="plink"
#SBATCH -o plink.o%j
#SBATCH -e plink.e%j
#SBATCH --mail-user=m.chopra1@universityofgalway.ie
#SBATCH --mail-type=ALL
#SBATCH --partition="highmem"
#SBATCH -n 32
#SBATCH -N 1

#code
for i in {1..22}
do
plink2 --bfile ukb_genotypic_files/ukb22418_c"$i"_b0_v2 --keep ukb_genotypic_files/keep.txt --make-bed --out ukb_distensibility_genotypic_files/ukb_distensibility_c_"$i"
done
```

#STEP3:
PLINK QC

#STEP4:
Merge all the chromosome files to one file using plink 

#STEP4:
GWAS ANALYSIS
