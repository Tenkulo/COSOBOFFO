# TECH_DESIGN_RBX_v2.0 – COSOBOFFO
> Versione: 2.0 | Stato: LOCKED | Data: 2026-03-08

## 1. STRUTTURA FILE REALE (Roblox Studio 2026)
L'organizzazione segue il pattern "Service-Oriented Architecture" (SOA) per garantire modularità e scalabilità cross-platform.

```
Game
├── ServerScriptService (Scripts con RunContext=Server)
│   ├── Core
│   │   ├── SetupRemotes.server.lua        -- Priority 1: Inizializzazione Remotes
│   │   ├── MapLoader.server.lua           -- Priority 2: Caricamento PATH
│   │   ├── EntitySpawner.server.lua       -- Priority 3: Spawn basato su RoomGraph
│   │   ├── GameManager.server.lua         -- Priority 4: Orchestratore sessione (LOBBY->RUN)
│   │   └── InteractionSystem.server.lua   -- Gestione obiettivi e trigger
│   ├── Entities
│   │   ├── CorrettoreMeccanico.server.lua -- AI Template (Look-away)
│   │   └── Silenziatore.server.lua        -- AI Stealth (Sound-based)
│   └── Systems
│       └── DataService.server.lua         -- Persistenza ProfileService
├── ReplicatedStorage
│   ├── Modules (ModuleScripts)
│   │   ├── Shared
│   │   │   ├── StateMachine.lua           -- State machine generica AI
│   │   │   ├── RoomGraph.lua              -- Proc gen stanze PATH A-E
│   │   │   ├── LootTable.lua              -- Sistema loot ARPG-soft
│   │   │   └── GuildLoadout.lua           -- Ruoli gilda e perks
│   │   └── Client
│   │       ├── SoundManager.lua           -- Audio 3D e Heartbeat visual
│   │       └── CinematicController.lua    -- TweenService cutscenes
│   └── Remotes (Folder generata via script)
│       ├── SprintStarted / SprintEnded
│       ├── StaminaUpdate
│       ├── NoiseEmitted
│       ├── EntityChaseStart
│       └── ObjectiveUpdate / ExtractionReady
├── StarterPlayerScripts
│   └── Client
│       ├── PlayerController.client.lua    -- Input, Sprint, Stamina logic
│       ├── HUD.client.lua                 -- UI dinamica, Vignettatura
│       └── SoundManager.client.lua        -- Wrapper locale SoundManager
└── ServerStorage
    ├── Maps (Stanze PATH A-E)
    └── Entities (Modelli placeholder/finali)
```

## 2. ARCHITETTURA COMUNICAZIONE
La comunicazione tra Client e Server è mediata da un sistema centralizzato per evitare circular dependencies.

- **Remotes**: Tutti i RemoteEvent sono raggruppati in `ReplicatedStorage.Remotes`. Creati dinamicamente all'avvio da `SetupRemotes.server.lua`.
- **_G Pattern**: Utilizzato nel prototipo per accesso rapido ai moduli core (es. `_G.GameManager`). Da sostituire con Lazy-loading ModuleScripts in Beta.
- **Attributes**: Utilizzati su `ObjectiveTrigger` per definire tipo obiettivo e stato senza script locali per ogni trigger.

## 3. LOAD ORDER (Init Sequence)
Sequenza obbligatoria per garantire che i sistemi dipendenti trovino i riferimenti necessari:
1. **SetupRemotes**: Crea la cartella Remotes e gli eventi.
2. **MapLoader**: Genera la mappa via `RoomGraph`.
3. **EntitySpawner**: Piazza le entità negli slot della mappa caricata.
4. **GameManager**: Inizia il loop di gioco e attiva i sistemi di interazione.

## 4. PATTERN TECNICI OBBLIGATORI
- **Luau Strict Mode**: Obbligatorio `--!strict` su ogni file. Uso estensivo di `type` per definire interfacce (es. `type EntityConfig`).
- **Table-driven Design**: I bilanciamenti (stamina, speed) sono contenuti in tabelle `CONFIG` all'inizio dei moduli.
- **Functional UI**: HUD generata via codice o `Roact/Fusion` (opzionale) per scalabilità mobile.
- **TweenService**: Unico metodo autorizzato per transizioni visuali (Heartbeat, Vignette).

## 5. GESTIONE ENTITÀ (State Machine)
Tutte le entità ereditano da `StateMachine.lua`. Stati supportati:
`IDLE` (Patrol) -> `ALERT` (Investigate) -> `CHASE` (Pursue) -> `ATTACK` (Interaction).
- **Correttore**: Meccanica Look-away (congelato se in campo visivo).
- **Silenziatore**: Meccanica Noise-based (immune al look-away, aggro su NoiseEmitted).

## 6. INTEGRAZIONE LORE (Diegetica)
Ogni scelta tecnica rispecchia l'Archivio:
- **Proc Gen**: Le stanze non sono caricate, sono "Ricorrenze" manifestate dall'Archivio.
- **Stamina**: L'aria nell'Archivio è "pesante", limitando le capacità atletiche dei Ricorrenti.
- **Remotes**: Rappresentano le "connessioni neurali" tra i Ricorrenti e il Nucleo dell'Archivio.
