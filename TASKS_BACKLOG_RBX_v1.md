# TASKS_BACKLOG_RBX_v1.md – COSOBOFFO
> Versione: 2.0 | Data: 2026-03-06 | Fase: 3 – ROBLOX TECHNICAL START

## LEGENDA
- **P0** = bloccante, deve uscire prima di tutto
- **P1** = necessario per Vertical Slice giocabile
- **P2** = polish / post-VS
- Stato: TODO / DOING / DONE

---

## SPRINT 1 – FONDAMENTA ROBLOX (P0)

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T001 | Creare Place principale su Roblox Studio (Hub) | P0 | TODO | Place ID da salvare in PROJECT_STATE |
| T002 | Creare struttura cartelle in Explorer (come da TECH_DESIGN sez.1) | P0 | TODO | ServerScriptService, ReplicatedStorage, ecc. |
| T003 | Creare RemoteEvents (EntityAlert, LootCollected, ExtractionReady) | P0 | TODO | Dentro ReplicatedStorage/Remotes/ |
| T004 | Implementare StateMachine.lua (ModuleScript generico) | P0 | TODO | IDLE/PATROL/ALERT/CHASE/ATTACK/RESET |
| T005 | Creare Place secondario: PizzeriaDistorta (istanza VS) | P0 | TODO | Serve per TeleportService |

---

## SPRINT 2 – ENTITÀ & AI (P0/P1)

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T006 | Implementare CorrettoreMeccanico.server.lua con StateMachine | P0 | TODO | Parametri da ENTITIES_HIERARCHY sez.2 |
| T007 | Aggiungere Core Sound al Correttore (suono metallico + risate) | P1 | TODO | Placeholder asset ok per VS |
| T008 | Testare PATROL -> ALERT -> CHASE su mappa piatta (baseplate test) | P0 | TODO | Checklist manuale: vedi sotto |
| T009 | Implementare look-away mechanic (entità si ferma se giocatore la guarda) | P1 | TODO | Confronta Camera.CFrame con entità direction |

---

## SPRINT 3 – GAMEMANAGER & FLUSSO SESSIONE (P0)

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T010 | Implementare GameManager.server.lua (spawn entità, obiettivi, timer) | P0 | TODO | Obiettivi VS: raccogli 3 Memorie + raggiungi uscita |
| T011 | Implementare ExtractionPoint (trigger Part + RemoteEvent) | P0 | TODO | Solo il leader può attivarlo (check gilda) |
| T012 | Implementare InstanceManager.server.lua (ReservedServer + Teleport) | P1 | TODO | Necessita Game Pass o Subscription Roblox |

---

## SPRINT 4 – HUD & CLIENT (P1)

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T013 | Creare HUD base (ScreenGui): contatore Memorie, stato Extraction | P1 | TODO | UDim2 relative, funziona su mobile |
| T014 | Implementare SoundManager.client.lua (audio spaziale 3D entità) | P1 | TODO | RolloffModel Linear, MaxDistance 40 studs |
| T015 | Aggiungere feedback visivo alert (schermo rosso flash su CHASE) | P2 | TODO | TweenService su ColorCorrectionEffect |

---

## SPRINT 5 – LOOT & PROGRESSIONE BASE (P1)

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T016 | Implementare LootTable.lua con 3 tipi Memoria (Common/Rare/Epic) | P1 | TODO | Drop da Correttore e da stanze |
| T017 | Salvare loot su DataStore al termine istanza | P1 | TODO | ProfileService (installare via Wally o manuale) |
| T018 | Mostrare riepilogo loot fine istanza (UI semplice) | P2 | TODO | Lista oggetti + XP gilda guadagnata |

---

## CHECKLIST MANUALE – TEST T008 (AI Correttore)

Dopo implementazione, verificare in Studio Play Solo:
- [ ] Correttore in PATROL percorre waypoint senza bloccarsi
- [ ] Quando giocatore entra in detectionRange (30 studs) -> stato ALERT (suono)
- [ ] Dopo 2 sec in ALERT senza allontanarsi -> stato CHASE
- [ ] Correttore raggiunge giocatore e applica danno/cattura
- [ ] Se giocatore esce da hearingRange (20 studs) + LoS persa -> RESET dopo 5 sec
- [ ] Look-away: se Camera punta entità, entità si ferma (solo se lookAwayImmune=false)

---

## NOTE
- Ogni task completato: aggiorna stato a DONE e annota data in colonna Note
- Ogni fine sessione: aggiorna PROJECT_STATE.md con task DOING/DONE recenti


---

## SPRINT 6 - ENTITÀ VS-CORE COMPLETE (P0)

**Obiettivo**: Implementare tutte le 6 entità VS-CORE necessarie per il Vertical Slice giocabile.

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T019 | Implementare Silenziatore.server.lua (E2) | P0 | TODO | Entità Cross - disabilita suono giocatore in raggio 15 studs |
| T020 | Implementare ScartoAbbandonato.server.lua (S1) | P0 | TODO | Poppy Playtime inspired - mimic oggetti innocenti |
| T021 | Implementare CollezionistaDiPassi.server.lua (S2) | P0 | TODO | Cross - traccia impronte, accumula velocità |
| T022 | Implementare Osservatore.server.lua (ECO1) | P0 | TODO | Cross - paralizza se osservato frontalmente |
| T023 | Implementare UrloSordo.server.lua (ECO2) | P0 | TODO | Cross - emette urlo intermittente, aumenta alert |
| T024 | Testare VS-CORE completo (6 entità simultanee) | P0 | TODO | Verificare balance e performance con spawn dinamico |

---

## SPRINT 7 - ENTITÀ P1 ALPHA (8 entità)

**Obiettivo**: Espandere roster con entità Priority 1 per build Alpha.

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T025 | Implementare ARK-173 Scultore (E3) | P1 | TODO | SCP-173 - movimento solo quando non osservato |
| T026 | Implementare ARK-096 Recluso (E4) | P1 | TODO | SCP-096 - trigger da visione faccia, inseguimento inarrestabile |
| T027 | Implementare CollezionistaDiRicordi.server.lua (E6) | P1 | TODO | Cross - ruba item dalla hotbar giocatore |
| T028 | Implementare GuardianoPalcoscenico.server.lua (S4) | P1 | TODO | FNaF Foxy - resta fermo se osservato via telecamera |
| T029 | Implementare Assemblatore.server.lua (S7) | P1 | TODO | Poppy - costruisce blocchi/trappole durante patrol |
| T030 | Implementare FrammentoRisata.server.lua (ECO5) | P1 | TODO | FNaF - risata infantile come audio cue |
| T031 | Implementare ImprontaSbagliata.server.lua (ECO6) | P1 | TODO | Poppy - genera false tracce/direzioni |
| T032 | Implementare NumeroRipetuto.server.lua (ECO7) | P1 | TODO | SCP - ripete numero vocale crescente prima di spawn |
| T033 | Testare Alpha build (14 entità totali) | P1 | TODO | Performance test con 14 entità in istanza |

---

## SPRINT 8 - ENTITÀ P2 BETA (11 entità)

**Obiettivo**: Completare roster entità standard (esclusi Boss Custodi).

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T034 | Implementare Organista.server.lua (E5) | P2 | TODO | Cross - suona organo, sound-based detection |
| T035 | Implementare MemoriaCancellata.server.lua (E7) | P2 | TODO | Cross - rimuove porzioni di HUD temporaneamente |
| T036 | Implementare TestimoneDistorto.server.lua (E8) | P2 | TODO | Cross - fake player model, comportamento erratico |
| T037 | Implementare Procedura.server.lua (S3) | P2 | TODO | SCP - forza giocatore a completare sequenze azioni |
| T038 | Implementare CameraSussurrante.server.lua (S5) | P2 | TODO | FNaF - sussurri vocali attraverso walls |
| T039 | Implementare BambinoDimenticato.server.lua (S6) | P2 | TODO | Poppy - pianto infantile, attira giocatore in trap |
| T040 | Implementare CorridoioInfinito.server.lua (S8) | P2 | TODO | Backrooms - crea loop spaziale temporaneo |
| T041 | Implementare EcoLiminale.server.lua (ECO3) | P2 | TODO | Backrooms - eco footstep falsi |
| T042 | Implementare VoceDelSegnale.server.lua (ECO4) | P2 | TODO | Analog Horror - broadcast radio distorto |
| T043 | Implementare LacrimaCemento.server.lua (ECO8) | P2 | TODO | Cross - gocce sonore persistenti |
| T044 | Implementare SospiroRegistrato.server.lua (ECO9) | P2 | TODO | Analog - sospiro loop ambientale |
| T045 | Testare Beta build (25 entità totali) | P2 | TODO | Stress test massivo |

---

## SPRINT 9 - BOSS CUSTODI (5 entità finali)

**Obiettivo**: Implementare i 5 Boss Custodi post-Vertical Slice.

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T046 | Implementare FestailoDefinitivo.server.lua (C1) | P2 | TODO | FNaF Boss - multiphase fight, convoca mini-entità |
| T047 | Creare arena Boss C1 (PalcoScenicoDistorto) | P2 | TODO | Design custom arena con mechanics specifici |
| T048 | Implementare DirettriceEterna.server.lua (C2) | P2 | TODO | Poppy Boss - manipolazione ambiente, fake exits |
| T049 | Creare arena Boss C2 (FabbricaMemorie) | P2 | TODO | Conveyor belts, toxic zones |
| T050 | Implementare ARK-PRIME.server.lua (C3) | P2 | TODO | SCP-079 Boss - controllo sistemi, shutdown doors |
| T051 | Creare arena Boss C3 (DataCenterCollassato) | P2 | TODO | Server racks, electric hazards |
| T052 | Implementare EcoZero.server.lua (C4) | P2 | TODO | Backrooms Boss - reality distortion, no-clip zones |
| T053 | Creare arena Boss C4 (SpazioCessato) | P2 | TODO | Infinite hallways, gravity anomalies |
| T054 | Implementare FrequenzaMadre.server.lua (C5) | P2 | TODO | Analog Horror Boss - broadcast override, vision static |
| T055 | Creare arena Boss C5 (StazioneBroadcast) | P2 | TODO | TV monitors, signal jammers |
| T056 | Testare Release build (30 entità complete) | P2 | TODO | Final quality pass completo |

---

## SPRINT 10 - POLISH & OPTIMIZATION

| ID | Task | Priorità | Stato | Note |
|---|---|---|---|---|
| T057 | Ottimizzare PathfindingService per 30 AI simultanee | P1 | TODO | Chunk-based activation, LOD per distant entities |
| T058 | Implementare audio occlusion system | P1 | TODO | Raycast-based wall muffling |
| T059 | Creare 30 Core Sounds unici (placeholder -> final) | P2 | TODO | Asset sourcing + custom audio mixing |
| T060 | Bilanciamento difficoltà (playtest-driven) | P1 | TODO | Iterazioni basate su feedback giocatori |
| T061 | Mobile optimization pass | P2 | TODO | Performance target: 30 FPS su mid-tier mobile |
| T062 | Accessibility features (colorblind mode, subtitles) | P2 | TODO | Compliance best practices Roblox |

---

## DIPENDENZE CRITICHE

### StateMachine.lua (T004)
- **Tutti i task T006-T056 dipendono da questo**
- Deve supportare: IDLE, PATROL, ALERT, CHASE, ATTACK, RESET, SPECIAL (custom per boss)
- API: `StateMachine.new(entity, params)`, `:TransitionTo(newState)`, `:OnStateEnter/Exit()`

### GameManager.lua (T010)
- **Gestisce spawn dinamico delle 30 entità**
- Parametri: path player (5 paths), tier difficoltà, session seed
- Spawn pool: seleziona subset entità per path specifico

### Entity Roster Reference
- **File source**: ENTITIES_FULL_ROSTER_v3.md
- Ogni implementazione T019-T056 deve rispettare parametri definiti nel roster

---

## NOTE IMPLEMENTAZIONE

1. **Priorità sviluppo**: VS-CORE (T019-T024) → Alpha P1 (T025-T033) → Beta P2 (T034-T045) → Boss (T046-T056)
2. **Testing incrementale**: testare ogni sprint prima di procedere al successivo
3. **Modularità**: ogni entità = file separato, eredita da StateMachine base
4. **Performance budget**: max 10 entità attive simultanee in istanza standard (boss fights possono essere 1v1)
5. **Audio cues**: ogni entità deve avere almeno 1 Core Sound distintivo
6. **Versioning**: ogni modifica entità incrementa versione in header commento file

---

**Ultima modifica backlog**: 2026-03-06 | **Versione**: 2.0 | **Entità totali**: 30
