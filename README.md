# Projektseminar_Urban_Virome

### Installing required software:

### 1. Conda Package Manager

for install using Miniconda see: (https://www.anaconda.com/docs/getting-started/main)

### 2. Kraken2, Bracken, Krakentools

`conda install -c conda-forge -c bioconda snakemake`

`conda activate snakemake`

`conda install -c conda-forge -c bioconda kraken2 bracken pandas`



## Required folder structure:

> .../\{src\}/  
>    |── cities/        
>    |──── Ecuador/
>    |──────── reads/
>    |── database/           
>    |── scripts/        

**.../\{src\}/database** contains the (pre-built) Kraken 2 & Bracken databases.   
**.../\{src\}/cities/.../reads** contains the paired readings of the samples (..._1.fastq.gz & ..._2.fastq.gz)   
**.../\{src\}/scripts** contains merge_csv-py & to_csv.py   


## Data preparation
### k-mer Database
Pre-built Kraken2 and Bracken databases can be found [here.](https://benlangmead.github.io/aws-indexes/k2)   
The Database has to be unzipped and stored in an extra directory inside ./database/   
Example: .../src/database/k2_viral_20260226

### Input
Sample readings from the Global Urban Virome study are available at the [European Nucleotide Archive.](https://www.ebi.ac.uk/ena/browser/view/PRJEB87273)    
Both paired reads of a sample (..._1.fastq.gz & ..._2.fastq.gz) must be stored inside ./reads/

## Run

The snakemake file has to be run out of {src}

To generate the assambled matrix for the reads of Ecuador run:

`snakemake --cores 8 cities/Ecuador/smk_output/merged_reads.csv`

Test run:

`snakemake -n cities/Ecuador/smk_output/merged_reads.csv`
