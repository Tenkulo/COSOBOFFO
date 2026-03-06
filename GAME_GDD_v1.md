# GAME_GDD_v1.md - COSOBOFFO
> Versione: 1.2 | Stato: AGGIORNATO | Data: 2026-03-06
> Integrazione: SCP Foundation + Backrooms + Analog Horror paths

## 1. GAMEPLAY LOOP

1. **Hub (L'Archivio):** Socializzazione, gestione Gilda, upgrade, accesso agli Archi Narrativi.
2. **Elevatore delle Memorie:** Scelta dell'istanza (Story / Chase / Gilda) e del Path narrativo.
3. **Istanza:** Esplorazione, obiettivi dinamici, sopravvivenza alle entita'.
4. **Extraction:** Ritorno all'hub con Loot e Ricompense. Fallire la extraction = perdere il loot della run.

## 2. TIPI DI ISTANZE

| Tipo | Descrizione | Durata |
|---|---|---|
| Story (Linear) | Archi narrativi fissi con obiettivi scripted | 15-20 min |
| Chase (Roguelite) | Stanze procedurali con difficolta' crescente | 10-15 min |
| Custom (Guild) | Istanze modificate dalla gilda, regole custom | variabile |

## 3. ARCHI NARRATIVI (PATHS)

Ogni Path ha ambiente unico, entita' specifiche e mechanic centrale.

### PATH A: Il Ristorante della Memoria (FNaF)
- **Ambiente:** Pizzeria anni '80 corrotta - palcoscenici, cucine, corridoi retrostanti infiniti.
- **Mechanic centrale:** Look-Away cooperativa (le entita' si fermano se guardate).
- **Entita' VS:** Correttore Meccanico, Silenziatore, Osservatore.
- **Obiettivi tipici:** Raccogli 3 Memorie Audio + raggiungere l'uscita di servizio.
- **Loot narrativo:** Registrazioni vocali distorte, menu originali, foto di famiglie.

### PATH B: La Fabbrica degli Scarti (Poppy)
- **Ambiente:** Fabbrica di giocattoli abbandonata - nastri trasportatori, Playcare distorto, magazzini.
- **Mechanic centrale:** Stealth audio (il silenzio e' la sopravvivenza).
- **Entita' VS:** Scarto Abbandonato, Collezionista di Passi, Urlo Sordo.
- **Obiettivi tipici:** Riattiva 3 generatori silenziosi + extraction.
- **Loot narrativo:** Manuali di produzione, cassette VHS dei test, bozzetti di design.

### PATH C: I Siti Dimenticati (SCP) [NUOVO]
- **Ambiente:** Siti di Contenimento della Fondazione ora inglobati nell'Archivio - cemento, porte metalliche, celle numerate, monitor statici.
- **Mechanic centrale:** Cooperazione forzata (porte a doppio terminale, hack di sistema).
- **Entita' VS:** L'Archiviato, La Procedura, Silenziatore.
- **Obiettivi tipici:** Recupera 3 Documenti Fondazione + disattiva Protocollo di Contenimento + extraction.
- **Loot narrativo:** Documenti classificati frammentati, foto di personale sparito, registrazioni di esperimenti.
- **Tono:** Freddo, burocratico, istituzionale. L'orrore dell'ordine che e' diventato caos.

### PATH D: Gli Spazi tra le Memorie (Backrooms/Liminal) [NUOVO]
- **Ambiente:** Liminal spaces - corridoi scolastici di notte, piscine vuote, centri commerciali abbandonati, uffici senza finestre. Familiare. Sbagliato.
- **Mechanic centrale:** Sanity/Orientamento (stare separati abbassa la sanity, cooperazione la mantiene).
- **Entita' VS:** Eco Liminale, Osservatore, Urlo Sordo.
- **Obiettivi tipici:** Trova l'uscita (nessuna mappa, nessuna bussola) + non perdere il gruppo.
- **Loot narrativo:** MINIMO. Solo oggetti personali senza contesto. Il mistero e' il punto.
- **DESIGN RULE:** Non spiegare. Non classificare. Ogni run l'ambiente e' leggermente diverso.

### PATH E: La Trasmissione Distorta (Analog Horror) [NUOVO]
- **Ambiente:** Sale controllo anni '70-'80, studi televisivi, bunker con monitor a tubo catodico, torri radio.
- **Mechanic centrale:** Asimmetria informativa (1 giocatore vede, gli altri devono fidarsi).
- **Entita' VS:** Voce dal Segnale, Silenziatore, Correttore Meccanico.
- **Obiettivi tipici:** Trova e spegni 3 fonti di trasmissione prima che materializzino Correttori + extraction.
- **Loot narrativo:** VHS con contenuto disturbante, trascrizioni di trasmissioni, mappe di frequenze.

## 4. MECCANICHE CORE

| Mechanic | Descrizione | Path Primario |
|---|---|---|
| Look-Away | Entita' si ferma se guardata da almeno 1 giocatore | FNaF, Cross |
| Stealth Audio | Entita' detecta solo suoni, non vista | Poppy |
| Cooperazione Forzata | Azioni richiedono 2+ giocatori simultanei | SCP |
| Sanity/Orientamento | Isolarsi riduce orientamento, cooperare lo mantiene | Backrooms |
| Asimmetria Informativa | 1 solo giocatore vede la minaccia | Analog |
| Loot Narrativo | Oggetti rivelano lore volontariamente | Tutti i path |
| Varianza RNG | Ogni run ha seed diverso per entita' e obiettivi | Tutti i path |

## 5. LOOT & PROGRESSIONE

- **Affissi Memoria:** Oggetti che sbloccano nuove zone, potenziamenti temporanei o riducono spawn entita'.
- **Documenti Narrativi:** Loot che rivela lore (opzionale, mai obbligatorio).
- **Rank di Gilda:** Sblocca Path avanzati (SCP, Analog accessibili da Rank 5+), hub personalizzati.
- **Oggetti Speciali:** Equipaggiamento che interagisce con meccaniche specifiche (torcia UV per Backrooms, jammer per Analog).

## 6. REQUISITI PER VERTICAL SLICE

- 1 Hub base (spawn, elevatore, board gilda).
- 1 Istanza Story: PATH A - Pizzeria Distorta (FNaF).
- Entita': Correttore Meccanico + Silenziatore.
- Sistema loot base (3 tipi: Common/Rare/Epic).
- HUD: contatore Memorie, indicatore proximity entita' (audio).
- Extraction funzionante.

## 7. ROADMAP POST-VS

| Fase | Contenuto |
|---|---|
| VS | PATH A + 2 entita' + loot + extraction |
| Beta | PATH B + PATH C + 5 entita' |
| Release | PATH D + PATH E + tutti i Custodi |
| Post-Release | Path Gilda custom, nuovi Archi Narrativi |
