desc;

SELECT
	*
FROM
	information_schema.schemata;

CREATE SCHEMA IF NOT EXISTS marts;

CREATE TABLE IF NOT EXISTS marts.content_view_time AS 
(
SELECT
	Videotitel,
	"Publiceringstid för video" AS Publiceringstid,
	Visningar,
	"Visningstid (timmar)" AS Visningstid_timmar,
	Exponeringar,
	Prenumeranter,
	"Klickfrekvens för exponeringar (%)" AS "Klickfrekvens_exponering_%"
FROM
	innehall.tabelldata
ORDER BY
	"Visningstid (timmar)" DESC OFFSET 1);

CREATE TABLE IF NOT EXISTS marts.views_per_date AS (
SELECT
	STRFTIME('%Y-%m-%d',
	Datum) AS Datum,
	Visningar
FROM
	innehall.totalt);

SELECT
	*
FROM
	information_schema.tables
WHERE
	table_schema = 'marts';

SELECT
	*
FROM
	marts.content_view_time;


SELECT
	*
FROM
	marts.views_per_date;

CREATE TABLE IF NOT EXISTS marts.subscriber_views_per_date AS (
WITH
	subs_table AS (SELECT * FROM prenumerationsstatus.diagramdata WHERE Prenumerationsstatus = 'Prenumererar'),
	nonsubs_table AS (SELECT * FROM prenumerationsstatus.diagramdata WHERE Prenumerationsstatus = 'Prenumererar inte'),
	date_total AS (SELECT * FROM datum.totalt)
SELECT
	STRFTIME('%Y-%m-%d', sub.datum) Datum,
	sub.visningar "Visningar av prenumeranter",
	nonsub.visningar "Visningar av icke-prenumeranter",
	tot.visningar "Totala Visningar"
FROM
	subs_table as sub
LEFT JOIN nonsubs_table as nonsub
ON sub.datum = nonsub.datum
LEFT JOIN date_total as tot
ON sub.datum = tot.datum);

SELECT
	*
FROM marts.subscriber_views_per_date;

CREATE TABLE IF NOT EXISTS marts.OS_summary AS (
SELECT
	*
FROM
	operativsystem.tabelldata
WHERE Visningar > 0
ORDER BY Visningar DESC);

SELECT 
	*
FROM 
	marts.OS_summary;

CREATE TABLE IF NOT EXISTS marts.OS_per_date AS (
PIVOT (
	SELECT
	STRFTIME('%Y-%m-%d', Datum) Datum,
	Operativsystem,
	Visningar
FROM operativsystem.diagramdata)
ON Operativsystem
USING sum(Visningar)
ORDER BY Datum);

SELECT
	*
FROM 
	marts.OS_per_date;

CREATE TABLE IF NOT EXISTS marts.viewer_ages AS (
SELECT
	*
FROM tittare.tabelldata_alder)

SELECT
	*
FROM 
	marts.viewer_ages;



