# GAMEPLAY IMPLEMENTED – COSOBOFFO
**Data implementazione**: 2026-03-08
**Fase**: 3 – PROTOTYPE GAMEPLAY
**Versione**: 1.1

---

## STATO IMPLEMENTAZIONE

Implementate **7 aree critiche** (P0 + P1) identificate per la Vertical Slice:

1. **Randomness alta**: proc gen stanze PATH A-E (RoomGraph.lua)
2. **Mobilità completa**: sprint, stamina, jump (PlayerController.server.lua)
3. **Audio/Visual atmosferici**: HUD, vignettatura, SoundManager (3D heartbeat)
4. **Perks/Classi gilda**: 4 ruoli e perk tree (GuildLoadout.lua)
5. **AI Entità Avanzata**: 3 pattern distinti (Meccanico, Silenziatore, Osservatore)
6. **Orchestrazione Sessione**: GameManager ed EntitySpawner completi
7. **Onboarding**: TutorialMode diegetico integrato

---

## FILE IMPLEMENTATI

### src/shared/ – Moduli condivisi
| File | Descrizione | Status |
|------|-------------|--------|
| **RoomGraph.lua** | Proc gen grafo stanze PATH A-E con seed anti-ripetizione | ✅ Completo |
| **LootTable.lua** | Sistema loot Common/Rare/Epic/Narrativo con affissi | ✅ Completo |
| **GuildLoadout.lua** | Ruoli gilda, perks sbloccabili, run modifiers | ✅ Completo |
| **StateMachine.lua** | State machine generica AI (IDLE→PATROL→ALERT→CHASE→ATTACK) | ✅ Completo |

### src/server/ – Server-side gameplay
| File | Descrizione | Status |
|------|-------------|--------|
| **PlayerController.server.lua** | Sprint (Shift), stamina drain/regen, jump con noise | ✅ Completo |
| **GameManager.server.lua** | Orchestratore sessione (spawn, obiettivi, extraction) | ✅ Completo |
| **EntitySpawner.server.lua** | Spawn entità in slot RoomGraph, waypoints | ✅ Completo |
| **MapLoader.server.lua** | Caricamento asset stanze PATH A | ✅ Completo |
| **entities/CorrettoreMeccanico.lua**| AI Look-away (glitch range) | ✅ Completo |
| **entities/Silenziatore.server.lua** | AI Stealth Audio (aggro su noise) | ✅ Completo |
| **entities/Osservatore.server.lua** | AI Look-away puro (freeze se osservato) | ✅ Completo |

### src/client/ – Client-side UX
| File | Descrizione | Status |
|------|-------------|--------|
| **HUD.client.lua** | Stamina bar, obiettivi, vignettatura, feedback | ✅ Completo |
| **SoundManager.client.lua** | Audio 3D proximity, heartbeat dinamico | ✅ Completo |
| **TutorialMode.client.lua** | Onboarding diegetico (messaggi a schermo) | ✅ Completo |
| **CinematicController.lua** | Controller cutscene con TweenService | ✅ Completo |

---

## PROSSIMI PASSI TECNICI

### P1 – Completamento Vertical Slice (Integrazione Finale)
- [x] **GameManager.server.lua**: orchestratore sessione
- [x] **EntitySpawner.server.lua**: gestione spawn
- [x] **SoundManager.client.lua**: audio immersivo
- [x] **Silenziatore.server.lua**: AI stealth audio
- [x] **Osservatore.server.lua**: AI look-away puro
- [x] **TutorialMode.client.lua**: onboarding
- [ ] **Mappa PATH A**: PizzeriaDistorta - Setup definitivo waypoints in ServerStorage
- [ ] **ExtractionPoint**: Trigger finale per chiusura run

### P2 – Integrazione e Test (entro 2026-03-15)
- [ ] Setup ReplicatedStorage/Remotes (folder fisica in Studio)
- [ ] Test locale multiplayer (2 player, 1 run PATH A)
- [ ] Balance tuning (stamina, speed, spawn rate)

---
**Fine documento**
Per riprendere: completare asset Mappa PATH A e ExtractionPoint.
