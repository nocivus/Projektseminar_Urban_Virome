FROM continuumio/miniconda3:latest
# continuumio base image is deprecated, official successor is:
# anaconda/miniconda:latest

# Set working directory
WORKDIR /data

# Install required system dependencies
RUN apt-get update && apt-get install -y \
    curl \
    wget \
    git 

RUN conda install -c conda-forge -c bioconda \
    snakemake \
    kraken2 \
    bracken \
    pandas 

COPY . /data

RUN mkdir -p /data/database/k2_viral_20260226 \
    && curl -L https://genome-idx.s3.amazonaws.com/kraken/k2_viral_20260226.tar.gz \
    | tar -xzf - -C /data/database/k2_viral_20260226/ \
    && pwd && ls -la /data/database



RUN cd /data && \
    for dir in cities/*/reads; do \
        if [ -d "$dir" ]; then \
            echo "Entering /data/$dir"; \
            cd "/data/$dir"; \
            for script in *.sh; do \
                [ -f "$script" ] && echo "Running $script" && chmod +x "$script" && bash "$script"; \
            done; \
            cd /data; \
        fi; \
    done

RUN cd /data && \
    snakemake --cores 8 cities/Quito/smk_output/Quito_merged_reads.csv