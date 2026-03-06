# PROJECT_STATE – COSOBOFFO

> File di stato operativo. Da leggere PRIMA di qualsiasi sessione di lavoro. Aggiornare questo file ad ogni fine sessione.

---

## STATO CORRENTE

| Campo | Valore |
|---|---|
| **Fase** | 2 – GAME DESIGN DOCUMENT |
| **Sotto-fase** | GDD v1 + Entities COMPLETI |
| **Concept** | v1 LOCKED (non modificare senza motivo forte) |
| **Lore** | v1 LOCKED (LORE_CORE_ULTIMATE_2026.md) |
| **GDD** | v1 COMPLETO (GAME_GDD_v1.md) |
| **Entita** | Gerarchia fissata + Roster iniziale (ENTITIES_HIERARCHY_AND_LORE_v1.md) |
| **Loot** | Sistema definito (LOOT_DESIGN_ARCHIVIO_v1.md) |
| **Rewards** | Sistema definito (REWARDS_STATUS_DESIGN_v1.md) |
| **Tecnica Roblox** | PROSSIMO FOCUS |
| **Data ultimo aggiornamento** | 2026-03-06 |

---

## DIAGNOSI DI SESSIONE (PER LA PROSSIMA IA)
- **Problemi riscontrati:** GitHub Code Editor ha problemi di focus se si usano comandi `type` massivi. Consigliato usare `form_input` sui ref specifici o digitare a piccoli blocchi.
- **Timeout:** Alcune azioni possono causare disconnessioni momentanee se il testo è troppo lungo. Salvare spesso.
- **Autonomia:** L'utente ha autorizzato il controllo totale; procedere con precisione chirurgica sui file canon.

---

## PROSSIMI PASSI (IN ORDINE)

### STEP 1 – Completare GAME_GDD_v1.md (FATTO)
### STEP 2 – Completare ENTITIES_HIERARCHY_AND_LORE_v1.md (FATTO)

### STEP 3 – Avvio fase tecnica Roblox
- [ ] Struttura cartelle progetto Roblox Studio
- [ ] Architettura ModuleScript AI entita (macchina a stati)
- [ ] Sistema TeleportService + ReservedServer per istanze
- [ ] DataStoreService + ProfileService per gilde e progress
- [ ] Vertical Slice tecnico (1 hub, 1 Story, 1 Chase, 1 entita, loot base, gilda base)

---

## FILE CANON
| File | Stato | Note |
|---|---|---|
| GAME_GDD_v1.md | OK | Design core stabilizzato |
| ENTITIES_HIERARCHY_AND_LORE_v1.md | OK | Gerarchia e Roster definiti |

Ultima modifica: 2026-03-06 | Sessione: doc_update
