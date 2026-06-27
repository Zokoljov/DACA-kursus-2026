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


---2.3 Concrete Practice: WHERE harjutused (30 min)

Päring 1 — Suured tellimused:

SELECT sale_id, customer_id, total_price
FROM sales
WHERE total_price > 500
ORDER BY total_price DESC;


-------kui mitu on??------
SELECT COUNT(*) AS suurte_müükide_arv
FROM sales
WHERE total_price > 500;

Päring 2 — Kindla perioodi müügid:----

SELECT sale_id, sale_date, total_price
FROM sales
WHERE sale_date BETWEEN '2024-01-01' AND '2024-03-31'
ORDER BY sale_date asc;
-------Mitu müüki oli 2024. aasta esimeses kvartalis? ----------
Select COUNT(*) AS müükide_arv
From sales
Where sale_date BETWEEN '2024-01-01' AND '2024-03-31';
---oli 1604----

Päring 3 — NULL väärtuste otsimine:

SELECT sale_id, customer_id, total_price
FROM sales
WHERE customer_id IS NULL;

---mitu on ilma ID-ta?--

select COUNT(*) AS ilma_IDta
from sales  
where customer_id IS NULL;

    -----Mitu tellimust on ilma kliendi ID-ta? -> 1487

   Harjutus 2B: Shu/Ha — kombineeri tingimusi (10 min)
Ülesanne: Toomas tahab näha kõiki tellimusi, mis vastavad KÕIGILE järgmistele tingimustele:
●	Summa on üle 200 euro
●	Tellimus on tehtud 2024. aastal
Kirjuta päring, mis ühendab need kaks tingimust AND-iga:
 
select sale_id, total_price, sale_date
from sales
where total_price > 200 AND sale_date BETWEEN '2024-01-01' AND '2024-12-31'

---mitu tellimust on?--

select COUNT(*) AS tellimuste_arv
from sales
where total_price > 200 AND sale_date BETWEEN '2024-01-01' AND '2024-12-31';

----Lisa kolmas tingimus — näita ainult konkreetse kanali (channel) tellimusi. Vali kanal ise.---

select sale_id, total_price, sale_date, channel
from sales
where total_price > 200 AND sale_date BETWEEN '2024-01-01' AND '2024-12-31' AND channel = 'online';


---mitu tellimust on?--
select COUNT(*) AS tellimuste_arv
from sales 
where total_price > 200 AND sale_date BETWEEN '2024-01-01' AND '2024-12-31' AND channel = 'online';
--> tellimuste arv 1581


Harjutus 2C: Rakendus — Toomase küsimus (10 min)
Ülesanne: Toomas küsib: "Näidake mulle kõik tellimused, kus midagi on kahtlast — kas summa on 0 või väiksem, või kliendi ID puudub." Kirjuta päring, mis leiab need "kahtlased" read.

select sale_id, total_price, customer_id  
from sales
where total_price <= 0 OR customer_id IS NULL;

---kui palju kahtlaseid tellimusi on?---
select COUNT(*) AS kahtlaste_tellimuste_arv
from sales
where total_price <= 0 OR customer_id IS NULL;

--> neid on 1766