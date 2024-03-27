import sh

# https://stackoverflow.com/a/70291292
def s3_cp(source, target, **kwargs):
    """
    Copy data from source to target. Include flags as kwargs
    such as recursive=True and include=xyz
    """
    args = []
    for flag_name, flag_value in kwargs.items():
        if flag_value is not False:  # i.e. --quiet=False means omit --quiet
            args.append(f"--{flag_name}")
        if flag_value is not True:  # i.e. --quiet=True means --quiet      
            args.append(flag_value)
        args.append('--no-sign-request')
    args += [source, target]
    sh.aws("s3", "cp", *args)

# Dallas ID: 2158
print('Downloading Dallas Air Quality Data')
s3_cp("s3://openaq-data-archive/records/csv.gz/locationid=2158/year=2023", 
        "air-quality-analysis-mage/data/dallas-data/", quiet=True, recursive=True)
print('Dallas Air Quality Data successfully downloaded')

# Riverside ID: 32896
print('Downloading Riverside Air Quality Data')
s3_cp("s3://openaq-data-archive/records/csv.gz/locationid=32896/year=2023", 
        "air-quality-analysis-mage/data/riverside-data/", quiet=True, recursive=True)
print('Riverside Air Quality Data successfully downloaded')

# NYNJ ID: 928
print('Downloading NY/NJ Air Quality Data')
s3_cp("s3://openaq-data-archive/records/csv.gz/locationid=928/year=2023", 
        "air-quality-analysis-mage/data/nynj-data/", quiet=True, recursive=True)
print('NY/NJ Air Quality Data successfully downloaded')

# DC ID: 739
print('Downloading DC Air Quality Data')
s3_cp("s3://openaq-data-archive/records/csv.gz/locationid=739/year=2023", 
        "air-quality-analysis-mage/data/dc-data/", quiet=True, recursive=True)
print('DC Air Quality Data successfully downloaded')
