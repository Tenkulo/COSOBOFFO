# MAP_PATH_A_INTEGRATION_v1 – COSOBOFFO

> Integrazione tecnica Path A: "Memorie della Pizzeria Distorta"

## 1. LIGHTING & ATMOS CONFIG (from VISUAL_DESIGN_v1)

| Parametro | Valore |
| :--- | :--- |
| **Technology** | Future |
| **Ambient** | 20, 10, 5 |
| **OutdoorAmbient** | 10, 5, 0 |
| **Brightness** | 1.2 |
| **Atmos. Density** | 0.35 |
| **Atmos. Color** | 120, 60, 20 |

## 2. ROOM MAPPING (for RoomGraph.lua)

Le stanze definite nel Level Design vengono mappate sui tipi tecnici:

| Room ID | Level Design ID | Weight | CanSpawn | IsObjective |
| :--- | :--- | :--- | :--- | :--- |
| `entrance_pizzeria` | `A_Entry_01` | 10 | No | No |
| `A_Dining_Hall` | `A_Dining_Hall` | 8 | Yes | No |
| `A_Kitchen_V` | `A_Kitchen_V` | 5 | Yes | Yes |
| `A_PartyRoom` | `A_PartyRoom` | 6 | Yes | No |
| `A_Exit_Nexus` | `A_Exit_Nexus` | 0 | No | No (Exit) |

## 3. ENTITY SPAWN LOGIC

- **P0 (CorrettoreMeccanico)**: Spawn garantito in Room 4 o 5 (se roomCount >= 5).
- **P1 (Silenziatore)**: Chance spawn 20% in `A_Kitchen_V` (Room hazard).
- **Behavior**: Le entità seguono waypoint predefiniti (`PathfindingService`) finché non rilevano un Ricorrente.

## 4. LUAU IMPLEMENTATION SNIPPET (RoomGraph.lua)

```lua
-- Inserire in ROOM_TYPES (Path A)
{ id = "A_Entry_01", path = "A", weight = 10, canSpawnEntity = false, isObjective = false },
{ id = "A_Dining_Hall", path = "A", weight = 8, canSpawnEntity = true, isObjective = false },
{ id = "A_Kitchen_V", path = "A", weight = 5, canSpawnEntity = true, isObjective = true },
{ id = "A_PartyRoom", path = "A", weight = 6, canSpawnEntity = true, isObjective = false },
{ id = "A_Exit_Nexus", path = "A", weight = 0, canSpawnEntity = false, isObjective = false, isExit = true },
```

## 5. NEXT STEPS

1. Aggiornare `RoomGraph.lua` con i nuovi ID.
2. Configurare `MapLoader.server.lua` per leggere i parametri Lighting all'avvio del Path A.
3. Creare i modelli placeholder per le stanze in `ServerStorage.Maps.PathA`.
