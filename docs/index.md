[![View on GitHub](https://img.shields.io/badge/GitHub-ckucewicz/cta__ridership__analysis-blue?logo=github)](https://github.com/ckucewicz/cta_ridership_analysis)

# CTA Ridership Analysis  
*Exploring post-pandemic ridership trends, accessibility gaps, and system usage across Chicago’s 'L' network.*

---

## About

This project analyzes CTA 'L' ridership trends from 2001 to 2025 using SQL and Python to examine long-term shifts, highlight equity and accessibility gaps, and explore which stations and lines see the most post-pandemic traffic.

**Data sources**:
- [CTA Ridership Data (Daily)](https://data.cityofchicago.org/Transportation/CTA-Ridership-L-Station-Daily-Boarding-Totals/x2n5-8w5q)
- [CTA 'L' Station Locations](https://data.cityofchicago.org/Transportation/CTA-L-System-Station-Locations/k4mn-3j89)

---

## Summary

CTA ‘L’ ridership saw a dramatic drop in 2020 and remains far below pre-pandemic levels. As of 2024, total boardings are only ~63% of pre-COVID averages.

### Annual Ridership Trend (2001–Present)
<iframe src="annual_ridership.html" width="100%" height="600" style="border:none;"></iframe>

**Key takeaway**: Despite partial recovery, the system has not returned to previous demand levels.

---

## Trends

### Average Daily Ridership by Month: Pre- vs. Post-COVID  
<iframe src="figures/monthly_avg_lollipop.html" width="100%" height="600" style="border:none;"></iframe>

**Key takeaway:** Every month has lower average daily ridership post-COVID than pre-COVID.

Each month now sees lower average boardings than before the pandemic, though some months (e.g. July, October) have held up better than others.

### Summary Table: Monthly Ridership Comparison  
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

### Top 3 Stations by Total Post-COVID Ridership  
These are the busiest CTA 'L' stations based on total boardings from 2023–Present.

| Station               | Total Rides |
|-----------------------|-------------|
| Lake (Red Line)       | 6.36M       |
| O'Hare (Blue Line)    | 5.79M       |
| Clark/Lake (Loop)     | 5.26M       |

---

### Many CTA Lines Still Have Non-Accessible Stations  
<iframe src="figures/ada_access_map.html" width="100%" height="600" style="border:none;"></iframe>

**Key takeaway:** Riders with disabilities still face barriers at nearly 30% of CTA stations. Non-accessible stops are concentrated along the Blue and Pink Lines, limiting equitable transit access across the system.

---

## Next Steps
- Add equity-focused metrics (e.g., ridership by income level or neighborhood demographics)
- Explore time-of-day changes in ridership
- Create additional interactive maps for neighborhood overlays and station catchment areas
