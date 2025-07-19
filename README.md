# 1. Project Overview
This project analyzes ridership patterns on the Chicago Transit Authority's (CTA) elevated rail system, commonly known as the "L". Using SQL and Tableau, the project explores trends and insights to better understand how ridership has evolved and where service is most heavily used.

## Key Questions:
* How has ridership changed over time? Has it recovered to pre-COVID levels?
* Which lines are the most ADA accessible? 
- Measured by the number of ADA-accessible stations per line.
* Which lines and stations are the busiest? And the least busy?

## Tools Used:
* PostgreSQL: data cleaning and SQL queries
* Tableau: data visualization and dashboard creation


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

# 4. Data Exploration and Cleaning

# 5. Analytical Queries

# 6. Visualization (Tableau)

# 7. Key Takeaways

# 8. Reproducibility
