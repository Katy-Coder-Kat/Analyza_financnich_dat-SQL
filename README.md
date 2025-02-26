📊 SQL Analýza Finančních Dat
SQL dotazy, které odhalují, kdo splácí dluhy, kde se točí nejvíc peněz a proč v této bance skoro nikdo pod 30 neexistuje.

📌 Co všechno tahle analýza řeší?
✅ Kdo má na kontě víc splacených půjček – muži, nebo ženy?
✅ Jaký je průměrný věk dlužníků?
✅ Které regiony mají nejvíc úvěrů a splácení?
✅ Kolik klientů splňuje podmínky zůstatek > 1000, víc než 5 půjček, narození po 1990?
💀 (Nikdo)
✅ Kterým klientům expirovala platební karta?

📂 Databázové tabulky
Tabulka	Popis
client	Informace o klientech (ID, datum narození, okres, atd.)
loan	Úvěry (výše půjčky, stav, splatnost)
account	Bankovní účty (ID účtu, okres, frekvence používání)
disp	Propojení účtů s klienty (držitel účtu, disponent)
district	Regiony (název, počet obyvatel, průměrná mzda)
card	Platební karty (ID karty, datum vydání, typ)
🔎 Hlavní zjištění
## 📊 Kdo má víc splacených půjček – muži nebo ženy?

| Pohlaví | Celková výše splacených úvěrů | Počet splacených úvěrů |
|---------|------------------------------|------------------------|
| **Muži**  | 43 256 388 | 299 |
| **Ženy**  | 44 425 200 | 307 |

🔎 **Výsledek:** Ženy splácejí víc.

---

## 📈 Jaký je průměrný věk dlužníka podle pohlaví?

| Pohlaví | Průměrný věk |
|---------|-------------|
| **Muži**  | 66,87 let |
| **Ženy**  | 64,85 let |

🧐 **Vysvětlení:** Databáze obsahuje pouze klienty narozené mezi lety **1911 a 1987**. Žádní dvacátníci, spíš zkušení matadoři finančního světa.

---

## 🌍 Který region má nejvíc klientů a kde se nejvíce splácí úvěry?

| District ID | Počet klientů | Celková výše splacených úvěrů | Počet úvěrů |
|------------|--------------|------------------------------|-------------|
| **1 (Praha)** | 92 | 14 180 088 | 92 |
| **74**      | 22 | 3 790 404 | 22 |
| **64**      | 19 | 3 786 336 | 19 |

📌 **Výsledek:** Praha vede ve všech kategoriích. Logické – nejvíc lidí, nejvíc úvěrů, nejvíc dluhů.

---

## 🏦 Kolik klientů splňuje podmínky (zůstatek > 1000, více než 5 půjček, narození po roce 1990)?

☠ **Nikdo. Nula. Ani jeden člověk.**

💡 **Proč?**  
- V databázi **skoro neexistují klienti narození po roce 1990**.  
- Nikdo neměl víc než **5 půjček**. 

---

## 💳 Kdo má expirovanou platební kartu?

| Client ID | Card ID | Expiration Date | Client Address |
|-----------|---------|----------------|---------------|
| 483 | 83  | 2001-01-05 | Prague |
| 858 | 149 | 2001-01-07 | East Bohemia |
| 1913 | 304 | 2001-01-06 | North Moravia |

📌 **Výsledek:** Úspěšně vygenerovaná tabulka expirovaných karet. 

---

### 🛠 **Chyby, na které jsem narazila**
❌ **Join na district tabulku nefungoval** – sloupce se jmenovaly jinak, než jsem čekala.  
❌ **Filtr klientů podle věku nevracel prázdné výsledky** – žádní mladí klienti v databázi nebyli.  
❌ **SQL nepovoluje „kouzla“** – když v datech něco není, tak to tam prostě nenajdeš.

---

### ✅ **Závěr**
Projekt proběhl úspěšně. **SQL dotazy vracejí smysluplná data**, některé výsledky překvapily (například **nula klientů narozených po roce 1990**).
