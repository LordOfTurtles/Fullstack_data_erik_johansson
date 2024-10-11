-- 1 Check views and viewing hours
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

-- 2 Check most common devices for viewing videos
SELECT
	Enhetstyp, 
	count(*) AS total_rows,
	sum(Visningar) as total_visningar
From
	enhetstyp.diagramdata
GROUP BY
	Enhetstyp
ORDER BY total_visningar DESC;

-- 3 Check stats per individual video
SELECT 
	* EXCLUDE (innehåll)
FROM
	innehall.tabelldata
ORDER BY "visningstid (timmar)" DESC OFFSET 1;

-- 4 Check 10 most common operating systems among viewers;
SELECT
	*
FROM
	operativsystem.tabelldata
ORDER BY Visningar DESC LIMIT 10;

-- 5 Compare subscribed, non-subscribed and total viewers per date;
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

-- 6 Check most common nationalities of viewers;
SELECT
	* EXCLUDE ("Visningstid (timmar)", "Genomsnittlig visningslängd")
FROM geografi.tabelldata OFFSET 1;

-- 7 Check which dates had views from known cities;
SELECT 
	* EXCLUDE (Städer)
FROM stader.diagramdata
WHERE Visningar > 0;

-- 8 Check gender demographics for viewers;
SELECT 
	*
FROM tittare.tabelldata_kon;

-- 9 Gender and age tables had wrong names so swapped them around
-- ALTER TABLE tittare.tabelldata_alder
-- RENAME TO tabelldata_kon_temp;

-- ALTER TABLE tittare.tabelldata_kon
-- RENAME TO tabelldata_alder;

-- ALTER TABLE tittare.tabelldata_kon_temp
-- RENAME TO tabelldata_kon;

-- 10 Check gender demographics for viewers
SELECT 
	*
FROM tittare.tabelldata_kon;

-- 11 Check age demographics for viewers;
SELECT
	*
FROM tittare.tabelldata_alder;

-- 12 Check what days there was most traffic from YouTube searches
SELECT
	STRFTIME('%Y-%m-%d', Datum) Datum,
	Trafikkälla,
	Visningar
FROM trafikkalla.diagramdata
WHERE 
	Trafikkälla = 'YouTube-sökning'
ORDER BY Visningar DESC;