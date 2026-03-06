# TECH_DESIGN_RBX_v1.md – COSOBOFFO
> Versione: 1.0 | Stato: DRAFT | Data: 2026-03-06

## 1. STRUTTURA ROBLOX STUDIO

```
Game
├── ServerScriptService/
│   ├── Core/
│   │   ├── GameManager.server.lua      -- orchestratore sessione
│   │   └── InstanceManager.server.lua  -- spawn/despawn istanze
│   └── Entities/
│       └── CorrettoreMeccanico.server.lua
├── ReplicatedStorage/
│   ├── Modules/
│   │   ├── StateMachine.lua            -- AI state machine generica
│   │   ├── LootTable.lua               -- sistema loot
│   │   └── GuildData.lua               -- dati gilda (struttura)
│   └── Remotes/
│       ├── EntityAlert     (RemoteEvent)
│       ├── LootCollected   (RemoteEvent)
│       └── ExtractionReady (RemoteEvent)
├── StarterPlayerScripts/
│   └── Client/
│       ├── HUD.client.lua              -- barra status, obiettivi
│       └── SoundManager.client.lua     -- audio spaziale 3D
├── ServerStorage/
│   └── Maps/
│       └── PizzeriaDistorta/           -- modello istanza VS
└── SoundService/
    └── (audio globali hub)
```

## 2. CONVENZIONI NAMING
- Script server: `NomeModulo.server.lua`
- Script client: `NomeModulo.client.lua`
- ModuleScript condivisi: `NomeModulo.lua` (PascalCase)
- Cartelle: PascalCase, nessuno spazio
- RemoteEvents: verbo+oggetto in PascalCase (es. `LootCollected`)
- Modelli mappa: nome istanza in PascalCase dentro `ServerStorage/Maps/`

## 3. ARCHITETTURA AI ENTITA (State Machine)

Ogni entità usa `StateMachine.lua` con questi stati base:

```
IDLE -> PATROL -> ALERT -> CHASE -> ATTACK -> RESET
```

Parametri per entità (table Luau):
```lua
{
  name         = "CorrettoreMeccanico",
  tier         = "Correttore",      -- gerarchia lore
  moveSpeed    = 12,                -- studs/sec in CHASE
  patrolSpeed  = 4,
  detectionRange = 30,              -- studs, sight
  hearingRange   = 20,              -- studs, suono
  lookAwayImmune = false,           -- true = non bloccabile con look-away
  coreSound      = "rbxassetid://XXXX", -- suono unico entità
  attackCooldown = 3,               -- secondi tra attacchi
}
```

## 4. FLUSSO DI SESSIONE (SERVER)

```
1. Giocatori entrano Hub (Place principale)
2. Leader avvia istanza -> InstanceManager crea ReservedServer
3. TeleportService:TeleportToPrivateServer() per il party
4. Dentro istanza: GameManager gestisce obiettivi + spawn entità
5. Extraction: giocatori raggiungono ExtractionPoint
6. Fine istanza: dati loot -> DataStore -> ritorno Hub
```

## 5. SISTEMI PRIORITARI PER VERTICAL SLICE

| Sistema | File | Stato |
|---|---|---|
| State Machine AI | ReplicatedStorage/Modules/StateMachine.lua | TODO |
| Correttore Meccanico AI | ServerScriptService/Entities/CorrettoreMeccanico.server.lua | TODO |
| GameManager istanza | ServerScriptService/Core/GameManager.server.lua | TODO |
| HUD base | StarterPlayerScripts/Client/HUD.client.lua | TODO |
| LootTable | ReplicatedStorage/Modules/LootTable.lua | TODO |
| Mappa PizzeriaDistorta | ServerStorage/Maps/PizzeriaDistorta | TODO |

## 6. NOTE TECNICHE
- Engine: Roblox Studio 2026, Luau strict mode consigliato
- Max giocatori per istanza: 6 (co-op gilda)
- DataStore: ProfileService (open source) per persistenza
- Audio: SoundService con RolloffModel = Linear, MaxDistance = 40 studs
- Mobile: UI scalata con UDim2 relative, niente pixel fissi
