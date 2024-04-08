SELECT *
FROM PortfolioProject..CovidDeaths
where continent is not null
order by 3,4

--SELECT *
--FROM PortfolioProject..CovidVaccinations$
--order by 3,4

--select the data we are going to be using

SELECT location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths
where continent is not null
order by 1,2

 --Looking at Total Cases vs Total Deaths

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as Death_Percentage 
FROM PortfolioProject..CovidDeaths
where location like '%States%'
order by 1,2

Looking at Total Cases vs population
SELECT location, date, population, total_cases, (total_cases/population)*100 as Death_Percentage 
FROM PortfolioProject..CovidDeaths
where location like '%states%'
and continent is not null
order by 1,2 

--Looking at countries with the highest infection rate compared to population

SELECT location, population, MAX(total_cases) as HighestInfectoinCount, max((total_cases/population))*100 as percentPopulationInfected
from PortfolioProject..CovidDeaths
where location like '%states%'
group by location, population
order by percentPopulationInfected desc

 --showing countries with highest death count per population

SELECT location, max(cast(total_deaths as int)) as totalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by location
order by totalDeathCount desc

SELECT continent, max(cast(total_deaths as int)) as totalDeathCount
from PortfolioProject..CovidDeaths
where location like '%states%'
where continent is not null
group by continent
order by totalDeathCount desc

 --showing continents with the highest death count per population

SELECT continent, max(cast(total_deaths as int)) as totalDeathCount
from PortfolioProject..CovidDeaths
--where location like '%states%'
where continent is not null
group by continent
order by totalDeathCount desc

 --Global Numbers

SELECT date, sum(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)* 100 as deathpercentage
FROM PortfolioProject..CovidDeaths
where continent is not null 
GROUP by date
order by 1,2

SELECT sum(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)* 100 as deathpercentage
FROM PortfolioProject..CovidDeaths
where continent is not null 
order by 1,2

 --looking at total population vs vaccinations
With PopvsVac (continent, location, Date, population, new_vaccinations, rollingPeopleVaccinated)
as
(
select dea.continent ,dea.location, dea.date,dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)as rollingPeopleVaccinated 
from PortfolioProject..CovidDeaths as dea
	join PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by  2,3
	)
	select *, (rollingPeopleVaccinated /population)*100 as PercentageofvaccinatedPeople
	from PopvsVac


drop table if exists #percentPopulationVaccinated
create table #PercentPopulationVaccinated
(
continent nvarchar(255),
location nvarchar(255),
date datetime,
population numeric,
new_vaccinations numeric,
rollingPeopleVaccinated numeric
)
insert into #PercentPopulationVaccinated
select dea.continent ,dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date)as rollingPeopleVaccinated 
from PortfolioProject..CovidDeaths as dea
	join PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--where dea.continent is not null
	--order by 2,3

	select *, (rollingPeopleVaccinated /population)*100
	from #PercentPopulationVaccinated


-- creating view to store data for later for visalization
Create View PercentPopulationVaccinated1 as
select dea.continent ,dea.location, dea.date, dea.population, vac.new_vaccinations,
sum(convert(int, vac.new_vaccinations)) over (partition by dea.location order by dea.location, dea.date) as rollingPeopleVaccinated 
from PortfolioProject..CovidDeaths as dea
	join PortfolioProject..CovidVaccinations as vac
	ON dea.location = vac.location
	and dea.date = vac.date
	where dea.continent is not null
	--order by 2,3

	SELECT *
	from PercentPopulationVaccinated