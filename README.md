# Projektseminar_Urban_Virome

## Docker 

### 1. Build the Docker Image

```bash
docker build -t data-preparation-kraken-db .
```

---

### 2. Start the Container

```bash
docker run -it --name kraken-db data-preparation-kraken-db /bin/bash
```

---

### 3. Copy Data from the Container to the Local Repository (example)

Run the following command outside the container:

```bash
docker cp kraken-db:/data/cities/Quito/smk_output ./smk_output
```

This copies the complete content from:

```text
/data/cities/Quito/smk_output
```

into the local directory:

```text
./smk_output
```

---

### 4. Optional: Remove the Container

```bash
docker rm kraken-db
```

## Manual Installation:

### 1. Conda Package Manager

for install using Miniconda see: (https://www.anaconda.com/docs/getting-started/main)

### 2. Snakemake, Kraken2, Bracken

`conda install -c conda-forge -c bioconda snakemake`

`conda activate snakemake`

`conda install -c conda-forge -c bioconda kraken2 bracken pandas`



## Required folder structure:

> .../\{project path\}/    
>    |── cities/        
>    |──── Yaounde/     
>    |──────── reads/    
>    |── database/    
>    |── smk/         
>    |── scripts/        

**.../\{project path\}/database** contains the (pre-built) Kraken 2 & Bracken databases.   
**.../\{project path\}/cities/.../reads** contains the paired readings of the samples (..._1.fastq.gz & ..._2.fastq.gz)   
**.../\{project path\}/scripts** contains merge_csv-py & to_csv.py   


## Data preparation
### k-mer Database
Pre-built Kraken2 and Bracken databases can be found [here.](https://benlangmead.github.io/aws-indexes/k2)   
The Database has to be unzipped and stored in an extra directory inside database/   
Example: .../project path/database/k2_viral_20260226

### Input
Sample readings from the Global Urban Virome study are available at the [European Nucleotide Archive.](https://www.ebi.ac.uk/ena/browser/view/PRJEB87273)    
Both paired reads of a sample (..._1.fastq.gz & ..._2.fastq.gz) must be stored inside reads/

## config.yaml

set Classification Level:

`classification_level: G`

## Run

The snakemake file has to be run out of {project path}

To generate the assembled matrix for the reads of Ecuador run:

`snakemake --cores 8 cities/Quito/smk_output/Quito_merged_reads.csv`

Test run:

`snakemake -n cities/Quito/smk_output/Quito_merged_reads.csv`

To run the pipeline for all cities listed in config.yaml at once, run:    

`snakemake --cores 8 report.txt`   

(all read-files listed in config.yaml have to be present in the designated city directories for the pipeline to run)

## Example CSVs

<img width="1950" height="1170" alt="Bildschirmfoto 2026-04-29 um 14 43 08" src="https://github.com/user-attachments/assets/e4255e73-36d7-4fd1-b4d6-15b49b80fa7a" />

<img width="857" height="578" alt="grafik" src="https://github.com/user-attachments/assets/50135a60-3441-4058-9541-5593a15c9fe7" />

[comment]: <> (Webhook Test)
