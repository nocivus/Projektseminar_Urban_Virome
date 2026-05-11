from snakemake.utils import min_version
min_version("6.0")

configfile: "config.yaml"

module weather_workflow:
	snakefile: "smk/weather.smk"

use rule * from weather_workflow as weather_*

CITY,SAMPLE = glob_wildcards("cities/{city}/reads/{sample}_1.fastq.gz")
CITY_SAMPLES = {city: [sample for c, sample in zip(CITY, SAMPLE) if c == city] for city in set(CITY)}

rule all:
	input:
		"report.txt"

rule kraken_classification:
	input:
		db="database/k2_viral_20260226", 
		read1="cities/{city}/reads/{sample}_1.fastq.gz",
		read2="cities/{city}/reads/{sample}_2.fastq.gz"
	output:
		temp("cities/{city}/smk_output/kraken/{sample}.output"),
		temp("cities/{city}/smk_output/kraken/{sample}.report")
	threads: 8
	shell:
		"kraken2 --db {input.db} --threads {threads} --output cities/{wildcards.city}/smk_output/kraken/{wildcards.sample}.output --report cities/{wildcards.city}/smk_output/kraken/{wildcards.sample}.report --paired {input.read1} {input.read2}"
		
rule bracken_report:
	input:
		db="database/k2_viral_20260226", 
		kreport="cities/{city}/smk_output/kraken/{sample}.report"
	output:
		brck=temp("cities/{city}/smk_output/bracken/{sample}.bracken"),
		brep=temp("cities/{city}/smk_output/bracken/{sample}.breport")
	params:
		level=config["classification_level"]
	threads: 1
	shell:
		"bracken -d {input.db} -i {input.kreport} -r 100 -l {params.level} -t 10 -o {output.brck} -w {output.brep}"
		
rule to_csv:
	input:
		"cities/{city}/smk_output/bracken/{sample}.breport"
	output:
		"cities/{city}/smk_output/sample_csv/{sample}.csv"
	params:
		level=config["classification_level"]
	threads: 1
	script:
		"scripts/to_csv.py"
		
rule merge_csv:
	input:
		csv=expand("cities/{{city}}/smk_output/sample_csv/{sample}.csv", city=CITY, sample=lambda wildcards: CITY_SAMPLES[wildcards.city])
	output:
		"cities/{city}/smk_output/{city}_merged_reads.csv"
	threads: 1
	script:
		"scripts/merge_csv.py"

rule create_all:
	input:
		weather=expand("cities/{city}/smk_output/{city}_weather.csv", city=CITY),
		list=expand("cities/{city}/smk_output/{city}_merged_reads.csv", city=CITY)
	output:
		"report.txt"
	threads: 1
	shell:
		"""
		echo {input.weather} > {output}
		echo {input.list} >> {output}
		"""