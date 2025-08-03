# 1. Project Overview
This project analyzes ridership patterns on the Chicago Transit Authority's (CTA) elevated rail system, commonly known as the "L". Using SQL and Python, the project explores trends and insights to better understand how ridership has evolved and where service is most heavily used.

<img src="/images/justin-shen-3UD7z1MSLmI-unsplash.jpg" alt="Alt text" width="80%"/>
<p><sub>Photo by <a href="https://unsplash.com/@shenny_visuals?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Justin Shen</a> on <a href="https://unsplash.com/photos/a-train-traveling-over-a-bridge-next-to-tall-buildings-3UD7z1MSLmI?utm_content=creditCopyText&utm_medium=referral&utm_source=unsplash">Unsplash</a></sub></p>

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
* Joined cleaned ridership data with station metadata using station_id = map_id
* Removed four legacy stations that no longer appear in the current station dataset
* Verified no duplicates after merging
  
**Final result**: final_ridership table with station-level attributes (e.g., ADA access, line info)

**In Python**:
* Further refined station metadata, ensuring unique entries per map_id
* Merged in ADA accessibility and line information for grouped analysis
  
# 5. Analysis
Analysis was conducted in Python using Pandas, GeoPandas, and Matplotlib/Seaborn.

*Ridership Over Time*:
* Daily ridership plummeted in 2020 and has not returned to pre-pandemic levels.
 
*Station-Level Patterns*:
* Downtown transfer stations like Lake, Clark/Lake, and Jackson are the busiest.
 
*ADA Accessibility by Line*:
* ADA accessibility varies by line:
* Pink, Yellow, and Brown Lines have over 90% of stations ADA accessible.
* Purple Line and Blue Line have the lowest at just 25% and 42%, respectively.


# 6. Key Takeaways
1. **Ridership Has Not Recovered to Pre-COVID Levels**
   
	Average ridership is still only ~63% of pre-COVID levels.

3. **Accessibility Gaps Vary Greatly by Line**
   
	ADA access is highest on the Yellow and Pink Lines, lowest on Purple and Blue—highlighting equity concerns.

4. **High Ridership is Concentrated at a Few Key Stations**
   
	Stations like Lake, O’Hare, and Clark/Lake handle the most riders due to their centrality and transfer options.
