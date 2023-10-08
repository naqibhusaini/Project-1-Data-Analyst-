select * from Portfolio..CovidDeaths$
where continent is not null
order by 3,4;

select * from Portfolio..CovidVaccinations$
order by 3,4;

--select DATA that we r going to use.
select location,date,total_cases,new_cases,total_deaths,population
from Portfolio..CovidDeaths$
order by 1,2;

--total_cases vs total_deaths
--show cases in specific country
select location,date,total_cases, new_cases,total_deaths,(total_deaths/total_cases)*100 as death_percentage
from Portfolio..CovidDeaths$
where location like '%ysia%'
order by 1,2;

--looking at country with highest infection rate
select location,population,max(total_cases)as HighestInfectionCount,max((total_cases/population))*100 as InfectionPercentage
from Portfolio..CovidDeaths$
where location like '%states%'
group by population, location
order by 4 desc

--BREAK THINGS BY CONTINENT
--looking at country with highest deaths
select location,max(cast (total_deaths as int))as TotalDeathsCount
from Portfolio..CovidDeaths$
where continent is null
group by location
order by 2 desc

--looking continents with highest death count per population
select continent,max(cast (total_deaths as int))as TotalDeathsCount
from Portfolio..CovidDeaths$
where continent is not null
group by continent
order by 2 desc

--Global Numbers
select sum(new_cases) as total_cases,sum(cast (new_deaths as int)) as total_deaths,sum(cast (new_deaths as int))/sum(new_cases)*100 death_percentage
from Portfolio..CovidDeaths$
where continent is not null
--group by date
order by 1,2;

--looking at total population vs vaccination
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations
select * 
from Portfolio..CovidDeaths$ dea
join Portfolio..CovidVaccinations$ vac
	on dea.location = vac.location 
	and dea.date = vac.date