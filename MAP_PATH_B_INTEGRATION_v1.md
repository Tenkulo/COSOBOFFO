# MAP_PATH_B_INTEGRATION_v1 – COSOBOFFO

> Integrazione tecnica Path B: "Fabbrica degli Scarti"

## 1. LIGHTING & ATMOS CONFIG (from VISUAL_DESIGN_v1)

| Parametro | Valore |
|---|---|
| **Technology** | Future |
| **Ambient** | 5, 5, 10 |
| **OutdoorAmbient** | 0, 0, 5 |
| **Brightness** | 0.8 |
| **Atmos. Density** | 0.55 |
| **Atmos. Color** | 20, 20, 40 |
| **Atmos. Haze** | 4.0 |
| **FogEnd** | 60 studs |

## 2. ROOM MAPPING (for RoomGraph.lua)

Le stanze della Fabbrica vengono mappate sui tipi tecnici:

| Room ID | Level Design ID | Weight | CanSpawn | IsObjective |
|---|---|---|---|---|
| `B_Entry_01` | `B_Entry_01` | 10 | No | No |
| `B_Conveyor_Belt` | `B_Conveyor_Belt` | 8 | Yes | No |
| `B_Assembly_Line` | `B_Assembly_Line` | 7 | Yes | No |
| `B_Generator_Room` | `B_Generator_Room` | 5 | No | Yes |
| `B_Toy_Storage` | `B_Toy_Storage` | 6 | Yes | No |
| `B_Playcare_Dist` | `B_Playcare_Dist` | 4 | Yes | Yes |
| `B_Exit_Vent` | `B_Exit_Vent` | 0 | No | No (Exit) |

## 3. ENTITY SPAWN LOGIC

*   • **P0 (Scarto Abbandonato)**: Spawn garantito in `B_Playcare_Dist` o `B_Toy_Storage`.
*   • **Mechanic Centrale**: **Stealth Audio**. Se il giocatore corre o salta su superfici metalliche (Nastri), l'entità scatta verso il rumore.
*   • **Behavior**: L'Urlo Sordo può disattivare i generatori riattivati, costringendo il giocatore a tornare indietro.

## 4. LUAU IMPLEMENTATION SNIPPET (RoomGraph.lua)

```lua
-- Inserire in ROOM_TYPES (Path B)
{ id = "B_Entry_01", path = "B", weight = 10, canSpawnEntity = false, isObjective = false },
{ id = "B_Conveyor_Belt", path = "B", weight = 8, canSpawnEntity = true, isObjective = false },
{ id = "B_Assembly_Line", path = "B", weight = 7, canSpawnEntity = true, isObjective = false },
{ id = "B_Generator_Room", path = "B", weight = 5, canSpawnEntity = false, isObjective = true },
{ id = "B_Toy_Storage", path = "B", weight = 6, canSpawnEntity = true, isObjective = false },
{ id = "B_Playcare_Dist", path = "B", weight = 4, canSpawnEntity = true, isObjective = true },
{ id = "B_Exit_Vent", path = "B", weight = 0, canSpawnEntity = false, isObjective = false, isExit = true },
```

## 5. NEXT STEPS

*   1. Aggiornare `RoomGraph.lua` con i nuovi ID Path B.
*   2. Implementare il sistema di Detection Audio in `EntityBehavior.server.lua`.
*   3. Creare i modelli per le stanze in `ServerStorage.Maps.PathB`.
