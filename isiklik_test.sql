SELECT 'hello Mbappe' AS tervitus;
SELECT 'Tere!' AS sonum, 2 + 3 AS tulemus;
SELECT COUNT(*) FROM sales;



------- testi vastused -----------

Lisa 2: Teadmiste Kontrolli Vastused
Küsimus 1: Vastus: C
Excelis on samaaegselt töötamine raske ja versioonid lähevad segamini. Kui 45 töötajat kasutavad sama faili, tekivad ülekirjutamised, versioonide segadus ja andmete mittevastavus. Andmebaas lahendab need probleemid. Valed: A -- Excel on ka tasuline, aga see pole põhiprobleem; B -- Excelis saab tabeleid luua; D -- Excel toetab numbreid suurepäraselt.
Küsimus 2: Vastus: A
Commit on versioonihalduse "salvestuspunkt" -- sa salvestad hetkeolukorra koos kirjeldava sõnumiga. Hiljem saad alati tagasi minna. Valed: B -- commit ei kustuta midagi; C -- commit pole e-mail; D -- commit pole installeerimine.
Küsimus 3: Vastus: D
SELECT * FROM products; on SQL põhipäring. SELECT valib, * tähendab kõiki veerge, FROM products määrab tabeli. Valed: A, B, C -- need ei ole kehtiv SQL süntaks.
Küsimus 4: Vastus: B
Avalik repositoorium on su professionaalne portfoolio. Tööandjad, mentorid ja kolleegid saavad näha su tööd. See on nagu LinkedIn, aga koodile. Valed: A -- privaatsed repod töötavad; C -- GitHub lubab privaatseid; D -- nähtavus ei mõjuta kiirust.
Küsimus 5: Vastus: A
COUNT(*) on SQL funktsioon, mis loeb kõik read tabelis. Valed: B -- SUM(*) ei ole kehtiv; C -- TOTAL pole SQL käsk; D -- NUMBER pole SQL käsk.
Küsimus 6: Näidisvastus:
●	Git on tarkvara sinu arvutis, mis jälgib failide muudatusi (versioonihaldus)
●	GitHub on veebileht (pilveteenus), kus sa oma Git-repositooriume hoiad ja jagad teistega
Mõtle: Git = päevik sinu laual. GitHub = pilveteenus, kus päevik on teistele kättesaadav.
Küsimus 7: Vastus: D
LIMIT 10 piirab tulemuse 10 reaga. See on kasulik suurte tabelite puhul, kus sa ei taha näha kõiki ridu korraga. Valed: A -- see on WHERE tingimus, mitte LIMIT; B -- see on ORDER BY, mitte LIMIT; C -- LIMIT ei kustuta.
Küsimus 8: Vastus: C
SQL saab teha arvutusi ja näidata staatilisi väärtusi. Tulemus on tabel ühe reaga: veerg sonum väärtusega "Tere!" ja veerg tulemus väärtusega 5. Valed: A -- see on kehtiv SQL; B -- tulemus ei ole tühi; D -- see päring ei näita tabeleid.
Küsimus 9: Vastus: B
Avalikus repositooriumis on kõik nähtav. Kui sa commit'id salasõnad, võib keegi leida need ja pääseda ligi su Supabase kontole, e-postile vms. Kasuta .gitignore faili ja keskkonnamuutujaid. Valed: A -- kuigi salasõnad võivad muutuda, pole see peamine oht; C -- Git toetab kõiki märke; D -- pikkus pole probleem.
Küsimus 10: Näidisvastus:
Vertikaalne lahendus tähendab kogu töövoo läbimist algusest (andmed) kuni lõpuni (tulemus). Ma kasutasin:
1. Supabase -- sisestasin andmed andmebaasi (INSERT)
2. VS Code + GitHub -- kirjutasin SQL faili ja commit'isin koodi versioonihaldusesse
3. SQLTools -- käivitasin päringu otse VS Code'ist Supabase'i vastu
Kõik tööriistad on ühendatud: andmed pilves (Supabase) ↔ kood versioonihalduses (GitHub) ↔ päringud koodiredaktorist (VS Code). See on professionaalse andmeanalüütiku igapäevane töövoog.
