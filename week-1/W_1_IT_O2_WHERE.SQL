-- Osa 2: WHERE — Andmete Filtreerimine--
-- 2.1 Connection: Riidekapi filtreerimine (5 min)--

-- Concepts: WHERE samm-sammult )--
-- -- UrbanStyle näide: müügid üle 100 euro--

SELECT sale_id, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC
Limit 9000;

-- Samm 3: BETWEEN, IN, LIKE--

-- BETWEEN — vahemik (kaasa arvatud mõlemad otspunktid): --
-- Müügid vahemikus 100-500 eurot -- 
SELECT sale_id, total_price
FROM sales
WHERE total_price BETWEEN 100 AND 500
order by total_price asc;

-- IN — mitu väärtust korraga:--

-- Müügid Tallinna VÕI Tartu kauplustest
SELECT sale_id, total_price, store_location
FROM sales
WHERE store_location in ('Tallinn', 'Tartu');

--------- LIKE — otsing teksti sisse (mustrid):-------

Muster	Tähendus
'K%'	Algab K-ga
'%son'	Lõppeb "son"-ga
'%anna%'	Sisaldab "anna"

------------------------------------------------------


-- Kliendid, kelle nimi algab "K"-ga
SELECT customer_id, first_name, last_name
FROM customers
WHERE first_name LIKE 'K%';


--kliendid, kelle nimi on Sepp järjestades A-Z eesnime järgi------
SELECT customer_id, first_name, last_name
FROM customers
WHERE last_name LIKE '%Sepp'
ORDER BY first_name ASC;


---------Samm 4: AND ja OR — mitu tingimust koos-------------------

AND — mõlemad tingimused peavad olema tõesed:

-- Suured müügid Tallinnast
SELECT sale_id, total_price, store_location
FROM sales
WHERE total_price > 500 AND store_location = 'Tallinn';

OR — vähemalt üks tingimus peab olema tõene:

-- Müügid, mis on kas väga suured VÕI väga väikesed
SELECT sale_id, total_price
FROM sales
WHERE total_price > 500 OR total_price < 10;


Oluline: AND ja OR kombineerides kasuta sulge, et vältida segadust:

-- Selge järjekord sulgudega
SELECT sale_id, total_price, store_location
FROM sales
WHERE (store_location = 'Tallinn' OR store_location = 'Tartu')
  AND total_price > 1000
  order by total_price desc
  Limit 10;

------------SQL päringu järjekord (uuendatud)----------------------

SELECT   — mida näidata?
FROM     — millisest tabelist?
WHERE    — milliseid ridu jätta?
ORDER BY — kuidas sorteerida?
LIMIT    — mitu rida?



