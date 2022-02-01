
/*
Queries used for Tableau Project
*/



-- 1. Sum of Total case and total deaths around the world and the death percentage

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
From PortfolioProject..CovidDeaths
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- 2. Filtering the data for Total Death Counts in different continents

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe
-- The upper middle income, High income,Lower Middle income, and low income are catagorical data 

Select location, SUM(cast(new_deaths as int)) as TotalDeathCount
From PortfolioProject..CovidDeaths
Where continent is null 
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Low income' )
Group by location
order by TotalDeathCount desc


-- 3.Finding the data for each countries for highest infection count as per total cases and the its percentage as per the population of the given country

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
Group by Location, Population
order by PercentPopulationInfected desc


-- 4. Per day infection count percentage


Select Location, Population,date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeaths
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc
