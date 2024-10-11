desc;

WITH 
	date_table AS (SELECT * FROM datum.tabelldata OFFSET 1),
	date_total AS (SELECT * FROM datum.totalt)
SELECT
	STRFTIME('%Y-%m-%d', tot.datum) Datum,
	tot.visningar,
	tab.visningar,
	tab."visningstid (timmar)"
FROM
	date_total as tot
LEFT JOIN date_table as tab
ON tot.datum = tab.datum;

SELECT
	Enhetstyp, 
	count(*) AS total_rows,
	sum(Visningar) as total_visningar
From
	enhetstyp.diagramdata
GROUP BY
	Enhetstyp;

SELECT 
	* EXCLUDE (innehåll)
FROM
	innehall.tabelldata
ORDER BY "visningstid (timmar)" DESC OFFSET 1;

SELECT
	*
FROM
	operativsystem.tabelldata
ORDER BY Visningar DESC LIMIT 10;




