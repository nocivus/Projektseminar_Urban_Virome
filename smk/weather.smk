configfile: "smk/weather_config.yaml"

rule get_weather:
	output:
		temp("cities/{city}/smk_output/weather_temp.csv")
	params:
		latitude=lambda wildcards: config[wildcards.city][0],
		longitude=lambda wildcards: config[wildcards.city][1]
	threads: 1
	shell:
		"wget 'https://archive-api.open-meteo.com/v1/archive?latitude={params.latitude}&longitude={params.longitude}&start_date=2017-01-01&end_date=2019-12-31&daily=temperature_2m_mean,temperature_2m_max,temperature_2m_min,rain_sum,relative_humidity_2m_mean&timezone=GMT&format=csv' -O {output}"

rule to_csv:
	input:
		"cities/{city}/smk_output/weather_temp.csv"
	output:
		"cities/{city}/smk_output/{city}_weather.csv"
	threads: 1
	script:
		"scripts/weather_csv.py"