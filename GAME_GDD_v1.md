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

## 3. STORY MODE – ARCHIVIO CANON

### 3.1 Obiettivi della Story Mode

- Introdurre in modo guidato la lore dell'Archivio, delle gilde e delle entità, senza testi lunghi o schermate statiche.
- Insegnare in modo progressivo tutte le meccaniche core (movimento, stealth, gestione risorse, interazione, co-op) in un contesto narrativo.
- Creare un motivo forte per rigiocare: capitoli rigiocabili, varianti di eventi, ricompense di lore e cosmetiche legate ai path.
- Fornire il canone narrativo ufficiale: tutto ciò che accade nelle altre modalità deve essere coerente con quanto stabilito qui.

### 3.2 Struttura ad Atti

La Story Mode è divisa in 4 Atti principali, ciascuno composto da 2–4 capitoli (run istanziate):

- **Atto 0 – La Prima Ricorrenza (Prologo)**
  - Durata: 5–10 minuti.
  - Solo o co-op; serve come introduzione all'Archivio e all'Archivista.
  - Obiettivo: entrare nell'Archivio per la prima volta, comprendere il concetto di "ricorrenza" e vedere un primo Custode.

- **Atto 1 – Custodi dell'Archivio**
  - Durata: 2–3 capitoli da 10–15 minuti.
  - Focus: regole dello spazio, tensione controllata, entità lente ma oppressive (Custodi).
  - Obiettivo: insegnare ai giocatori come leggere l'ambiente, riconoscere segnali visivi/sonori di pericolo, usare strumenti base.

- **Atto 2 – Correttori Scissi**
  - Durata: 2–4 capitoli da 10–20 minuti.
  - Focus: entità aggressive, glitch visivi/sonori, introduzione delle "fratture" tra path (SCP, Backrooms, Analog).
  - Obiettivo: mostrare come l'Archivio possa riscrivere memorie ed eventi, introdurre le scelte di path che influenzano cutscene e ricompense.

- **Atto 3 – Eco dell'Archivista**
  - Durata: 2–3 capitoli da 10–20 minuti + finale.
  - Focus: Echi, Scarti, Avatar di Gilda, rivelazione del ruolo delle gilde nell'Archivio.
  - Obiettivo: chiudere l'arco principale, sbloccare varianti di finali e ricompense di status (titoli, maschere, banner).

Ogni Atto ha:
- Un "Capitolo Hub" nel quale il giocatore torna (fisicamente o narrativamente) all'Hub di Gilda.
- 1 cutscene di apertura e 1 di chiusura (skippabili), più micro-sequenze in-game (camere scriptate, eventi ambientali).

### 3.3 Path narrativi e rigiocabilità

Durante l'Atto 2 e l'Atto 3, il giocatore incontra bivi narrativi chiamati **Path**:

- **Path Custodi**: rafforza la conoscenza dell'Archivio e delle sue regole; favorisce ricompense legate al controllo e alla percezione.
- **Path Correttori**: enfatizza la distorsione, i glitch, i rischi alti; ricompense più aggressive/estetiche.
- **Path Echi/Scarti**: esperienze più psicologiche, con focus su memorie, voci, duplicazioni.
- **Path Avatar di Gilda**: meta-path legato alle gilde, ai loro avatar e alle loro tracce nell'Archivio.

Regole base dei Path:
- I Path non creano finali totalmente separati, ma varianti di eventi e cutscene all'interno dello stesso arco canon.
- I Path sbloccano capitoli opzionali e ricompense specifiche (badge, titoli, cosmetici).
- La prima run della Story Mode propone un "percorso consigliato" (es. Custodi → Correttori → Echi) per non disorientare i nuovi giocatori.
- Le run successive permettono di scegliere Path diversi dall'Hub di Gilda, mantenendo però sempre un "critical path" verso il finale canon.

### 3.4 Cutscene e narrazione visiva

La narrazione avviene principalmente in modo visivo e in-game:

- **Cutscene skippabili brevi**:
  - Durata target: 10–30 secondi (max 60 secondi per i momenti chiave di fine Atto).
  - Attivate all'inizio/fine capitolo e in alcuni snodi di Path.
  - Skippare non penalizza gameplay o ricompense, ma fa perdere dettagli di lore.

- **Regia in-game**:
  - Eventi con camera scriptata (es. inquadratura su un corridoio che si piega, silhouette di un Custode che attraversa in fondo).
  - Transizioni di luce e colore per indicare cambi di Path o fasi (es. Backrooms → giallo malato, SCP → freddo metallico, Analog → disturbi VHS).
  - Uso di audio spaziale (sussurri, passi, metallo, interferenze radio) per anticipare entità e eventi.

- **Environmental storytelling**:
  - Oggetti, annotazioni, segni sul pavimento/muri che raccontano la storia di gilde precedenti.
  - Terminali, log vocali o frammenti "trovati" che si allineano alla lore di LORE_CORE_ULTIMATE_2026.md.

### 3.5 Collegamento con altre modalità

La Story Mode è il riferimento canon per tutte le altre modalità:

- La modalità **Chase/Challenge** riutilizza stanze e entità della Story Mode, ma senza cutscene e con obiettivi più brevi e intensi.
- La modalità **Custom/Creator** sblocca elementi (stanze, entità, effetti) solo dopo che sono stati visti almeno una volta nella Story Mode.
- Il metagame di gilda (rank, titoli, banner) è fortemente legato ai progressi nella Story Mode (es. completare l'Atto 2 sblocca una cornice speciale per la gilda).

Note operative:
- Ogni Atto e Path dovranno essere mappati a scene/PlaceId specifici in Roblox.
- ENTITIES_HIERARCHY_AND_LORE_v1.md deve indicare in quali Atti/Path compaiono le entità principali.
- TECH_DESIGN_RBX_v1.md deve definire come gestire teletrasporti e salvataggi tra i capitoli della Story Mode.


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
