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

SELECT 
	*
FROM 
	prenumerationskalla.diagramdata;

SELECT 
	*
FROM 
	prenumerationsstatus.diagramdata
WHERE Prenumerationsstatus = 'Prenumererar inte';


SELECT 
	*
FROM 
	enhetstyp.tabelldata
ORDER BY Visningar DESC;

WITH
	subs_table AS (SELECT * FROM prenumerationsstatus.diagramdata WHERE Prenumerationsstatus = 'Prenumererar'),
	nonsubs_table AS (SELECT * FROM prenumerationsstatus.diagramdata WHERE Prenumerationsstatus = 'Prenumererar inte'),
	date_total AS (SELECT * FROM datum.totalt)
SELECT
	STRFTIME('%Y-%m-%d', sub.datum) Datum,
	sub.visningar "Visningar av prenumeranter",
	nonsub.visningar "Visningar av icke-prenumeranter",
	tot.visningar
FROM
	subs_table as sub
LEFT JOIN nonsubs_table as nonsub
ON sub.datum = nonsub.datum
LEFT JOIN date_total as tot
ON sub.datum = tot.datum;
	
	
	



