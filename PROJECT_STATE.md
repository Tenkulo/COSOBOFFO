# PROJECT_STATE - COSOBOFFO
> File di stato operativo. Da leggere PRIMA di qualsiasi sessione di lavoro. Aggiornare questo file ad ogni fine sessione.

STATO CORRENTE
--------------

| Campo | Valore |
|---|---|
| **Fase** | 3 - ROBLOX TECHNICAL START |
| **Sotto-fase** | Lore espansa + Tech fondamenta pronte |
| **Concept** | v1 LOCKED |
| **Lore** | v2.0 AGGIORNATO - SCP + Backrooms + Analog Horror integrati |
| **Requirements** | v1 LOCKED (REQUIREMENTS_ULTIMATE_2026.md) |
| **GDD** | v1.2 AGGIORNATO - 5 Paths narrativi |
| **Entita'** | v2.0 AGGIORNATO - 10 entita' roster con parametri gameplay |
| **Tech Design** | OK (TECH_DESIGN_RBX_v1.md) |
| **Backlog** | OK (TASKS_BACKLOG_RBX_v1.md) |
| **Data ultimo aggiornamento** | 2026-03-06 |

DIAGNOSI DI SESSIONE (PER LA PROSSIMA IA)
-----------------------------------------
* Ricerca trend reale eseguita: SCP:SL, REPO, Lethal Company, Backrooms games, analog horror community.
* Integrati 3 nuovi Path narrativi nel GDD: SCP (Siti Dimenticati), Backrooms (Spazi Liminali), Analog Horror (Trasmissione Distorta).
* Roster entita' espanso a 10 entita' con parametri gameplay completi e colonna ispirazione.
* LORE v2.0: aggiunta sezione Regole di Design da trend research (cosa funziona / cosa evitare).

PROSSIMI PASSI (IN ORDINE)
--------------------------

### STEP 1 - Roblox Studio (PRIORITA' ASSOLUTA)
* [ ] T001: Creare Place principale Hub in Roblox Studio - salvare Place ID qui
* [ ] T002: Struttura cartelle Explorer (da TECH_DESIGN sez.1)
* [ ] T003: RemoteEvents in ReplicatedStorage/Remotes/
* [ ] T004: StateMachine.lua (ModuleScript)
* [ ] T005: Place secondario PizzeriaDistorta

### STEP 2 - Codice entita'
* [ ] T006: CorrettoreMeccanico.server.lua con StateMachine
* [ ] T008: Test PATROL->ALERT->CHASE su baseplate
* [ ] T009: Look-away mechanic (Camera.CFrame vs entity direction)

### STEP 3 - GameManager
* [ ] T010: GameManager.server.lua (obiettivi: 3 Memorie + extraction)
* [ ] T011: ExtractionPoint (trigger Part)

FILE CANON
----------

| File | Stato | Versione |
|---|---|---|
| REQUIREMENTS_ULTIMATE_2026.md | LOCKED | v1.0 |
| LORE_CORE_ULTIMATE_2026.md | AGGIORNATO | v2.0 |
| GAME_GDD_v1.md | AGGIORNATO | v1.2 |
| ENTITIES_HIERARCHY_AND_LORE_v1.md | AGGIORNATO | v2.0 |
| TECH_DESIGN_RBX_v1.md | OK | v1.0 |
| TASKS_BACKLOG_RBX_v1.md | OK | v1.0 |

Ultima modifica: 2026-03-06 | Sessione: scp_backrooms_analog_integration
