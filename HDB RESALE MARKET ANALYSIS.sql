/*
PROJECT: SINGAPORE HDB RESALE MARKET ANALYSIS
 AUTHOR: ADIL ROZDY BIN MOHAMED
PURPOSE: ANALYZING PRICE TRENDS ACROSS DIFFERENT TOWNS AND FLAT MODELS
		 TO IDENTIFY MARKET OPPORTUNITIES
*/

-- DATABASE SETUP 
CREATE TABLE hdb_resale_prices (
    month_sold VARCHAR(10),
    town VARCHAR(50),
    flat_type VARCHAR(20),
    block VARCHAR(10),
    street_name VARCHAR(100),
    storey_range VARCHAR(20),
    floor_area_sqm NUMERIC,
    flat_model VARCHAR(50),
    lease_commence_date INT,
    remaining_lease VARCHAR(50),
    resale_price NUMERIC
);

-- OBJECTIVE: PROVIDE A SUMMARY OF TOTAL TRANSACTION, TOTAL SALES VOLUME AND AVERAGE MARKET PRICE
SELECT  
	COUNT(*) AS total_transactions,
	'$'|| SUM(resale_price) AS total_market_value,
	'$'|| ROUND(AVG(resale_price), 2) AS average_price
FROM hdb_resale_prices;

-- OBJECTIVE: RANK EVERY TOWN FROM HIGHEST TO LOWEST PRICE TO SEE WHICH NEIGHBORHOODS COST THE MOST.
SELECT 
	town,
	ROUND(AVG(resale_price), 0) AS avg_price
FROM hdb_resale_prices
GROUP BY town
ORDER BY avg_price DESC; 

-- OBJECTIVE: SEARCH FOR A 4 ROOM FLATS IN TAMPINES THAT COST LESS THAN $600K
-- THIS HELPS A BUYER FIND A BIGGER FAMILY HOME THAT FITS THEIR BUDGET 
SELECT 
	month_sold,
	town,
	block,
	street_name,
	flat_type,
	'$'|| resale_price AS resale_price
FROM hdb_resale_prices
WHERE flat_type = '4 ROOM' 
AND town = 'TAMPINES' 
AND resale_price < 600000 
ORDER BY resale_price DESC
LIMIT 100; 



	