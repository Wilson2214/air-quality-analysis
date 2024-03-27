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

<img width="338" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/71f516ca-43bd-4c05-9de6-93813501256f">

Additionally, I provided a drop-down filter to isolate an individual city to easily compare them. In particular you can compare a city with poor transit options like Riverside, CA to see that average rush hour PM2.5 is generally higher than non-rush hour PM2.5 versus a city like Washington, DC with better transit options which has a more uniform breakdown of PM2.5 between rush hour and non-rush hour. You will also see in this comparison that DC tends to have an overall lower PM2.5 which could be correlated to transit options.

Riverside, CA:
<img width="248" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/66ec7eac-4dbd-43d0-84d2-41439a4d4d3a">

Washington, DC:
<img width="278" alt="image" src="https://github.com/Wilson2214/air-quality-analysis/assets/39279731/eb9428b4-28e7-4add-9a7f-c4e2dfb2a9a4">

# Data Infrastructure

# Reproducability



# Improvements

# References
[1] https://www.sciencedirect.com/science/article/abs/pii/S0959652621033989
[2] https://www.metro-magazine.com/10112565/best-and-worst-cities-for-commuting-on-public-transportation
[3] https://openaq.org/
[4] https://docs.openaq.org/docs/accessing-openaq-archive-data
[5] https://auto.howstuffworks.com/air-pollution-from-cars.htm
