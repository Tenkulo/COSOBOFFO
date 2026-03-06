# PROJECT_STATE – COSOBOFFO
> File di stato operativo. Da leggere PRIMA di qualsiasi sessione di lavoro. Aggiornare questo file ad ogni fine sessione.

STATO CORRENTE
--------------

| Campo | Valore |
|---|---|
| **Fase** | 3 – ROBLOX TECHNICAL START |
| **Sotto-fase** | Fondamenta tecniche avviate |
| **Concept** | v1 LOCKED (non modificare senza motivo forte) |
| **Lore** | v1 LOCKED (LORE_CORE_ULTIMATE_2026.md) - Integrata lore Mascot Horror |
| **Requirements** | v1 LOCKED (REQUIREMENTS_ULTIMATE_2026.md) |
| **GDD** | v1.1 AGGIORNATO (GAME_GDD_v1.md) |
| **Entita** | Roster integrato Mascot Horror (ENTITIES_HIERARCHY_AND_LORE_v1.md) |
| **Tech Design** | CREATO (TECH_DESIGN_RBX_v1.md) |
| **Backlog** | CREATO (TASKS_BACKLOG_RBX_v1.md) |
| **Data ultimo aggiornamento** | 2026-03-06 |

DIAGNOSI DI SESSIONE (PER LA PROSSIMA IA)
-----------------------------------------
* Creato TECH_DESIGN_RBX_v1.md: struttura cartelle Studio, naming convention, architettura AI state machine, flusso sessione server.
* Creato TASKS_BACKLOG_RBX_v1.md: 18 task in 5 sprint, con priorita P0/P1/P2, checklist manuale per test AI.
* Fase 3 operativa: tutti i documenti fondamentali sono presenti nella repo.

PROSSIMI PASSI (IN ORDINE)
--------------------------

### STEP 1 – Roblox Studio (DA FARE SUBITO)
* [ ] T001: Creare Place principale Hub in Roblox Studio
* [ ] T002: Struttura cartelle Explorer (da TECH_DESIGN sez.1)
* [ ] T003: Creare RemoteEvents in ReplicatedStorage/Remotes/
* [ ] T004: Implementare StateMachine.lua (ModuleScript)
* [ ] T005: Creare Place secondario PizzeriaDistorta

### STEP 2 – Entita e AI
* [ ] T006: CorrettoreMeccanico.server.lua con StateMachine
* [ ] T008: Test PATROL->ALERT->CHASE su baseplate
* [ ] T009: Look-away mechanic

### STEP 3 – GameManager & Extraction
* [ ] T010: GameManager.server.lua
* [ ] T011: ExtractionPoint

FILE CANON
----------

| File | Stato | Note |
|---|---|---|
| REQUIREMENTS_ULTIMATE_2026.md | OK | Fondamenta canon |
| LORE_CORE_ULTIMATE_2026.md | OK | Mitologia centrale con trend 2026 |
| GAME_GDD_v1.md | OK | Design core stabilizzato |
| ENTITIES_HIERARCHY_AND_LORE_v1.md | OK | Roster integrato Mascot Horror |
| TECH_DESIGN_RBX_v1.md | OK | Architettura tecnica Roblox |
| TASKS_BACKLOG_RBX_v1.md | OK | Backlog Sprint 1-5 con 18 task |

Ultima modifica: 2026-03-06 | Sessione: phase3_tech_kickoff
