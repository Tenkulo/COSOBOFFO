# PROJECT_STATE - COSOBOFFO
> File di stato operativo. Da leggere PRIMA di qualsiasi sessione di lavoro. Aggiornare questo file ad ogni fine sessione.

STATO CORRENTE
--------------

| Campo | Valore |
|---|---|
| **Fase** | 3 - ROBLOX TECHNICAL START |
| **Sotto-fase** | Roster 30 entita completo + Lore espansa |
| **Concept** | v1 LOCKED |
| **Lore** | v2.0 LOCKED - SCP + Backrooms + Analog Horror integrati |
| **Requirements** | v1 LOCKED (REQUIREMENTS_ULTIMATE_2026.md) |
| **GDD** | v1.2 AGGIORNATO - 5 Paths narrativi |
| **Entita** | v3.0 COMPLETO - 30 entita uniche con background dettagliati |
| **Tech Design** | OK (TECH_DESIGN_RBX_v1.md) |
| **Backlog** | DA AGGIORNARE con task per 30 entita |
| **Data ultimo aggiornamento** | 2026-03-06 05:00 CET |

DIAGNOSI DI SESSIONE (PER LA PROSSIMA IA)
-----------------------------------------
* Roster entita espanso da 10 a 30 entita uniche.
* Ogni entita ha: background dettagliato ispirato a lore ufficiale (FNaF, Poppy, SCP, Backrooms, Mandela Catalogue), mechanic gameplay unica, parametri completi.
* Distribuzione bilanciata: 5 Custodi boss + 8 Correttori elite + 8 Scarti ostacoli + 9 Echi base.
* Stereotipi richiesti inclusi: ARK-173 (SCP-173), ARK-096 (SCP-096), Festaiolo (Freddy), Direttrice (Mommy), ARK-PRIME (SCP-079), Eco Zero (Backrooms Void), Frequenza-Madre (Local 58).
* File ENTITIES_FULL_ROSTER_v3.md creato come master roster (sostituisce ENTITIES_HIERARCHY v2.0).

PROSSIMI PASSI (IN ORDINE)
--------------------------

### STEP 1 - Roblox Studio Setup (PRIORITA ASSOLUTA)
* [ ] T001: Creare Place principale Hub in Roblox Studio - salvare Place ID qui
* [ ] T002: Struttura cartelle Explorer (da TECH_DESIGN sez.1)
* [ ] T003: RemoteEvents in ReplicatedStorage/Remotes/
* [ ] T004: StateMachine.lua (ModuleScript base per tutte le 30 entita)
* [ ] T005: Place secondario PizzeriaDistorta

### STEP 2 - Implementazione Entita VS-CORE (6 entita)
* [ ] T006: CorrettoreMeccanico.server.lua (E1)
* [ ] T007: Silenziatore.server.lua (E2)
* [ ] T008: ScartoAbbandonato.server.lua (S1)
* [ ] T009: CollezionistaDiPassi.server.lua (S2)
* [ ] T010: Osservatore.server.lua (ECO1)
* [ ] T011: UrloSordo.server.lua (ECO2)

### STEP 3 - Implementazione Entita P1 (8 entita)
* [ ] T012-T019: ARK-173, ARK-096, Collezionista Ricordi, Guardiano Palcoscenico, Assemblatore, Frammento Risata, Impronta Sbagliata, Numero Ripetuto

### STEP 4 - GameManager e Sistemi Core
* [ ] T020: GameManager.server.lua (spawn dinamico entita basato su Path e Tier)
* [ ] T021: ExtractionPoint + LootSystem
* [ ] T022: HUD con indicatori per 30 entita (audio cue system)

### STEP 5 - Boss Post-VS (5 Custodi)
* [ ] T023-T027: Festaiolo, Direttrice, ARK-PRIME, Eco Zero, Frequenza-Madre

FILE CANON
----------

| File | Stato | Versione | Note |
|---|---|---|---|
| REQUIREMENTS_ULTIMATE_2026.md | LOCKED | v1.0 | Fondamenta |
| LORE_CORE_ULTIMATE_2026.md | LOCKED | v2.0 | 5 Path narrativi |
| GAME_GDD_v1.md | OK | v1.2 | 5 Paths definiti |
| ENTITIES_FULL_ROSTER_v3.md | OK | v3.0 | 30 entita complete |
| ENTITIES_HIERARCHY_AND_LORE_v1.md | DEPRECATED | v2.0 | Sostituito da ROSTER v3 |
| TECH_DESIGN_RBX_v1.md | OK | v1.0 | Architettura Roblox |
| TASKS_BACKLOG_RBX_v1.md | DA AGGIORNARE | v1.0 | Serve espansione task |

ROADMAP IMPLEMENTAZIONE ENTITA
-------------------------------

**Vertical Slice (6 entita VS-CORE):**
- E1: Correttore Meccanico (FNaF)
- E2: Silenziatore (Cross)
- S1: Scarto Abbandonato (Poppy)
- S2: Collezionista di Passi (Cross)
- ECO1: Osservatore (Cross)
- ECO2: Urlo Sordo (Cross)

**Alpha (+ 8 entita P1):**
- E3: ARK-173 Scultore (SCP)
- E4: ARK-096 Recluso (SCP)
- E6: Collezionista Ricordi (Cross)
- S4: Guardiano Palcoscenico (FNaF)
- S7: Assemblatore (Poppy)
- ECO5: Frammento Risata (FNaF)
- ECO6: Impronta Sbagliata (Poppy)
- ECO7: Numero Ripetuto (SCP)

**Beta (+ 11 entita P2):**
- E5, E7, E8: Organista, Memoria Cancellata, Testimone Distorto
- S3, S5, S6, S8: Procedura, Camera Sussurrante, Bambino Dimenticato, Corridoio Infinito
- ECO3, ECO4, ECO8, ECO9: Eco Liminale, Voce Segnale, Lacrima Cemento, Sospiro Registrato

**Release (+ 5 Boss Custodi):**
- C1: Festaiolo Definitivo (FNaF)
- C2: Direttrice Eterna-Memoire (Poppy)
- C3: ARK-PRIME Catalogatore (SCP)
- C4: Eco Zero (Backrooms)
- C5: Frequenza-Madre (Analog Horror)

RISKS/BLOCKERS
--------------
- Scope espanso a 30 entita richiede sistema AI modulare robusto (StateMachine.lua critico)
- Ogni entita ha mechanic unica: serve testing individuale rigoroso
- Boss fight 5 Custodi richiedono arena design custom (post-VS)
- Asset audio: 30 Core Sounds unici da creare/trovare
- Bilanciamento difficolta: evitare entita troppo facili/impossibili (feedback playtesting)

Ultima modifica: 2026-03-06 05:00 CET | Sessione: entities_roster_expansion_30
