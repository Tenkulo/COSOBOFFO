# LEVEL_DESIGN_PATH_A_v1 – COSOBOFFO

> PATH A: "Memorie della Pizzeria Distorta" | Difficoltà: 1/5 (Intro)

## 1. STRUTTURA RUN
- **Stanze totali**: 5–7 per sessione.
- **Biomi**: Pizzeria (80%), Corridoi Archivio (15%), Nexus (5%).
- **Pacing**: Lento -> Chase (Room 3/4) -> Finale.

## 2. POOL STANZE
| Nome Stanza | Tipo | Spawn Rate | Slot Entità |
|-------------|------|------------|-------------|
| `A_Entry_01` | Start | 100% | 0 |
| `A_Dining_Hall` | Loot | 40% | 2 |
| `A_Kitchen_V` | Hazard | 25% | 1 |
| `A_PartyRoom` | Loot/Lore | 30% | 1 |
| `A_Exit_Nexus` | Exit | 100% | 0 |

## 3. FIRST ROOM (Wake up)
- **Nome**: `A_Entry_01` (Il Risveglio nel Fango).
- **Atmosfera**: Buio totale, suono di neon intermittente.
- **Obiettivo**: Trovare "Chiave dell'Archivista" in un cassetto per aprire porta nexus.

## 4. ENTITÀ
- **Principale**: `CorrettoreMeccanico` (Spawn garantito in Room 4).
- **Secondary**: `Silenziatore` (Spawn 20% in Kitchen).
- **Behavior**: Il Correttore segue waypoint predefiniti finché non rileva player.

## 5. PACING RULES
- **Room 1-2**: Solo Loot e Lore. Tensione bassa.
- **Room 3**: Primo trigger sonoro (Silenziatore vicino).
- **Room 4-5**: Chase potenziale con Correttore.
- **Final**: Estrazione rapida se l'obiettivo è completato.

## 6. LOOT DISTRIBUTION
- **Loot Comune**: Nastro Audio (Lore), Foto Famiglia (Lore).
- **Loot Raro**: Ingranaggio Arrugginito (Materiale Gilda).
- **Narrativo**: Diario del Cuoco (Atto I).
