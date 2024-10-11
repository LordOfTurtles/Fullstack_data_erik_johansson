-- 1
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

-- 2
SELECT
	Enhetstyp, 
	count(*) AS total_rows,
	sum(Visningar) as total_visningar
From
	enhetstyp.diagramdata
GROUP BY
	Enhetstyp
ORDER BY total_visningar DESC;

-- 3
SELECT 
	* EXCLUDE (innehåll)
FROM
	innehall.tabelldata
ORDER BY "visningstid (timmar)" DESC OFFSET 1;

-- 4
SELECT
	*
FROM
	operativsystem.tabelldata
ORDER BY Visningar DESC LIMIT 10;

-- 5
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

-- 6
SELECT
	* EXCLUDE ("Visningstid (timmar)", "Genomsnittlig visningslängd")
FROM geografi.tabelldata OFFSET 1;

-- 7
SELECT 
	* EXCLUDE (Städer)
FROM stader.diagramdata
WHERE Visningar > 0;

-- 8
-- ALTER TABLE tittare.tabelldata_alder
-- RENAME TO tabelldata_kon_temp;

-- ALTER TABLE tittare.tabelldata_kon
-- RENAME TO tabelldata_alder;

-- ALTER TABLE tittare.tabelldata_kon_temp
-- RENAME TO tabelldata_kon;

-- 9
SELECT 
	*
FROM tittare.tabelldata_kon;

-- 10
SELECT
	*
FROM tittare.tabelldata_alder;

-- 11
SELECT
	STRFTIME('%Y-%m-%d', Datum) Datum,
	Trafikkälla,
	Visningar
FROM trafikkalla.diagramdata
WHERE 
	Trafikkälla = 'YouTube-sökning'
ORDER BY Visningar DESC;
