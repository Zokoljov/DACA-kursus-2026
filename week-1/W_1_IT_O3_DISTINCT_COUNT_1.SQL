Osa 3: DISTINCT ja COUNT — Unikaalsed Väärtused ja Loendamine

Samm 1: DISTINCT — ainult unikaalsed väärtused
DISTINCT eemaldab korduvad read tulemusest:

-- Kõik kanalid (korduvad)
SELECT store_location
FROM sales;
-- Tulemus: tuhandeid ridu, paljud korduvad

-- Ainult unikaalsed kanalid
SELECT DISTINCT store_location
FROM sales;
-- Tulemus: 3-5 rida (nt Tallinn, Tartu, Pärnu, E-pood)


DISTINCT töötab ka mitme veeruga — siis otsib unikaalseid KOMBINATSIOONE:

-- Unikaalsed kanali ja staatuse kombinatsioonid
SELECT DISTINCT store_location, payment_method
FROM sales;

Samm 2: COUNT — ridade loendamine

Funktsioon	Mida loeb	NULL-id
COUNT(*)	Kõik read	Loeb ka NULL-iga ridu
COUNT(veerg)	Selle veeru mitte-NULL väärtused	Jätab NULL-id välja
COUNT(DISTINCT veerg)	Ainult unikaalsed mitte-NULL väärtused	Jätab NULL-id ja kordused välja


-- Mitu rida on tabelis kokku?
SELECT COUNT(*) AS ridade_arv
FROM sales;
---15234---


-- Mitu rida omab customer_id väärtust (mitte NULL)?
SELECT COUNT(customer_id) AS klientidega_tellimused
FROM sales;

-- Mitu ERINEVAT klienti on tellimusi teinud?
SELECT COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;


Samm 3: NULL-ide loendamine

-- Mitu customer_id on NULL?
SELECT
    COUNT(*) AS kokku,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puuduvaid
FROM sales;

--> kokku 15234, klientidega 13747, puuduvaid 1487
---See töötab, sest COUNT() loeb kõiki ridu, aga COUNT(customer_id) jätab NULL-id välja. 
Vahe = puuduvate väärtuste arv.---


Samm 4: Duplikaatide tuvastamine

-- Samm A: Mitu rida kokku?
SELECT COUNT(*) FROM sales;

-- Samm B: Mitu unikaalset sale_id on?
SELECT COUNT(DISTINCT sale_id) FROM sales;

-- Kui A > B, siis on duplikaadid!

Select
    Count(*) AS kokku,
    Count(DISTINCT sale_id) AS unikaalsed, 
    Count(*) - Count(DISTINCT sale_id) AS duplikaadid
From sales;

--> kokku 15234, unikaalsed 10118, duplikaadid 5116


3.3 Concrete Practice: DISTINCT ja COUNT harjutused (30 min)

SELECT
    COUNT(*) AS ridade_arv,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puudub_klient,
    COUNT(DISTINCT customer_id) AS unikaalseid_kliente
FROM sales;


Kirjuta tulemused siia:
●	Ridu kokku: 15234
●	Klientidega tellimusi: 13747
●	Puuduvaid kliente: 1487
●	Unikaalseid kliente: 2558

Päring 2 — Unikaalsed kanalid:  
select distinct store_location
from sales
order by store_location asc;

millised on unikaalsed kanalid?
-- Tallinn, Tartu, Pärnu, E-pood (null)

Ülesanne: Toomas tahab teada täpselt, kui palju duplikaate on. Kasuta tema meetodit.

SELECT COUNT(*) AS kokku FROM sales;
SELECT COUNT(DISTINCT sale_id) AS unikaalseid FROM sales;

Kontrolli ka customers tabelit — kas seal on duplikaatseid e-maile?

SELECT
    COUNT(*) AS kokku,
    COUNT(DISTINCT email) AS unikaalseid_emaile,
    COUNT(*) - COUNT(DISTINCT email) AS duplikaatseid
FROM customers;


kokku 3150 unikaalseid_emaile 2640  duplikaatseid 510

Harjutus 3C: Rakendus — uurimisraport (10 min)
Toomas tahab ka products tabeli kohta ülevaadet. Kirjuta ise päring, mis näitab:
●	Toodete koguarv
●	Unikaalsete kategooriate arv
●	Puuduvate hindade arv

SELECT
    COUNT(*) AS toodete_koguarv,
    COUNT(DISTINCT category) AS unikaalseid_kategooriaid,
    COUNT(*) - COUNT(retail_price) AS puuduvate_hindade_arv
FROM products;

-> toodete_koguarv 362, unikaalseid_kategooriaid 5, puuduvate_hindade_arv 0

Concrete Practice: Integreeriv harjutus — Uurimisraport Toomasele (20 min)

Päring 1 — Duplikaatide arv:

-- Küsimus: mitu duplikaati on?
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid,
    COUNT(*) - COUNT(DISTINCT sale_id) AS duplikaate
FROM sales;

Päring 2 — NULL väärtused:

Kirjuta ise päring, mis näitab, mitmel real puudub customer_id:
Select 
    COUNT(*) AS kokku,
    COUNT(customer_id) AS klientidega,
    COUNT(*) - COUNT(customer_id) AS puuduvaid  
    from sales;

Päring 3 — Suurimad müügid: 

Kirjuta päring, mis näitab 10 suurimat tellimust (sale_id, customer_id, total_price):   

select 
    sale_id, customer_id, total_price   
    from sales
    order by total_price desc   
    limit 10;

Päring 4 — Väikseimad müügid ja kahtlased read:

Kirjuta päring, mis näitab 10 väikseimat tellimust JA read, kus summa on 0 või väiksem: 

select 
    sale_id, customer_id, total_price   
    from sales
    where total_price <= 0
    order by total_price asc;

ja...

SELECT COUNT(*) AS kahtlaste_tellimuste_arv
FROM sales
WHERE total_price <= 0;

Toomase jaoks: "Meie tabelis on 15234 rida, millest 5116 on duplikaadid."
Toomase jaoks: "1487 tellimusel puudub kliendi ID."
Toomase jaoks: "Suurim müük oli 2170,4 eurot."
Toomase jaoks: "Leidsime 305 tellimust, kus summa on 0 või negatiivne."

Quizz:
1) C +
2) A +
3) D +
4) C +
5) A - õige B
6) D +
7) A +
8) C +
9) B +