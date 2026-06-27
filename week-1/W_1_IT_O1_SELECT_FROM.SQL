--------- Pärast töövihiku läbitöötamist sa:
1. Kirjutad SELECT päringuid, mis valivad konkreetseid veerge UrbanStyle'i andmebaasist
2. Filtreerid andmeid WHERE klausliga, kasutades võrdlusoperaatoreid ja loogikaoperaatoreid
3. Tuvastad duplikaate ja loendad unikaalseid väärtusi DISTINCT ja COUNT abil
--------------------


select * FROM sales limit 10

select 1;

Select count(*) from products; -- Peaksid nägema tulemust: `count` → 350 (või ~348-352 piirides).--
Select count(*) from customers; -- Peaksid nägema: `count` → ~3 150 (täpne arv: 3 000-3 200 piirides). Numbris on duplikaate, mis avastamine on Nädal 2 töö — praegu on see OK.-- 

-- Samm 0.4: Impordi `sales.csv` (kolmandaks — ~15 234 rida, vajab staging-tabelit)
Miks viimasena: sales sõltub nii products-ist kui customers-ist (foreign key). Kui impordid enne neid, saad FK vea.
Miks staging-tabel? sales.csv sisaldab kuupäevi kahes erinevas formaadis: enamik 2023-01-10, aga ~3% 25/01/2023. Supabase ei suuda teist formaati automaatselt tuvastada. Lahendus: laadime andmed kõigepealt ajutisse TEXT-tabelisse, seejärel teisendame ja viime üle päris sales tabelisse.
-- 

CREATE TABLE sales_import (
  sale_id TEXT, invoice_id TEXT, sale_date TEXT, customer_id TEXT,
  product_id TEXT, quantity TEXT, unit_price TEXT, total_price TEXT,
  channel TEXT, store_location TEXT, payment_method TEXT
);

-- konroll-- 
Select Count(*) FROM sales_import; -- OK 15234 rida--


-- Kopeeri andmed päris `sales` tabelisse kuupäevateisendusega  -- 
INSERT INTO sales (
  sale_id, invoice_id, sale_date, customer_id, product_id,
  quantity, unit_price, total_price, channel, store_location, payment_method
)
SELECT
  sale_id::INT, invoice_id,
  CASE
    WHEN sale_date ~ '^\d{4}-\d{2}-\d{2}' THEN sale_date::DATE
    WHEN sale_date ~ '^\d{2}/\d{2}/\d{4}' THEN TO_DATE(sale_date, 'DD/MM/YYYY')
    ELSE NULL
  END,
  customer_id::INT, product_id::INT, quantity::INT,
  unit_price::NUMERIC, total_price::NUMERIC,
  channel, NULLIF(store_location, ''), payment_method
FROM sales_import;

-- kontroll--
Select count(*) from sales; --ok 15234--

-- (D) Kustuta ajutine tabel: --
DROP TABLE sales_import;

-- Samm 0.5: Lõpp-kontroll — kõik tabelid on kohal--

SELECT 'products' AS tabel, COUNT(*) AS ridu FROM products
UNION ALL SELECT 'customers', COUNT(*) FROM customers
UNION ALL SELECT 'sales', COUNT(*) FROM sales;


-- Tabelid on kõik OK ---

--ülesanded: Sel nädalal õpid sa andmeid LUGEMA (SELECT), FILTREERIMA (WHERE) ja LOENDAMA (DISTINCT, COUNT) — täpselt need oskused, mida vajad Toomase küsimustele vastamiseks. --

-- Osa 1: SELECT ja FROM — Andmete Lugemine--

-- SQL-is ei pea sa midagi kustutama ega peitma. Sa lihtsalt ütled: "Näita mulle AINULT need veerud." See ongi SELECT — sa VALID, mida näha tahad, ilma algandmeid muutmata.--
Select * from sales; -- See päring tagastab KÕIK read ja KÕIK veerud. UrbanStyle'i puhul tähendab see tuhandeid ridu — kogu müügitabel.--


-- Samm 2: Konkreetsete veergude valimine-- 
SELECT customer_id, total_price, sale_date
FROM sales; -- See tagastab ainult kolm veergu: kliendi ID, summa ja kuupäev. Ülejäänud veerud on endiselt tabelis — sa lihtsalt ei küsinud neid.--

--Samm 3: AS — veergude ümbernimetamine--
-- Mõnikord on veergude nimed pikad või ebaselged. AS loob ajutise nime (alias):--
-- Tulemus on sama, aga veergude pealkirjad on loetavamad. Alias kehtib ainult selle päringu tulemuses — tabelis endas midagi ei muutu.--

SELECT
    customer_id AS klient,
    total_price AS summa,
    sale_date AS kuupäev
FROM sales;


-- Samm 4: LIMIT — piira tulemuste arvu--
-- See tagastab ainult esimesed 10 rida. Alati kasuta LIMIT-it testimisel — nii ei prindi kogemata 15 000 rida ekraanile.--

SELECT customer_id, total_price
FROM sales
LIMIT 10;

-- Samm 5: ORDER BY — tulemuste sorteerimine --
-- -- Väiksemast suuremani (vaikimisi)--> 1, 2, 3... A, B, C...

Select customer_id, total_price
From sales
Order BY total_price;

-- -- Suuremast väiksemani--- 100, 99, 98... Z, Y, X...

select customer_id, total_price
from sales
order by total_price desc;

--niisama testimiseks

select 
customer_id as kliendid, 
total_price as hind
from sales
order by hind desc;

-- Harjutus 1A: Shu — kopeeri ja käivita (10 min)--
SELECT *
FROM sales
LIMIT 5;

-- valin veerud -- 
SELECT sale_id, customer_id, total_price, sale_date
FROM sales
order by total_price DESC
LIMIT 10;


-- Päring 3 — Sorteeri ja piira:--
SELECT sale_id, total_price AS summa
FROM sales
ORDER BY total_price DESC
LIMIT 5;

--Ülesanne: Muuda eelmist päringut, et leida hoopis 5 VÄIKSEIMAT müüki.--

SELECT sale_id, total_price AS summa
FROM sales
ORDER BY total_price asc
LIMIT 5;

-- Ülesanne: Toomas tahab näha tellimuste loetelu koos kliendi ID, kuupäeva ja summaga — sorteerituna kuupäeva järgi (uuemad enne). Kirjuta see päring ise. Kasuta LIMIT 20, et mitte kogu tabelit väljastada.--

SELECT sale_id, total_price, sale_date, unit_price
FROM sales
ORDER BY sale_date desc
LIMIT 20;

