# PROJECT_STATE – COSOBOFFO

> File di stato operativo. Da leggere PRIMA di qualsiasi sessione di lavoro.
> Aggiornare questo file ad ogni fine sessione.

---

## STATO CORRENTE

| Campo | Valore |
|---|---|
| **Fase** | 2 – GAME DESIGN DOCUMENT |
| **Sotto-fase** | GDD v1 + Entities + Tecnica Roblox |
| **Concept** | v1 LOCKED (non modificare senza motivo forte) |
| **Lore** | v1 LOCKED (LORE_CORE_ULTIMATE_2026.md) |
| **GDD** | v1 IN CORSO (GAME_GDD_v1.md) |
| **Entita** | 4 icone definite, gerarchia fissata, da espandere |
| **Loot** | Sistema definito (LOOT_DESIGN_ARCHIVIO_v1.md) |
| **Rewards** | Sistema definito (REWARDS_STATUS_DESIGN_v1.md) |
| **Tecnica Roblox** | DA INIZIARE |
| **Data ultimo aggiornamento** | 2026-03-06 |

---

## DECISIONI GIA PRESE (NON RIAPRIRE)

- Titolo interno: **Horror Guild Runs: L'Archivio dei Ricorrenti**
- Piattaforma: Roblox (PC + Mobile)
- Target: 13-24, fan horror Roblox (Doors, The Mimic, Apeirophobia, Rooms, Forgotten Memories, Dead Silence)
- Gilde: max **67 membri** (giustificato in lore: soglia di coerenza dell'Archivio)
- Istanze: **Story / Chase / Custom** (1-8 giocatori)
- Difficolta: **Easy / Normal / Hard / Custom**
- Durata run target: **10-20 minuti**
- Modello competizione: **social co-opetition** (non PvP diretto)
- Monetizzazione: **fair, solo cosmetici**, no pay-to-win
- Loot: sistema stile ARPG soft (**Frammenti dell'Archivio**)
- Entita: **extradimensionali corrotte dall'Archivio**, non create da esso
- Entita lottano anche loro per risolvere il mistero
- Gerarchia entita: Nucleo / Custodi / Correttori / Echi / Scarti / Avatar di Gilda
- Personaggi chiave: **L'Archivista** (NPC guida) + **Il Correttore Scisso** (antagonista)
- Archi narrativi: **5 archi** (Ingresso / Regole Nascoste / Fratture / Guerra Interpretazioni / L'Archivio Risponde)
- Hook centrale: "Ogni volta che entri, l'Archivio cambia. Ma ricorda tutto quello che tu cerchi di dimenticare."
- Regola aurea lore: ogni sistema/entita deve avere giustificazione narrativa
- Entita uniche: NO 2 entita simili, ognuna da universo diverso, tipo di paura diverso

---

## PROSSIMI PASSI (IN ORDINE)

### STEP 1 – Completare GAME_GDD_v1.md
- [x] Panoramica + Pitch
- [x] Hub (layout, zone, flussi)
- [x] Tipi di istanze (Story/Chase/Custom)
- [x] Difficolta (Easy/Normal/Hard/Custom)
- [ ] Gilde (struttura completa, dottrine, Relitti di Nodo)
- [ ] Loot & Progressione (integrazione movimento/parkour)
- [ ] Rewards & Status (titoli, badge, highlights)
- [ ] Live-ops & Seasons (cadenza, eventi, roadmap)

### STEP 2 – Completare ENTITIES_HIERARCHY_AND_LORE_v1.md
- [x] Gerarchia (6 livelli)
- [x] 4 entita icona con background extradimensionale
- [ ] Visual guide completa per ogni entita
- [ ] Espandere roster (almeno 8-10 entita base per il vertical slice)
- [ ] Collegare ogni entita a loot Iconici/Unici e titoli specifici

### STEP 3 – Avvio fase tecnica Roblox
- [ ] Struttura cartelle progetto Roblox Studio
- [ ] Architettura ModuleScript AI entita (macchina a stati)
- [ ] Sistema TeleportService + ReservedServer per istanze
- [ ] DataStoreService + ProfileService per gilde e progress
- [ ] Vertical Slice tecnico (1 hub, 1 Story, 1 Chase, 1 entita, loot base, gilda base)

### STEP 4 – Asset List
- [ ] Lista asset necessari (modelli, suoni, VFX, UI)
- [ ] Priorita per Vertical Slice vs post-VS

---

## RISCHI E BLOCCHI

| Rischio | Livello | Mitigazione |
|---|---|---|
| Complessita gilde + istanze + stagioni | ALTO | Implementare MVP gilde prima, espandere dopo |
| Retention senza live-ops attivi | MEDIO | Pianificare calendario micro-update da subito |
| Bilanciamento loot (non troppo grind, non troppo facile) | MEDIO | Playtesting frequente da early access |
| Entita troppo simili tra loro | ALTO | Regola dura: 0 sovrapposizioni di pattern/silhouette/paura |
| Pay-to-win percepito | BASSO | Regola fissa: affissi funzionali solo in-game |
| Performance su device low-end | MEDIO | Target 60FPS, ottimizzazione parte del VS |

---

## VINCOLI TECNICI FISSI

- Luau (non Lua 5.1 puro): usare task.wait(), task.spawn(), ecc.
- TeleportService per istanze: sempre con party preservato
- DataStore: throttle limits Roblox (max 60 req/min per gioco)
- Parti fisiche: minimizzare, usare MeshPart/SpecialMesh
- Script lato server per logica entita/loot (mai client-side trusted)
- ModuleScript per sistemi riutilizzabili (AI, loot, gilde)
- Sound: SoundService + localizzazione 3D per entita
- Lighting: Future/ShadowMap con Atmosphere per horror

---

## FILE CANON (NON MODIFICARE SENZA NOTA)

| File | Stato | Note |
|---|---|---|
| LORE_CORE_ULTIMATE_2026.md | LOCKED v1 | Modificare solo con archi nuovi, mai retcon |
| REQUIREMENTS_ULTIMATE_2026.md | LOCKED v1 | Aggiornare solo per nuove feature macro |
| GAME_GDD_v1.md | IN CORSO | Completare step 1 |
| ENTITIES_HIERARCHY_AND_LORE_v1.md | IN CORSO | Completare step 2 |
| LOOT_DESIGN_ARCHIVIO_v1.md | COMPLETO | Revisione dopo playtesting |
| REWARDS_STATUS_DESIGN_v1.md | COMPLETO | Revisione dopo playtesting |

---

## COME RIPRENDERE UNA SESSIONE

```
1. Leggi questo file (PROJECT_STATE.md)
2. Leggi LORE_CORE_ULTIMATE_2026.md
3. Leggi GAME_GDD_v1.md (sezione piu recente)
4. Controlla PROSSIMI PASSI qui sopra
5. Prosegui dallo step NON completato
6. Aggiorna questo file a fine sessione
```

---

*Ultima modifica: 2026-03-06 | Sessione: init*
