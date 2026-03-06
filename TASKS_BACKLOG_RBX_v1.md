# TASKS_BACKLOG_RBX_v1.md – COSOBOFFO
> Versione: 1.0 | Data: 2026-03-06 | Fase: 3 – ROBLOX TECHNICAL START

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
