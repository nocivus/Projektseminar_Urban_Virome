configfile: "config.yaml"

rule all:
	input:
		"cities/{city}/smk_output/merged_reads.csv"

rule kraken_classification:
	input:
		db="database/k2_viral_20260226", 
		read1="cities/{city}/reads/{sample}_1.fastq.gz",
		read2="cities/{city}/reads/{sample}_2.fastq.gz"
	output:
		temp("cities/{city}/smk_output/kraken/{sample}.output"),
		temp("cities/{city}/smk_output/kraken/{sample}.report")
	shell:
		"kraken2 --db {input.db} --threads 8 --output cities/{wildcards.city}/smk_output/kraken/{wildcards.sample}.output --report cities/{wildcards.city}/smk_output/kraken/{wildcards.sample}.report --paired {input.read1} {input.read2}"
		
rule bracken_report:
	input:
		db="database/k2_viral_20260226", 
		kreport="cities/{city}/smk_output/kraken/{sample}.report"
	output:
		brck="cities/{city}/smk_output/bracken/{sample}.bracken",
		brep="cities/{city}/smk_output/bracken/{sample}.breport"
	params:
		level=config["classification_level"]
	shell:
		"bracken -d {input.db} -i {input.kreport} -r 100 -l {params.level} -t 10 -o {output.brck} -w {output.brep}"
		
rule to_csv:
	input:
		"cities/{city}/smk_output/bracken/{sample}.breport"
	output:
		temp("cities/{city}/smk_output/{sample}.csv")
	params:
		level=config["classification_level"]
	script:
		"scripts/to_csv.py"
		
rule merge_csv:
	input:
		csv=expand("cities/{{city}}/smk_output/{sample}.csv", city=config["Cities"], sample=lambda wildcards: config[wildcards.city]["samples"])
	output:
		"cities/{city}/smk_output/merged_reads.csv"
	script:
		"scripts/merge_csv.py"
