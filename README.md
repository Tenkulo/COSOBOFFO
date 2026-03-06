# COSOBOFFO – Horror Guild Runs: L'Archivio dei Ricorrenti

> **Repo di progetto ufficiale** – Gioco horror co-op su Roblox con sistema di gilde, lore extradimensionale e meta-progressione stile ARPG.
> Data creazione: 2026-03-06 | Branch principale: `main`

---

## STATO DEL PROGETTO

| Campo | Valore |
|---|---|
| **Fase attuale** | 2 – GAME DESIGN DOCUMENT (GDD) |
| **Versione concept** | v1 LOCKED (canon) |
| **Prossimo passo** | Completare GDD v1 + Entities Overview v1 + Avvio fase tecnica Roblox |
| **Piattaforma** | Roblox (PC + Mobile; Console futuro) |
| **Branch attivo** | `main` |
| **Ultimo aggiornamento** | 2026-03-06 |

---

## STRUTTURA REPO

```
COSOBOFFO/
├── README.md                        # Questo file – stato progetto e guida sessione
├── PROJECT_STATE.md                 # Stato dettagliato per ripresa sessione IA
├── REQUIREMENTS_ULTIMATE_2026.md   # Requisiti definitivi del gioco (v1 canon)
├── LORE_CORE_ULTIMATE_2026.md      # Lore centrale definitiva (v1 canon)
├── GAME_GDD_v1.md                  # Game Design Document v1
├── ENTITIES_HIERARCHY_AND_LORE_v1.md # Gerarchia entita + background
├── LOOT_DESIGN_ARCHIVIO_v1.md      # Sistema loot stile ARPG adattato
├── REWARDS_STATUS_DESIGN_v1.md     # Sistema ricompense e status 2026
└── docs/
    └── (future: asset list, tech design, task backlog)
```

---

## PITCH IN UNA RIGA

> "Horror co-op a run su Roblox in cui tu e la tua gilda esplorate un Archivio vivente di memorie distorte, affrontando stanze impossibili, entita extradimensionali corrotte e test di sopravvivenza sempre diversi, mentre la storia del mondo cambia in base a cio che scoprite."

---

## PILLARS DI DESIGN

1. **Horror atmosferico + tensione controllata** (psicologico, non gore)
2. **Run istanziate brevi** (10-20 min) con obiettivo sempre chiaro
3. **Gilde fino a 67 membri** come fulcro del metagame
4. **Lore extradimensionale modulare** (archi + frammenti) centrata sull'Archivio
5. **Loot stile ARPG soft** (affissi percezione/movimento/lore, no pay-to-win)
6. **Rewards e status sociale** (titoli, maschere, banner, highlights)
7. **Monetizzazione fair** (solo cosmetici, no power)
8. **Live-ops e stagioni** (micro update 2-4 sett, season 2-3 mesi)

---

## FILE CHIAVE E LORO FUNZIONE

### PROJECT_STATE.md
File di stato operativo per riprendere il progetto in qualsiasi sessione nuova.
Contiene: fase corrente, decisioni prese, prossimi passi, rischi, vincoli tecnici.

### REQUIREMENTS_ULTIMATE_2026.md
Requisiti definitivi del gioco: target, piattaforma, pillars, struttura, gilde, monetizzazione, safety, discovery.

### LORE_CORE_ULTIMATE_2026.md
Mitologia completa: L'Archivio dei Ricorrenti, origine entita extradimensionali, archi narrativi, personaggi chiave (L'Archivista, Il Correttore Scisso), gilde nella storia.

### GAME_GDD_v1.md
Design Document: Hub, tipi di istanze (Story/Chase/Custom), difficolta, gilde, loot, rewards, progressione.

### ENTITIES_HIERARCHY_AND_LORE_v1.md
Gerarchia entita (Nucleo/Custodi/Correttori/Echi/Scarti/Avatar di Gilda) con background extradimensionale, ruolo gameplay, visual guide, reward associati.

---

## COME RIPRENDERE IL PROGETTO IN UNA NUOVA SESSIONE IA

1. Leggere `PROJECT_STATE.md` per capire dove siamo
2. Leggere `LORE_CORE_ULTIMATE_2026.md` come canon definitivo
3. Leggere `GAME_GDD_v1.md` per la struttura di design attuale
4. Leggere `ENTITIES_HIERARCHY_AND_LORE_v1.md` per le entita
5. Proseguire dal "PROSSIMO PASSO" indicato in `PROJECT_STATE.md`

> **Regola aurea**: nessuna modifica alla lore senza aggiornare `LORE_CORE_ULTIMATE_2026.md`.
> Ogni nuovo sistema o entita deve avere giustificazione nella lore.

---

## TARGET & TREND 2026

- Piattaforma: Roblox
- Target: giocatori 13-24 che gia giocano Doors, The Mimic, Apeirophobia, Rooms, Forgotten Memories, Dead Silence
- Playstyle: run 10-20 min, forte replay loop, progressione costante (badge, gilda, meta)
- Trend 2026 centrati: social co-opetition, UGC/creator tools, status visibile, live-ops leggeri, short session, monetizzazione fair

---

## NOTE TECNICHE

- Engine: Roblox Studio 2026
- Linguaggio: Luau
- Architettura istanze: TeleportService + ReservedServer
- Dati persistenti: DataStoreService + ProfileService
- AI entita: ModuleScript per macchine a stati (Idle/Alert/Chase/Attack/Reset)
- Target FPS: 60 su device moderni

---

*Repo gestita da: Tenkulo | Assistita da: Comet AI*
