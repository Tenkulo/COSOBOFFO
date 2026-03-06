# 🎬 CINEMATIC SYSTEM v1 — Tech Specs
**Roblox Studio Implementation Guide**

---

## 🛠 CORE TECH: TweenService Camera

Il sistema utilizza `TweenService` per gestire tutte le transizioni di camera non-giocabili.

### **1. CAMERA MODULE (Client Side)**
Tutte le cinematiche sono gestite lato client per fluidità massima (60 FPS).

```lua
-- File: StarterPlayerScripts/Modules/CinematicCamera.lua
local TweenService = game:GetService("TweenService")
local Camera = workspace.CurrentCamera

local CinematicCamera = {}

function CinematicCamera.Play(points, duration, easingStyle)
    Camera.CameraType = Enum.CameraType.Scriptable
    
    for _, point in ipairs(points) do
        local tween = TweenService:Create(Camera, 
            TweenInfo.new(duration, easingStyle or Enum.EasingStyle.Cubic), 
            {CFrame = point.CFrame}
        )
        tween:Play()
        tween.Completed:Wait()
    end
    
    Camera.CameraType = Enum.CameraType.Custom
end

return CinematicCamera
```

---

## 🎭 TIPOLOGIE DI INQUADRATURE (Regia 2026)

### **A. TRANSITION POV (First -> Cinematic)**
- **Uso**: Quando il giocatore incontra un'entità chiave o un oggetto di lore.
- **Tech**: `TweenService` sposta la camera dal `Head` del giocatore a un'inquadratura esterna predefinita.

### **B. THE "DREAD" ZOOM**
- **Uso**: Chase intro o reveal di un'anomalia.
- **Tech**: Modifica contemporanea di `FieldOfView` (FOV) e `CFrame` per un effetto "Vertigo" soft.

### **C. AERIAL LORE SWEEP**
- **Uso**: Reveal di una nuova stanza o area dell'Archivio.
- **Tech**: Camera segue un percorso di `Bezier Curves` per movimenti curvi e organici.

---

## 🎞️ SKIP SYSTEM (User Experience)

Fondamentale per i trend 2026: **rispetto del tempo del giocatore.**

### **Implementazione Skip UI**
- **Visibilità**: Appare solo dopo 1.5 secondi dall'inizio della cutscene.
- **Input**: `Tasto ESC` (PC), `Hold Touch` (Mobile), `B Button` (Console).
- **Feedback**: summary veloce ("L'Archivista ti ha dato il primo frammento") dopo lo skip.

---

## 💡 VISUAL EFFECTS (VFX) INTEGRATI

### **Glitch Overlay**
- **Trigger**: Vicinanza a Entità "Echo" o durante scene di Rollback.
- **Tech**: `ColorCorrectionEffect` + `BloomEffect` + `BlurEffect` (modificati via script).

### **Cinematic Letterboxing**
- **Tech**: UI ScreenGui con due barre nere (Top/Bottom) che si animano all'inizio della scena.

---

## 📅 ROADMAP IMPLEMENTAZIONE

1. **Sprint 1**: Setup `CinematicCamera` module base.
2. **Sprint 2**: Implementazione `TransitionPOV` per intro run.
3. **Sprint 3**: Creazione UI Skip e Summary system.
4. **Sprint 4**: Integrazione VFX Glitch con cutscenes.

---

**Status**: v1 — Technical Design pronto per codifica.
**Ultima modifica**: 2026-03-06 | Comet AI
