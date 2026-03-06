# ROBLOX_STUDIO_SETUP_GUIDE.md - COSOBOFFO

> Versione: 1.0 | Data: 2026-03-06 | Fase: 3 - ROBLOX TECHNICAL START
> Guida step-by-step per configurare Roblox Studio per il progetto COSOBOFFO.

---

## PREREQUISITI

- Roblox Studio installato (versione recente)
- Account Roblox attivo (Tenkulo)
- File di riferimento: TECH_DESIGN_RBX_v1.md (architettura tecnica)
- File di riferimento: ENTITIES_FULL_ROSTER_v3.md (30 entita)

---

## T001 - CREARE IL PLACE PRINCIPALE (HUB)

### Passi:
1. Apri Roblox Studio
2. Crea **New Experience** > Seleziona template **Flat Terrain**
3. Nome experience: `COSOBOFFO`
4. Vai a **File > Game Settings**:
   - Name: `COSOBOFFO`
   - Description: `Il Ricorrente deve sopravvivere all'Archivio dei Ricorrenti.`
   - Genre: `Horror`
   - Max Players: `6`
5. Pubblica con **File > Publish to Roblox**
6. **IMPORTANTE**: Salva il `Place ID` numerico in PROJECT_STATE.md

### Place Hub - Layout Iniziale:
- Dimensioni workspace: 512 x 512 studs
- Baseplate: mantieni per testing, rimuovi per release
- Lighting: `Technology = Future`, `Brightness = 0.5`, `Ambient = (0,0,0)`
- Atmosphere: `Density = 0.5`, `Offset = 0.25`, `Color = grey`

---

## T002 - STRUTTURA CARTELLE EXPLORER

Crea le seguenti cartelle esattamente come indicato (case-sensitive):

```
Workspace
  Entities/           -- NPC entities folder
  Maps/              -- Map instances
  ExtractionPoints/  -- Exit trigger points
  SpawnPoints/       -- Player spawn locations

ServerScriptService
  GameManager.server.lua     (T010)
  InstanceManager.server.lua  (T012)
  EntitySpawner.server.lua
  LootSystem.server.lua       (T016)
  DataManager.server.lua      (T017)

ReplicatedStorage
  Remotes/                   -- RemoteEvents folder (T003)
  Modules/
    StateMachine.lua          (T004) -- CRITICO
    LootTable.lua
    EntityParams.lua          -- Parametri 30 entita
  Assets/
    Sounds/                  -- Core Sounds entita
    UI/                      -- UI assets

StarterPlayer
  StarterPlayerScripts/
    SoundManager.client.lua   (T014)
    HUD.client.lua            (T013)

SoundService
  BackgroundAmbient
  EntitySounds/
```

### Come creare le cartelle in Studio:
1. Tasto destro su `Workspace` > **Insert Object** > `Folder`
2. Rinomina la cartella come indicato sopra
3. Ripeti per ogni cartella nel loro parent corretto

---

## T003 - REMOTEEVENTS IN REPLICATEDSTORAGE

Naviga su `ReplicatedStorage > Remotes` e crea i seguenti RemoteEvents:

| Nome | Tipo | Direzione | Uso |
|---|---|---|---|
| `EntityAlert` | RemoteEvent | Server -> Client | Notifica HUD allerta entita |
| `EntityChase` | RemoteEvent | Server -> Client | Chase state attivo |
| `LootCollected` | RemoteEvent | Server -> Client | Item raccolto da giocatore |
| `ExtractionReady` | RemoteEvent | Client -> Server | Attiva estrazione |
| `ExtractionComplete` | RemoteEvent | Server -> Client | Sessione completata |
| `SessionStart` | RemoteEvent | Server -> Client | Inizio sessione |
| `PlayerDead` | RemoteEvent | Server -> Client | Giocatore catturato |
| `HUDUpdate` | RemoteEvent | Server -> Client | Aggiorna dati HUD |

### Come creare i RemoteEvents:
1. Tasto destro su `ReplicatedStorage/Remotes/` > **Insert Object** > `RemoteEvent`
2. Rinomina con il nome esatto dalla tabella sopra
3. Ripeti per tutti gli 8 RemoteEvents

---

## T004 - STATEMACHINE.LUA (MODULO CRITICO)

Naviga su `ReplicatedStorage/Modules/` e crea un `ModuleScript` chiamato `StateMachine`.

### Codice StateMachine.lua:

```lua
-- StateMachine.lua
-- COSOBOFFO - Modulo AI generico per tutte le 30 entita
-- Versione: 1.0 | Data: 2026-03-06

local StateMachine = {}
StateMachine.__index = StateMachine

-- Stati validi
StateMachine.States = {
  IDLE = "IDLE",
  PATROL = "PATROL",
  ALERT = "ALERT",
  CHASE = "CHASE",
  ATTACK = "ATTACK",
  RESET = "RESET",
  SPECIAL = "SPECIAL"  -- Per meccaniche custom (boss)
}

-- Crea nuova istanza StateMachine
function StateMachine.new(entity, params)
  local self = setmetatable({}, StateMachine)
  self.entity = entity
  self.params = params or {}
  self.currentState = StateMachine.States.IDLE
  self.previousState = nil
  self.stateCallbacks = {}
  self.isRunning = false
  self.stateTimer = 0
  return self
end

-- Registra callback per uno stato
function StateMachine:OnStateEnter(state, callback)
  if not self.stateCallbacks[state] then
    self.stateCallbacks[state] = {}
  end
  self.stateCallbacks[state].enter = callback
end

function StateMachine:OnStateExit(state, callback)
  if not self.stateCallbacks[state] then
    self.stateCallbacks[state] = {}
  end
  self.stateCallbacks[state].exit = callback
end

function StateMachine:OnStateUpdate(state, callback)
  if not self.stateCallbacks[state] then
    self.stateCallbacks[state] = {}
  end
  self.stateCallbacks[state].update = callback
end

-- Transizione a nuovo stato
function StateMachine:TransitionTo(newState)
  if newState == self.currentState then return end

  -- Esegui exit callback stato corrente
  if self.stateCallbacks[self.currentState] and
     self.stateCallbacks[self.currentState].exit then
    self.stateCallbacks[self.currentState].exit(self.entity)
  end

  self.previousState = self.currentState
  self.currentState = newState
  self.stateTimer = 0

  -- Esegui enter callback nuovo stato
  if self.stateCallbacks[newState] and
     self.stateCallbacks[newState].enter then
    self.stateCallbacks[newState].enter(self.entity)
  end
end

-- Aggiorna stato corrente (chiamare ogni RunService.Heartbeat)
function StateMachine:Update(dt)
  self.stateTimer = self.stateTimer + dt
  if self.stateCallbacks[self.currentState] and
     self.stateCallbacks[self.currentState].update then
    self.stateCallbacks[self.currentState].update(self.entity, dt, self.stateTimer)
  end
end

-- Ottieni stato corrente
function StateMachine:GetState()
  return self.currentState
end

-- Ottieni stato precedente
function StateMachine:GetPreviousState()
  return self.previousState
end

return StateMachine
```

### Come inserire il codice:
1. Doppio click su `StateMachine` ModuleScript
2. Cancella il testo default
3. Copia e incolla il codice sopra
4. Salva con `Ctrl+S`

---

## T005 - PLACE SECONDARIO: PIZZERIADISTORTA

1. Vai su roblox.com > **Crea** > **Crea Experience**
2. Template: **Indoor** o **Flat Terrain**
3. Nome: `COSOBOFFO - PizzeriaDistorta`
4. Salva Place ID in PROJECT_STATE.md
5. In `InstanceManager.server.lua` (T012): usa questo Place ID per TeleportService

### Layout PizzeriaDistorta:
- Dimensioni: 200 x 200 studs
- Zona ingresso: sala di benvenuto distorta (FNaF-inspired)
- Corridoi: 3 corridoi laterali con porte
- Cucina: area con oggetti loot
- Sala animatronica: zona con palco e spotlight
- ExtractionPoint: porta sul retro
- SpawnPoint: centro della sala

---

## CHECKLIST SETUP COMPLETO

- [ ] T001: Place Hub creato, Place ID salvato
- [ ] T002: Struttura cartelle Explorer completa
- [ ] T003: 8 RemoteEvents creati in Remotes/
- [ ] T004: StateMachine.lua implementato e testato
- [ ] T005: Place PizzeriaDistorta creato, Place ID salvato

---

## PROSSIMI PASSI DOPO SETUP

Dopo aver completato T001-T005, procedere con:

1. **Implementare CorrettoreMeccanico.server.lua** (T006) - Prima entita VS-CORE
2. **Test baseplate**: spawn Correttore su mappa piatta, verificare StateMachine
3. **Seguire TASKS_BACKLOG_RBX_v1.md** per ordine completo implementazione

---

## NOTE IMPORTANTI

- **Salva spesso**: `Ctrl+S` in Studio, poi **File > Publish to Roblox**
- **Test in Play Solo**: `F5` per testare singolo giocatore
- **Team Test**: `F6` per testare multiplayer locale
- **Output panel**: tieni sempre aperto per debug (`View > Output`)
- **Explorer panel**: struttura cartelle (`View > Explorer`)
- **Properties panel**: proprieta oggetti (`View > Properties`)

---

**Ultima modifica**: 2026-03-06 | **Stato**: OPERATIVO | **Autore**: GameDev Architect AI
