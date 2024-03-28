# Air Quality Analysis
## A Comparison of Air Quality in Cities With and Without a High Share of Transit Usage
## by Dave Wilson

![image](https://github.com/Wilson2214/air-quality-analysis/assets/39279731/00a556e0-deec-46ab-800b-1c9ca9883877)

This repo contains all code for the final project of the Data Engineering Zoomcamp 2024. This project is an end-to-end ETL pipeline with a dashboard output. This particular project will show how I took data from the OpenAQ project, ingested it to GCP, transformed it with dbt in Big Query, and visualized it with Google Looker.

# Problem Description

Per the journal of cleaner production, "vehicle emissions are the primary source of particulate matter 2.5 (PM2.5) emissions and exposure to traffic-related air pollution can harm human health" [1]. Particulate Matter is "a mixture of solid particles and liquid droplets found in the air that contribute to atmospheric haze and can damage your lungs and get into your bloodstream" [5].

Knowing this I wanted to see if there was a noticeable impact on PM2.5 emissions in cities where there was more access to public transportation than in cities with predominantly car infrastructure. I decided to investigate 4 cities [2]:

1. Washington, DC: Transit User Share of 13.57%
2. New York / New Jersey: Transit User Share of 31%
3. Dallas, TX: Transit User Share of 1.43%
5. Riverside, CA: Transit User Share of 1.39% (A close suburb of Los Angeles, CA)

I chose 2 locations with high transit user share versus vehicle usage. Additionally, all 4 of these cities consistently rank at the top of the list for worst traffic. My goal with this project to see on average if PM2.5 emissions were higher in cities without transit options as these cities relied on more vehicle traffic creating more emissions. I also wanted to compare PM2.5 levels during rush hour periods (defined as between the hours of 6am-10am and 3pm-7pm) and non-rush hour periods to see if the increase in vehicle traffic led to higher PM2.5 levels.

I was able to source my data from the OpenAQ, a "nonprofit organization providing universal access to air quality data to empower a global community of changemakers to solve air inequality" [3].

# Results

My final visualization includes a chart which visualizes categorical monthly averages of PM2.5 during rush hour and non-rush hour periods, a temporal chart which shows the variation of PM2.5 on a daily basis overtime, and a few widgets displaying overall average PM2.5, maximum PM2.5, and a table of the locations with their transit information. I believe this dashboard does a good job of representing the overall data and shows some interesting regional and temporal variations in PM2.5 data.

<img width="675" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/fd3df2a9-2cd2-4137-a494-cd850c0a2240">

Additionally, I provided a drop-down filter to isolate an individual city to easily compare them. In particular you can compare a city with poor transit options like Riverside, CA to see that average rush hour PM2.5 is generally higher than non-rush hour PM2.5 versus a city like Washington, DC with better transit options which has a more uniform breakdown of PM2.5 between rush hour and non-rush hour. You will also see in this comparison that DC tends to have an overall lower PM2.5 which could be correlated to transit options.

Riverside, CA:

<img width="675" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/ec8c472b-f3de-4254-b1dd-076cf5e92032">


Washington, DC:

<img width="675" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/8f1b6aaf-8554-49ac-bb6f-396f63b366e3">

[Link to Dashboard](https://lookerstudio.google.com/s/oetwCyQBWvc). Note: This relies on the underlying data structure which is destroyed with terrraform. Depending on when this link is selected, no data may be present. I've additionally included a pdf of the main view of my dashboard [here](https://github.com/Wilson2214/air-quality-analysis/blob/main/outputs/Air_Quality_Analysis.pdf).

# Data Stack

This project utilizes the resources from the 2024 Cohort of the Data Engineerin ZoomCamp [6]. 

**Scripting**: Python with some Shell Coding (AWS CLI)

**Cloud Platform**: Google Cloud Platform (IAM, GCP Cloud Storage, Big Query Data Warehouse)

**Containerization**: Docker

**Infrastructure as Code (IAC)**: Terraform

**Batch Processing**: Python and Pandas, SQL

**Workflow Orchestration**: Mage

**ELT Transformation**: dbt

**Visualization**: Google Looker Studio

<img width="825" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/f85a0109-63f5-4d85-bddb-2c93c0a954f2">

Description: Data is ingested from source S3 bucket via a python script. Terraform is used to build GCP Bucket and BigQuery infrastructure. Docker is used to spin up a container with Mage. Mage is used to orchestrate python scripts to load data from local file to GCP bucket, then GCP bucket with schema transformations to BigQuery. dbt is then used to transform data within BigQuery to final tables which are used by Looker for visualization.

# Improvements

The most significant technical improvement I could have made was related to ingesting the initial dataset. Data was available from OpenAQ in a variety of methods including API, direct access to csv.gz files, and via the AWS CLI. Because I wanted to ingest a significant amount of data (1 year for four cities), I chose not to use the API. Additionally, direct access would be time consuming and require individual downloading of thousands of individual daily csvs. Problematically though, AWS CLI was incompatible with Mage, my orchestration tool. In reality I would avoid downloading data from AWS then uploading to GCP in my pipeline. I would likely set up a process to migrate the data from one system to the other, then perform a daily scrape with the API to get additional data. As we are getting a year's worth of data the only optimal method is to perform a direct copy with AWS CLI and do this outside of the orchestrator.

Additionally, I could have expanded my dataset to include many more cities and longer periods of time. For this project I only selected one year of data, but much more data was available. I think this would benefit in exploring my hypothesis.

Finally, there are some big changes I would make regarding the scientific nature of my study. In particular I would explore some of the other pollutants that OpenAQ provides data on. I would also want to incorporate more information about commute tendencies and try to further understand how increased road traffic during rush hour coincides with increases in PM2.5. Further, I would want to explore other sources of PM2.5 and try to determine why and when spikes occur. This project was focused on the technical nature of building a data pipeline though, so I did not explore these further.

# Reproducibility

The Steps below detail how you can create this project.

## Prerequisites

1. [Install Python 3](https://www.python.org/downloads/)
2. [Install and Configure Git Client](https://docs.github.com/en/github-cli/github-cli/quickstart)
3. [Install Docker](https://docs.docker.com/engine/install/)
4. [Install Terraform](https://developer.hashicorp.com/terraform/install)
5. [Install and setup AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-getting-started.html).

## Local Environment Setup

1. Optionally [fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo) into your own Github then [clone the repo](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) to your local machine
2. Once you have a repository on your machine, navigate to that directory via the CLI or using an IDE like VSCode.
3. Optionally, but highly recommended, create and activate a virtual environment with:

```
python3 -m venv air-quality-venv
. air-quality-venv/bin/activate
```

If you are using VSCode you may also want to enter `cmd+shift+p`  to select this new virtual environment.

4. Install libraries with

```
pip install -r requirements.txt
```

## Google Cloud Setup

1. Navigate to the [Google Cloud Platform Console](https://console.cloud.google.com/) and create an account if you do not already have one.
2. [Create a new Google Project](https://developers.google.com/workspace/guides/create-project). Be sure to record the project ID from the home page of the project in the console:

<img width="430" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/658f289f-9bca-4ba1-8d19-d10a4f1929c5">

3. Navigate to the IAM portal in GCP and [create a service account](https://cloud.google.com/iam/docs/service-accounts-create). It is recommended to simply give this account the 'Owner' role, but this is over-permissioned. Feel free to limit permissions as needed.
4. [Create a service account key](https://cloud.google.com/iam/docs/keys-create-delete) for your new service account. Be sure to select JSON download which will create a JSON file with your key and download it to your local system.

<img width="522" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/2f6079fc-a765-4871-a071-e1c04a8b731e">

5. Copy this downloaded json file into the home directory of your air-quality-analysis repo previously created. Rename this file `my_creds.json`. This file is ignored with .gitignore so you should not worry about it being added to your repo.

## Terraform Infrastructure

Now that you have a service account with credentials stored in your local repo, you can terraform the cloud infrastructure. The terraform plan will create 4 GCP buckets (one for each city we are downloading air quality data for). It will also create a BigQuery dataset called air_quality_dataset.

1. Navigate to the `variables.tf` file in the terraform folder of your local repo. Confirm that the variable "credentials" is referencing your service account credentials stored at "../my_creds.json"

<img width="728" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/a3b26820-d4c2-48a6-8e6e-b17d500afec3">

2. Also, update the variable "project" with the project ID you created in the previous steps for GCP setup.

<img width="336" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/35ddc8d1-1565-4aa2-bcbd-2d29c3699bfe">

These two steps will connect your service account and project and allow terraform to create infrastructure.

3. Next you can init, plan, and apply the terraform infrastructure from your command line with:

```
terraform init
terraform plan
terraform apply
```

You may need to enter yes after planning and applying. Once complete you can navigate to GCP and confirm that the infrastructure has been built.

NOTE: be sure to run `terraform destroy` after working on this project to eliminate those resources and prevent unnecessary spend.

## Setup Docker and Mage

1. Create a `.env` file by copying the `dev.env` file with:

```
cp dev.env .env
```

This simply assigns a project name for mage.

2. From the home directory of your local repo, run the following commands:

```
docker compose build
docker compose up
```

This will build the docker image then startup the docker container. You can monitor and stop this docker container from the command line with `docker compose down` or from docker desktop. The docker container should be called `air-quality-analysis`

## Extract Data From Source System

The source data is located in an AWS S3 bucket as [described here](https://docs.openaq.org/docs/accessing-openaq-archive-data). I have created a python script with the sh library which queries the S3 bucket and downloads files for the entire year for all 4 cities. With the AWS CLI setup, this process is relatively quick and easy. We run the copy command with a '--no-sign-request' which means we do not need to provide credentials to access the data, but the CLI needs to be configured. In particular, the AWS CLI profile must be configured to the `us-east-1` region for the copy command to work. Feel free to see the previous link for additional documentation.

To extract the data, confirm you are in the local repo directory, then run:

```
python3 download_from_aws.py
```

This will download all data for the 4 cities for the year 2023 and store it locally under the mage folder `air-quality-analysis-mage` > `data`.

## Use Mage to Orchestrate Two Pipelines

1. With all prior setup and your docker container running, you can navigate to `localhost:6789` from your web browser to acess the interface for Mage. From here you can review the pipelines and triggers that have been created.
2. Next we will need to trigger our two pipelines sequentially. First is the `extract_raw_to_gcp` pipeline which takes our local data and adds it to GCP. To do this, run the following command for your CLI:

```
curl -X POST http://localhost:6789/api/pipeline_schedules/1/pipeline_runs/86c9a0275c314fb68f719581db074389
```

If this fails or you prefer to run via the GUI, navigate to the pipeline in Mage, select triggers, then select 'Run@once':

<img width="712" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/9af4f92c-805c-4383-adb7-993487fd2896">

You can also track the progress of this run from the GUI at the same location. This command will take a few minutes to run so you can either monitor the run under triggers or you can look at the GCP buckets you created and wait until they are populated.

3. Once the first pipeline has finished, you will trigger the `gcs_to_bigquery` pipeline which takes our bucket data in GCP, fixes the schema, and adds it to BigQuery. We also transform the data here by eliminating all data that is not PM2.5 data. To do this, run the following command for your CLI:

```
curl -X POST http://localhost:6789/api/pipeline_schedules/1/pipeline_runs/86c9a0275c314fb68f719581db074389
```

Again you can monitor this via Mage or wait until data has been updated in BigQuery.

With these pipelines completed, you can stop and exit your docker container

## Setup and Run dbt transformations

The final portion of this process is to transform the data in the data warehouse with dbt. You will need to setup a dbt account and connect it to your repo to deploy. You can follow [these steps from the ZoomCamp documentation](https://github.com/DataTalksClub/data-engineering-zoomcamp/blob/main/04-analytics-engineering/dbt_cloud_setup.md#create-a-dbt-cloud-project) to complete this process. Note that when connecting BigQuery to your account, you can use the `my_creds.json` file you downloaded and stored in your repo previously. Once your repo is connected, dbt will have all the files needed to run its models and generate new tables in Big Query. You will need to deploy with the following:

1. From cloud.getdbt.com navigate to "Deploy > Environments", then select create environment. Create an environment called 'Production' and save it (no credentials or other options required):

<img width="1431" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/8ed5b3a0-34ec-4a75-a58c-2ec22c5efd18">

2. Navigate to "Deploy > Jobs", then select 'Create Job > Deploy Job'. Give the job a name and be sure to select your 'Production' environment. Then under 'Execution Settings', add two commands. The first is `dbt build` and the second is `dbt run`. Save.

<img width="1438" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/601d26f1-853c-4d5a-8037-c059abf9137c">

3. Navigate to "Deploy > Jobs" and select the new job you created, then select 'Run Now'. This will run all dbt models, perform transformations, and load the data into a final BigQuery database.

<img width="1437" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/501e2498-2ca7-4aa2-9038-ea72a7b0bb4e">

You can check in BigQuery and confirm you have a database in your schema called `prod_air_quality_dataset`:

<img width="351" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/489b8d51-d8be-4a3b-89be-5603352b6753">

## Visualize

With all tables created, you can now use Looker or another BI platform to analyze the data. As mentioned previously, you should use `terraform destroy` to destroy your tables after running to avoid extra charges. This will remove the data from your database though rendering the dashboard obsolete.

# References
[1] https://www.sciencedirect.com/science/article/abs/pii/S0959652621033989

[2] https://www.metro-magazine.com/10112565/best-and-worst-cities-for-commuting-on-public-transportation

[3] https://openaq.org/

[4] https://docs.openaq.org/docs/accessing-openaq-archive-data

[5] https://auto.howstuffworks.com/air-pollution-from-cars.htm

[6] https://github.com/DataTalksClub/data-engineering-zoomcamp
