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

[Link to Dashboard](https://lookerstudio.google.com/s/oetwCyQBWvc). Note: This relies on the underlying data structure which is destroyed with terrraform. Depending on when this link is selected, no data may be present.

# Data Stack

This project utilizes the resources from the 2024 Cohort of the Data Engineerin ZoomCamp [6]. 

**Scripting**: Python with some Shell Coding

**Cloud Platform**: Google Cloud Platform (IAM, GCP Cloud Storage, Big Query DWH)

**Containerization**: Docker

**Infrastructure as Code**: Terraform

**Batch Processing**: Python and Pandas, SQL

**Workflow Orchestration**: Mage

**ELT Transformation**: dbt

**Visualization**: Google Looker Studio

[NEED TO CREATE AND INSERT VISUAL DEPICTION HERE]

# Reproducability



# Improvements

The most significant technical improvement I could have made was related to ingesting the initial dataset. Data was available from OpenAQ in a variety of methods including API, direct access to csv.gz files, and via the AWS CLI. Because I wanted to ingest a significant amount of data (1 year for four cities), I chose not to use the API. Additionally, direct access would be time consuming and require individual downloading of thousands of individual daily csvs. Problematically though, AWS CLI was incompatible with Mage, my orchestration tool. In reality I would avoid downloading data from AWS then uploading to GCP in my pipeline. I would likely set up a process to migrate the data from one system to the other, then perform a daily scrape with the API to get additional data. As we are getting a year's worth of data the only optimal method is to perform a direct copy with AWS CLI and do this outside of the orchestrator.

Additionally, I could have expanded my dataset to include many more cities and longer periods of time. For this project I only selected one year of data, but much more data was available. I think this would benefit in exploring my hypothesis.

Finally, there are some big changes I would make regarding the scientific nature of my study. In particular I would explore some of the other pollutants that OpenAQ provides data on. I would also want to incorporate more information about commute tendencies and try to further understand how increased road traffic during rush hour coincides with increases in PM2.5. Further, I would want to explore other sources of PM2.5 and try to determine why and when spikes occur. This project was focused on the technical nature of building a data pipeline though, so I did not explore these further.

# References
[1] https://www.sciencedirect.com/science/article/abs/pii/S0959652621033989

[2] https://www.metro-magazine.com/10112565/best-and-worst-cities-for-commuting-on-public-transportation

[3] https://openaq.org/

[4] https://docs.openaq.org/docs/accessing-openaq-archive-data

[5] https://auto.howstuffworks.com/air-pollution-from-cars.htm

[6] https://github.com/DataTalksClub/data-engineering-zoomcamp
