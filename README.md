# 1. Project Overview
This project analyzes ridership patterns on the Chicago Transit Authority's (CTA) elevated rail system, commonly known as the "L". Using SQL and Tableau, the project explores trends and insights to better understand how ridership has evolved and where service is most heavily used.

## Key Questions:
* How has ridership changed over time? Has it recovered to pre-COVID levels?
* Which lines are the most ADA accessible? 
- Measured by the number of ADA-accessible stations per line.
* Which lines and stations are the busiest? And the least busy?

## Tools Used:
* PostgreSQL: data cleaning and SQL queries
* Python: analysis and visualization (Pandas, GeoPandas, Folium)


# 2. Data Sources
All data for this project comes from the City of Chicago’s Open Data Portal, which provides publicly available datasets related to city infrastructure, transportation, and more.


I used two primary datasets:

1. [CTA 'L' Station Information](https://data.cityofchicago.org/Transportation/CTA-System-Information-List-of-L-Stops/8pix-ypme/about_data):
* Contains metadata about each stop, including direction, station name, and which lines it serves.
* Key columns: station_name, map_id, direction_id, and line indicators such as red, blue, green, etc.

2. [CTA 'L' Station Entries - Daily Totals](https://data.cityofchicago.org/Transportation/CTA-Ridership-L-Station-Entries-Daily-Totals/5neh-572f/about_data)
* Contains daily ridership counts (entries only) for each station, beginning in 2001. 
* Key columns: station_id, station_name, ride_date, day_type, rides

# 3. Database Setup
The raw datasets were initially cleaned and explored using SQL in PostgreSQL. Relevant transformations included:

* Handling missing station names
* Creating year and month columns
* Filtering to rail stations only
* Exporting cleaned results for use in Python

# 4. Data Exploration and Cleaning
Data cleaning was a critical step in preparing this analysis and was split across SQL (PostgreSQL) and Python (Pandas/GeoPandas):

**In SQL**:
Initial Exploration:
* Inspected both ridership_l_stations and l_station_info tables
* Verified table sizes (1.25M+ records in ridership, 302 in station info)
* Confirmed minimal/null values in key columns
Duplicate Detection & Handling:
* Identified ~600 duplicated (station_id, ride_date) pairs
* Verified all duplicates were exact pairs (no triple duplicates)
* Calculated differences in ride counts among duplicates
* Cleaned data by averaging ride counts across duplicates
Merging Metadata:
Joined cleaned ridership data with station metadata using station_id = map_id
Removed four legacy stations that no longer appear in the current station dataset
Verified no duplicates after merging
Final result: final_ridership table with station-level attributes (e.g., ADA access, line info)

**In Python**:
	•	Further refined station metadata, ensuring unique entries per map_id
	•	Merged in ADA accessibility and line information for grouped analysis
	•	Loaded spatial shapefiles to support geographic analysis and mapping
	•	Standardized GEOID fields for tract-level joins
	•	Prepared merged datasets for exploration of population overlays and density calculations
# 5. Analysis
Analysis was conducted in Python using Pandas, GeoPandas, and Matplotlib/Seaborn.
*Ridership Over Time*:
* Daily ridership plummeted in 2020 and has not returned to pre-pandemic levels.
* 2023 ridership remains significantly lower than 2019.
*Line-Level Trends*:
* The Red and Blue Lines consistently have the highest ridership.
* The Yellow Line and Purple Express show the lowest total rides.
*ADA Accessibility by Line*:
* ADA accessibility varies by line:
* Pink, Yellow, and Brown Lines have over 90% of stations ADA accessible.
* Purple Line has the lowest at just 25%.
*Station-Level Patterns*:
* Downtown transfer stations like Lake, Clark/Lake, and Jackson are the busiest.
* Outlying or express-only stations (e.g., Dempster–Skokie, Central) see very low ridership.
*Station Distribution and Coverage*:
* The Blue Line has the most stations (33), followed by the Red (30) and Green (29).
* Yellow Line has just two stations but is 100% ADA accessible.

# 6. Key Takeaways
1. **Ridership Has Not Recovered to Pre-COVID Levels**
Average monthly ridership across all months remains significantly below pre-pandemic levels. As of the most recent data, total ridership is only about 63% of what it was before COVID-19.
2. **Accessibility Gaps Vary Greatly by Line**
ADA accessibility is uneven across lines. The Yellow and Pink Lines are the most accessible, while Purple and Blue Lines have the lowest percentage of accessible stations, highlighting equity issues in access.
3. **High Ridership is Concentrated at a Few Key Stations**
Since May 2023, stations like Lake (Red Line), O'Hare (Blue Line), and Clark/Lake (multi-line) have seen the highest total ridership. These are major hubs and transfer points.
