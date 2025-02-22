Úvod
Tento projekt obsahuje SQL dotazy pro analýzu finančních dat, identifikaci splacených úvěrů podle pohlaví, kontrolu expirovaných karet a další zajímavosti. Po cestě jsem se setkala s několika překvapeními, ale nakonec všechno klaplo (víceméně).

Použité databázové tabulky
client – informace o klientech
loan – údaje o úvěrech
account – bankovní účty
disp – propojení účtů s klienty
district – informace o regionech
card – vydané platební karty
Hlavní dotazy a výsledky
Kdo má víc splacených půjček – muži nebo ženy?

Výsledek: Více jich splatily ženy. Pravděpodobně lepší finanční plánování... nebo jen lepší strategie, jak se vyhnout bankám.
Který region má nejvíce klientů a kde se nejvíce splácí úvěry?

Výsledek: Hlavní město Praha. Logické – nejvíc lidí, nejvíc úvěrů, nejvíc dluhů.
Výběr klientů s určitými podmínkami (zůstatek > 1000, více než 5 půjček, narození po roce 1990)

Výsledek: Nikdo neexistuje. Z toho plyne poučení – buď se všichni narodili dřív, nebo je v naší databázi problém.
Kontrola platebních karet s končící platností

Výsledek: Úspěšně vygenerovaná tabulka expirovaných karet. Klienti by si měli začít hlídat schránky, jinak je čeká nemilé překvapení u bankomatu.
Chyby, na které jsem narazila
Join na district tabulku nefungoval – ukázalo se, že sloupce mají jiný název, než jsem čekala. Databáze mě prostě ráda překvapuje.
Filtr klientů podle věku nevracel žádná data – po pečlivém pátrání jsem zjistila, že v databázi skoro žádní “mladí” klienti nejsou. No, asi byli chytřejší a úvěrům se vyhnuli.
Závěr
Projekt proběhl úspěšně, i když pár momentů mě donutilo zamyslet se nad životními rozhodnutími (a databázovým designem). 
