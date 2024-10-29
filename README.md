Covid-19 Data Analysis Project
This project is focused on analyzing Covid-19 data from the PortfolioProject database. Using SQL, I explored various aspects of the pandemic, including total cases, deaths, vaccination rates, and their impact on different countries and continents. The queries are structured to provide insights into infection and mortality rates, as well as vaccination progress globally.

1. Project Breakdown
Data Selection and Preparation
* Fetched data from PortfolioProject..CovidDeaths to analyze Covid cases and deaths.
* Cleaned data by filtering out null continents and organized rows for easier interpretation.

2. Key Queries and Analysis

* Total Cases vs. Total Deaths: Calculated death percentages based on total cases for selected locations (e.g., U.S. states).
* Total Cases vs. Population: Examined infection rates by comparing cases to population sizes.
* Highest Infection Rates by Country: Identified countries with the highest Covid infection rates relative to their population.
* Highest Death Counts by Country and Continent: Displayed countries and continents with the most significant death tolls.
* Global Data Aggregation: Summed new cases and deaths globally and calculated an overall death percentage.

3. Vaccination Analysis
* Merged data from CovidDeaths and CovidVaccinations tables to analyze vaccination rates.
* Created a Common Table Expression (CTE) and a temporary table to track vaccination progress as a rolling count.
* Calculated the percentage of the vaccinated population over time for each location.

4. Data View for Visualization
* Created a SQL view PercentPopulationVaccinated1 to store processed vaccination data, making it ready for visualization tools.
