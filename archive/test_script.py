# Initial testing for creating a script to load data from local in mage

import pandas as pd
import numpy as np
import datetime
import glob

csv_files = glob.glob('air-quality-analysis-mage/data/month=01/*.csv.gz')

# Create baseline dataframe
combined_df = pd.DataFrame()

# Force Data Types
aq_dtypes = {
                    'location_id': str,
                    'sensors_id': str,
                    'location': str,
                    'lat': float,
                    'lon': float,
                    'parameter': str,
                    'units': str,
                    'value': float
                }
parse_dates = ['datetime']

# Loop through and load all data to a single dataframe
for csv_file in csv_files:
    df = pd.read_csv(csv_file, sep=',', compression="gzip", dtype=aq_dtypes, parse_dates=parse_dates)
    combined_df = pd.concat([combined_df, df])

combined_df['datetime']= pd.to_datetime(combined_df['datetime'])

print(combined_df.dtypes)
print(combined_df.head)