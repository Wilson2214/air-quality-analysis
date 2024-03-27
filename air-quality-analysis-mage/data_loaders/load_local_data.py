import pandas as pd
import glob


@data_loader
def load_data_from_file(*args, **kwargs):
    
    # https://saturncloud.io/blog/how-to-read-multiple-csv-files-into-python-pandas-dataframe/
    # Get all files for year
    csv_files = glob.glob('air-quality-analysis-mage/data/month=*/*.csv.gz')

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

    # Loop through and load all data to a single dataframe
    for csv_file in csv_files:
        df = pd.read_csv(csv_file, sep=',', compression="gzip", dtype=aq_dtypes)
        combined_df = pd.concat([combined_df, df])

    # Fix Date Times
    combined_df['datetime']= pd.to_datetime(combined_df['datetime'], utc=True)
    combined_df['datetime'] = combined_df['datetime'].dt.strftime('%Y/%m/%d %H:%M:%S')

    return combined_df