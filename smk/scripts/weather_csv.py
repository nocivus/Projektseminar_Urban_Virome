import pandas as pd

df = pd.read_csv(snakemake.input[0], names=("time", "temperature_2m_mean (°C)", "temperature_2m_max (°C)", "temperature_2m_min (°C)", "rain_sum (mm)", "relative_humidity_2m_mean (%)")).drop(index=[0,1,2])

df.to_csv(snakemake.output[0], index=False)