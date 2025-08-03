# CTA Ridership Analysis  
*Exploring post-pandemic ridership trends, accessibility gaps, and system usage across Chicago’s 'L' network.*

---

## 1. Overview

CTA ridership plummeted during the pandemic and has yet to fully rebound. This analysis uses SQL, Python, and geospatial tools to explore where ridership stands today, who may be left behind, and what patterns emerge across time, space, and accessibility.

* [GitHub Repository](https://github.com/ckucewicz/cta_ridership_analysis)

**Data sources**:
- [CTA Ridership Data (Daily)](https://data.cityofchicago.org/Transportation/CTA-Ridership-L-Station-Daily-Boarding-Totals/x2n5-8w5q)
- [CTA 'L' Station Locations](https://data.cityofchicago.org/Transportation/CTA-L-System-Station-Locations/k4mn-3j89)

---

## 2. Key Findings

* Annual ridership remains **~63%** of pre-COVID levels
* Every month has seen lower ridership post-COVID
* Lake, O’Hare, and Clark/Lake are top stations by traffic
* Nearly **30%** of stations remain non-ADA accessible

## 3. Ridership Over Time

### Annual Ridership Trend (2001–Present)
CTA ‘L’ ridership saw a dramatic drop in 2020 and remains far below pre-pandemic levels. As of 2024, total boardings are only **~63%** of pre-COVID averages.
<iframe src="annual_ridership.html" width="100%" height="600" style="border:none;"></iframe>

---

## 4. Seasonal Patterns

### Monthly Ridership: Pre- vs. Post-COVID

<iframe src="figures/monthly_avg_lollipop.html" width="100%" height="600" style="border:none;"></iframe>


Each month now sees lower average boardings than before the pandemic, though some months (e.g. July, October) have held up better than others.

***Summary Table: Monthly Ridership Comparison***  
_Average monthly boardings before and after COVID-19 (in millions)_

| Month     | Pre-COVID Avg (mil) | Post-COVID Avg (mil) | Percent Recovered (%) |
|-----------|---------------------|----------------------|------------------------|
| January   | 13.0                | 7.4                  | 56.9                   |
| February  | 12.6                | 7.6                  | 60.3                   |
| March     | 14.1                | 8.7                  | 61.7                   |
| April     | 13.9                | 9.1                  | 65.5                   |
| May       | 14.3                | 9.6                  | 67.1                   |
| June      | 14.5                | 9.0                  | 62.1                   |
| July      | 14.7                | 9.0                  | 61.2                   |
| August    | 14.8                | 9.7                  | 65.5                   |
| September | 14.9                | 9.7                  | 65.1                   |
| October   | 15.8                | 10.3                 | 65.2                   |
| November  | 13.8                | 8.6                  | 62.3                   |
| December  | 12.6                | 7.6                  | 60.3                   |

---

## 5. Station-Level Insights

### Top 3 Most Used Stations (Post-COVID)  
_These are the busiest CTA ‘L’ stations based on total boardings from 2023–Present._

| Station             | Total Rides |
|---------------------|-------------|
| Lake (Red Line)     | 6.36M       |
| O’Hare (Blue Line)  | 5.79M       |
| Clark/Lake (Loop)   | 5.26M       |

### Map: Which CTA Stations are the Busiest? (Post-COVID)
Each circle represents a CTA ‘L’ station, color-coded by line and sized by total ridership since May 2023. Use the legend to interpret line colors and approximate usage. Multi-line stations appear in grey. 

<iframe src="figures/station_ridership_map.html" width="100%" height="600" style="border:none;"></iframe>

---

## 6. Accessibility Gaps
Riders with disabilities still face barriers at **nearly 30%** of CTA stations. Non-accessible stops are concentrated along the Blue and Pink Lines, limiting equitable transit access across the system.

### Map: Which CTA Stations are Non-ADA Accessible?  
*Each marker represents a CTA ‘L’ station that is not currently ADA accessible. Zoom and pan to explore patterns by line and location.*

<iframe src="figures/ada_access_map.html" width="100%" height="600" style="border:none;"></iframe>


***ADA Accessibility by CTA Line*** 

_The share of stations on each line that are ADA accessible as of 2023._

| Line              | Total Stations | ADA Accessible | Percent Accessible (%) |
|-------------------|----------------|----------------|-------------------------|
| Purple            | 8              | 2              | 25.0                   |
| Blue              | 33             | 14             | 42.4                   |
| Purple Express    | 19             | 12             | 63.2                   |
| Red               | 30             | 20             | 66.7                   |
| Green             | 29             | 24             | 82.8                   |
| Orange            | 10             | 9              | 90.0                   |
| Brown             | 22             | 20             | 90.9                   |
| Pink              | 17             | 16             | 94.1                   |
| Yellow            | 2              | 2              | 100.0                  |

---

## Final Thoughts / Policy Implications

CTA ‘L’ ridership has not fully recovered from the pandemic, and gaps in accessibility remain across the system. While some stations and months have seen stronger returns, overall usage lags behind pre-COVID levels by more than a third.

This presents both a challenge and an opportunity: 

- **Ridership recovery strategies** must account for shifting travel patterns and equity considerations.
- **Investment in accessibility** remains critical. Nearly 30% of stations are still not ADA compliant, disproportionately impacting low-income and historically underserved neighborhoods.
- **Data transparency and tracking** will be key in monitoring progress and targeting improvements.

As Chicago plans for the future of its transit system, data-driven decisions rooted in equity and usability are essential.
