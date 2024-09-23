--Q4.1
/* no, because we still have VA records in other tables */

--Q4.2

/*no, because no state has fips of 80*/

--Q4.3
/* it works, but can be improved */

--Q4.5
/* yes, great job*/

--Q4.6
SELECT n.name, i.year, MAX(i.income) AS highest_income
FROM income i
JOIN name n ON i.fips = n.fips
WHERE i.year = (SELECT MAX(year) FROM income)
GROUP BY n.name, i.year
ORDER BY highest_income DESC
LIMIT 1;
/* yes, this code did work */

--Q4.7
WITH va_population AS (
    SELECT 
        year, 
        pop,
        LAG(pop, 1) OVER (ORDER BY year) AS previous_pop
    FROM population
    WHERE fips = '51'
    ORDER BY year DESC
    LIMIT 6 -- Get data for the most recent 6 years to calculate the last 5 years growth rate
)

SELECT 
    year,
    pop AS current_population,
    previous_pop AS previous_population,
    (pop - previous_pop) AS absolute_growth,
    ((pop - previous_pop) / NULLIF(previous_pop, 0)::numeric) * 100 AS growth_rate_percentage
FROM va_population
WHERE previous_pop IS NOT NULL
ORDER BY year DESC;
/*yes, it did work */

--Q4.8
/* no it does not always work some aspects work but it is not always entirely accurate */
