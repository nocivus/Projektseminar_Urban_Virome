# Projektseminar_Urban_Virome

### Installing required software:

### 1. Conda Package Manager

for install using Miniconda see: (https://www.anaconda.com/docs/getting-started/main)

### 2. Snakemake, Kraken2, Bracken

`conda install -c conda-forge -c bioconda snakemake`

`conda activate snakemake`

`conda install -c conda-forge -c bioconda kraken2 bracken pandas`



## Required folder structure:

> .../\{src\}/    
>    |── cities/        
>    |──── Yaounde/     
>    |──────── reads/    
>    |── database/
>    |── smk/         
>    |── scripts/        

**.../\{src\}/database** contains the (pre-built) Kraken 2 & Bracken databases.   
**.../\{src\}/cities/.../reads** contains the paired readings of the samples (..._1.fastq.gz & ..._2.fastq.gz)   
**.../\{src\}/scripts** contains merge_csv-py & to_csv.py   


## Data preparation
### k-mer Database
Pre-built Kraken2 and Bracken databases can be found [here.](https://benlangmead.github.io/aws-indexes/k2)   
The Database has to be unzipped and stored in an extra directory inside database/   
Example: .../src/database/k2_viral_20260226

### Input
Sample readings from the Global Urban Virome study are available at the [European Nucleotide Archive.](https://www.ebi.ac.uk/ena/browser/view/PRJEB87273)    
Both paired reads of a sample (..._1.fastq.gz & ..._2.fastq.gz) must be stored inside reads/

## config.yaml

set Classification Level:

`classification_level: G`

## Run

The snakemake file has to be run out of {src}

To generate the assambled matrix for the reads of Yaounde(Ecuador) run:

`snakemake --cores 8 cities/Yaounde/smk_output/Yaounde_merged_reads.csv`

Test run:

`snakemake -n cities/Yaounde/smk_output/Yaounde_merged_reads.csv`

## Example CSVs

<img width="1950" height="1170" alt="Bildschirmfoto 2026-04-29 um 14 43 08" src="https://github.com/user-attachments/assets/e4255e73-36d7-4fd1-b4d6-15b49b80fa7a" />

<img width="857" height="578" alt="grafik" src="https://github.com/user-attachments/assets/50135a60-3441-4058-9541-5593a15c9fe7" />
