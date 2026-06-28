UrbanStyle.ltd DACA 2026 kursus - isiklik töövihik


## Nädala kaupa
| Nädal | Teema | Staatus |
|-------|-------|---------|
| 0 | Onboarding | DONE!|
| 1 | SQL Basics | DONE|
| 2 | SQL Cleaning | |
| 3 | SQL JOINs |  |
| 4 | SQL Aggregation |  |
| 5-6 | Visualiseerimine |  |
| 7-8 | Python |  |
| 9-10 | Portfoolio + Karjäär |  |





##Vormindamine

|##Süntaks	|##Tulemus|
|-----------|---------|
|# Pealkiri	|Suur pealkiri|
|## Alapealkiri	|Väiksem pealkiri|
|**paks tekst**|	paks tekst|
|*kaldkiri*|	kaldkiri|
|- punkt	|Nimekiri|
|` kood 	|Koodi formaat|

-- See on üherealne kommentaar

/* See on
   mitmerealine
   kommentaar */

Soovituslik formaat UrbanStyle'i projektis:
-- ============================================
-- Päring: Duplikaatide arv sales tabelis
-- Autor: [Sinu nimi]
-- Kuupäev: 2024-XX-XX
-- Eesmärk: Vastata Toomase küsimusele #1
-- ============================================
SELECT
    COUNT(*) AS ridu_kokku,
    COUNT(DISTINCT sale_id) AS unikaalseid
FROM sales;





