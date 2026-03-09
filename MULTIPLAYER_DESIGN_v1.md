# MULTIPLAYER_DESIGN_v1.md - COSOBOFFO

> Versione: 1.0 | Stato: DRAFT | Data: 2026-03-09

## 1. SESSION LIFECYCLE
La gestione della sessione è centralizzata in **GameManager.server.lua**.

1. **Lobby (Hub):** I giocatori (max 4) si uniscono in una squadra o usano il matchmaking.
2. **Path Selection:** Il Leader sceglie l'Arco Narrativo.
3. **Transition:** Creazione ReservedServer e Teleport via TeleportService.
4. **Setup:** Il Server carica la mappa procedurale (RoomGraph) e sincronizza i player.
5. **Gameplay:** Obiettivi dinamici (es. Raccogli 3 Memorie).
6. **Extraction:** Tutti i superstiti nell'area di extraction attivano il salvataggio dei dati e il ritorno all'Hub.

## 2. GESTIONE DISCONNESSIONE E FALLIMENTI
Decisioni binarie per la stabilità del gameplay.

* **Migrazione Leader:** **SÌ**. Se il Leader cade, il ruolo passa al player successivo. (Motivazione: Evita l'interruzione della run).
* **Riconnessione In-Run:** **NO**. Una volta fuori, il posto è perso per la run corrente. (Motivazione: Semplicità tecnica per il prototipo Phase 3).
* **Logging Penalty:** **SÌ**. Chi esce prima dell'extraction perde il loot. (Motivazione: Previene l'abuso dello "scollegamento tattico" per evitare la morte).

## 3. SCALING DIFFICOLTÀ
Il sistema adatta le minacce in base alla dimensione della squadra.

| Party Size | HP Entità (Mult) | Spawn Rate (Mult) | Obiettivi Richiesti |
| :--- | :--- | :--- | :--- |
| **1 Player** | 1.0x | 0.8x | 2 Memorie |
| **2 Players** | 1.5x | 1.2x | 3 Memorie |
| **3 Players** | 2.2x | 1.6x | 4 Memorie |
| **4 Players** | 3.0x | 2.0x | 5 Memorie |

## 4. SINCRONIZZAZIONE STATI CRITICI
Sistemi ottimizzati per 60 FPS (Luau strict mode).

* **Sanity & Stamina:** Sincronizzati tramite **Instance Attributes** (Performance superiore ai ValueObject).
* **IA Entità:** Elaborazione Server-side. Il Client riceve solo i target e lo stato (IDLE/CHASE) per le animazioni.
* **Obiettivi Globali:** Folder in ReplicatedStorage gestita dal GameManager.

## 5. COMUNICAZIONE TRA PLAYER
Strumenti per la coordinazione senza obbligo di microfono.

* **Sistema PING (Tasto G):** **SÌ**. Permette di marcare loot, entità o punti di interesse. (Motivazione: Standard moderno Roblox 2026).
* **Emotes Diegetiche:** **SÌ**. Segnali manuali (indica, stop, vieni). (Motivazione: Immersione horror).
* **Proximity Voice:** **NO**. Esclusiva per gilde verificate per ridurre la tossicità 13+.

## 6. ANTI-GRIEF & FAIR PLAY
Protezione contro comportamenti tossici o sabotaggi.

* **No Player Collision:** **SÌ**. Previene il blocco dei compagni nei corridoi stretti. (Motivazione: Cruciale per il design liminale).
* **Voto Espulsione:** **NO**. (Motivazione: Troppo spesso usato per escludere player a fine run per cattiveria).
* **Friendly Fire:** **NO**. (Motivazione: Rende il gioco frustrante e non aggiunge valore all'atmosfera cooperativa).
