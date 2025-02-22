Úvod
Tento projekt obsahuje SQL dotazy pro analýzu finančních dat, identifikaci splacených úvěrů podle pohlaví, kontrolu expirovaných karet a další zajímavosti. Po cestě jsem narazila na pár nečekaných překvapení, ale nakonec všechno klaplo (víceméně).

Použité databázové tabulky
Tabulka	Popis
client	Informace o klientech (ID, datum narození, okres atd.)
loan	Údaje o úvěrech (výše půjčky, status, splatnost)
account	Bankovní účty (ID účtu, okres, frekvence používání)
disp	Propojení účtů s klienty (držitel účtu, disponent)
district	Informace o regionech (název, počet obyvatel, průměrná mzda)
card	Vydané platební karty (ID karty, datum vydání, typ)
Hlavní dotazy a výsledky
1. Kdo má víc splacených půjček – muži nebo ženy?
Gender	Celková výše splacených úvěrů	Počet splacených úvěrů
M	43 256 388	299
F	44 425 200	307
Výsledek: Více jich splatily ženy. Pravděpodobně lepší finanční plánování... nebo jen lepší strategie, jak se vyhnout bankám.
2. Který region má nejvíce klientů a kde se nejvíce splácí úvěry?
District ID	Počet klientů	Celková výše splacených úvěrů	Počet úvěrů
1 (Praha)	92	14 180 088	92
74	22	3 790 404	22
64	19	3 786 336	19
Výsledek: Hlavní město Praha vede ve všech kategoriích. Logické – nejvíc lidí, nejvíc úvěrů, nejvíc dluhů.
3. Výběr klientů s určitými podmínkami (zůstatek > 1000, více než 5 půjček, narození po roce 1990)
Výsledek: Nikdo neexistuje.
Původně jsem si myslela, že filtr jen vyřadil pár klientů, ale realita byla tvrdší: žádný klient nesplňoval všechny tři podmínky najednou.
Problém byl ve dvou bodech:
V databázi skoro neexistují klienti narození po roce 1990. Zřejmě to byla banka pro zkušenější ročníky. Možná mladší generace už dávno vymyslela nějakou alternativní ekonomiku nebo se do půjček prostě nehrne.
Nikdo neměl víc než 5 půjček. Buď byla banka opravdu přísná v poskytování úvěrů, nebo jsou klienti extrémně finančně zodpovědní. (To druhé moc pravděpodobné není.)
Po uvolnění podmínek (snížení limitu půjček, zvýšení věkového limitu) se začaly objevovat výsledky. Lekce pro příště: ne všechny kombinace filtrů dávají smysl, občas je potřeba udělat krok zpět a podívat se, jestli jsem si sama nenastavila nemožné požadavky.
4. Kontrola platebních karet s končící platností
Client ID	Card ID	Expiration Date	Client Address	Generated For Date
483	83	2001-01-05	Prague	2001-01-01
858	149	2001-01-07	East Bohemia	2001-01-01
1913	304	2001-01-06	North Moravia	2001-01-01
Výsledek: Úspěšně vygenerovaná tabulka expirovaných karet. Klienti by si měli začít hlídat schránky, jinak je čeká nemilé překvapení u bankomatu.
Chyby, na které jsem narazila
Join na district tabulku nefungoval – ukázalo se, že sloupce mají jiný název, než jsem čekala. Databáze mě prostě ráda překvapuje.
Filtr klientů podle věku nevracel žádná data – po pečlivém pátrání jsem zjistila, že v databázi skoro žádní “mladí” klienti nejsou. No, asi byli chytřejší a úvěrům se vyhnuli.
Závěr
Projekt proběhl úspěšně, i když pár momentů mě donutilo zamyslet se nad životními rozhodnutími (a databázovým designem). 
