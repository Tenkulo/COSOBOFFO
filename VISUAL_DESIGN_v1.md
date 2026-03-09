# VISUAL_DESIGN_v1.md - COSOBOFFO
> Versione: 1.0 | Stato: DRAFT | Data: 2026-03-09

## 1. LIGHTING CONFIG PER PATH
Specifiche tecniche per il renderer **Roblox Future is Bright (V3)**. Target 80% Mobile.

| Parametro | PATH A (FNaF) | PATH B (Poppy) | PATH C (SCP) | PATH D (Backrooms) | PATH E (Analog) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Technology** | Future | Future | Future | ShadowMap | Future |
| **Ambient** | 20, 10, 5 | 5, 5, 10 | 15, 20, 25 | 40, 40, 30 | 10, 0, 15 |
| **OutdoorAmbient** | 10, 5, 0 | 0, 0, 5 | 10, 10, 15 | 30, 30, 20 | 5, 0, 10 |
| **Brightness** | 1.2 | 0.8 | 2.5 | 3.0 | 0.5 |
| **Atmos. Density** | 0.35 | 0.55 | 0.20 | 0.15 | 0.65 |
| **Atmos. Color** | 120, 60, 20 | 20, 20, 40 | 180, 200, 220 | 240, 230, 180 | 100, 50, 150 |
| **Atmos. Haze** | 2.5 | 4.0 | 0.5 | 1.2 | 10.0 |
| **Sat. (ColorCorr)** | -0.2 | -0.5 | 0.1 | 0.4 | -0.8 |
| **Tint (ColorCorr)** | 255, 200, 150 | 180, 200, 255 | 220, 235, 255 | 255, 250, 200 | 200, 180, 255 |
| **FogEnd** | 120 studs | 60 studs | 250 studs | Infinite | 40 studs |
| **FogColor** | 40, 20, 5 | 5, 5, 15 | 100, 110, 120 | 200, 190, 140 | 30, 10, 40 |

---

## 2. POSTPROCESSING PRESETS
Gestione dinamica dei filtri visivi tramite `TweenService`.

```lua
local VISUAL_CONFIG = {
    Presets = {
        Normal = {
            Bloom = {Intensity = 0.5, Size = 24, Threshold = 2},
            ColorCorr = {Saturation = 0, Contrast = 0, Brightness = 0},
            DOF = {FarRegionStart = 60, FarRegionEnd = 150, FocusDistance = 20}
        },
        Chase = {
            Bloom = {Intensity = 2.5, Size = 56, Threshold = 0.5},
            ColorCorr = {Saturation = -0.4, Contrast = 0.5, Brightness = -0.1},
            DOF = {FarRegionStart = 10, FarRegionEnd = 40, FocusDistance = 5}
        },
        Critical = {
            Bloom = {Intensity = 5.0, Size = 120, Threshold = 0},
            ColorCorr = {Saturation = -1.0, Contrast = 1.0, Brightness = 0.2},
            DOF = {FarRegionStart = 0, FarRegionEnd = 15, FocusDistance = 2}
        }
    }
}
```

---

## 3. ENTITY VISUAL SPECS (VS-CORE)
Specifiche per garantire leggibilità e terrore su schermi piccoli.

| Entità | Colori (Primary/Sec) | Altezza | Materiale | Caratteristica Unica | Silhouette (20st) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Silenziatore** | Black / White (Eyes) | 9.5 studs | ForceField | Corpo allungato, no volto | Sì (Outlined 2px) |
| **Correttore Mecc.** | Rust / Neon Orange | 7.0 studs | Metal / Neon | Occhi LED pulsanti 1Hz | Sì (Glow Neon) |
| **L'Archiviato** | Concrete / Blue | 6.5 studs | Concrete / Foil | Numero IDARK inciso Neon | Sì (Emission ID) |
| **Scarto Abband.** | Plastic Red / Yellow | 12.0 studs | SmoothPlastic | Arti estensibili a molla | Sì (Dimensione) |
| **Eco Liminale** | Sand / Transparent | 6.0 studs | Glass | Silhouette sfocata Blur | No (Ghosting FX) |
| **Osservatore** | Dark Grey / Grey | 5.5 studs | Fabric | Scompare se guardato | Sì (Solo al buio) |

**Garantire Silhouette:** Uso di `Highlight` object con `OutlineTransparency = 0.5` per i Correttori in CHASE.

---

## 4. HUD VISUAL LANGUAGE
Mobile-first UI. Elementi interattivi minimi 44x44px equivalenti.

- **Font Narrativo:** `Special Elite` (Typewriter style)
- **Font Numerico:** `JetBrains Mono` (High legibility)
- **Font Alert:** `Luckiest Guy` (Distorted for chase)

**Layout (ASCII):**
```
[OBJ: 0/3]                      [GUILD_LOG]
(TOP LEFT)                      (TOP RIGHT)

        [VIGNETTE CHASE FX]

(BOT LEFT)                      (BOT RIGHT)
[HP/STAMINA]                    [INVENTORY/E]
```

- **Palette:** 
  - Main: RGB(255, 255, 255) | Opacity 0.9
  - Alert: RGB(200, 0, 0) | Opacity 1.0
  - Archive Blue: RGB(0, 180, 255)
- **Corner:** `8px` | **Stroke:** `2px` | **Opacity:** `0.8`

---

## 5. COSMETICS STYLE GUIDE
1. **Integrazione Diegetica:** L'oggetto deve sembrare parte dell'Archivio.
2. **Effetti non-invasivi:** Particle limitati per non ostacolare la vista in Chase.
3. **Silhouette Alteration:** I cosmetici devono cambiare la forma del giocatore (Maschere).

| Rarità | Colore Dominante | Particle Effect | Esempio Canon |
| :--- | :--- | :--- | :--- |
| **Common** | White | None | Badge Ricorrente Base |
| **Rare** | Blue | Subtle Static | Maschera del Tecnico |
| **Epic** | Purple | Glitch Fragments | Mantello dell'Echi |
| **Archive** | Gold | Golden Embers | Corona dell'Archivista |

---

## 6. PARTICLE BUDGET (Mobile Optimized)
Limite: Max 12 emitter attivi contemporaneamente per stanza su Mobile.

| Path | Contesto | Texture | Rate | Speed | LightEm. | Max Em./Room |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **A** | Polvere Ristorante | Dust | 5 | 0.5 | 0 | 4 |
| **B** | Scintille Fabbrica | Spark | 15 | 10 | 1 | 2 |
| **C** | Gas Contenimento | Smoke | 10 | 2 | 0 | 3 |
| **D** | Liminal Dust | Speckle | 3 | 0.2 | 0.5 | 2 |
| **E** | VHS Noise | Static | 50 | 0 | 0.8 | 1 |

---

## 7. PATH-SPECIFIC EFFECTS
- **PATH D (Backrooms):** 
  - `Lighting.Brightness` dinamico (flicker random 0.1s - 0.5s).
  - `BlurEffect` intensità 2 costante per senso di instabilità.
- **PATH E (Analog):**
  - Overlay ScreenGui con texture `Scanlines` (Transparency 0.92).
  - SurfaceGui su tutti i monitor con `VideoFrame` (Static/Glitch) e `ColorCorrection` viola.
  - Script locale per "Glitch Lighting" che inverte i colori per 0.1s durante i jump-scare dell'Analog.
