# 📖 STORY MODE DESIGN v1 — COSOBOFFO
**L'Archivio dei Ricorrenti**

---

## 🎯 OBIETTIVO DESIGN

Creare un **sistema di narrazione progressiva** che:
- Immerga il giocatore nella lore attraverso **visual storytelling**
- Utilizzi **scene cinematiche avanzate** (TweenService camera, cutscenes skippabili)
- Integri tecniche di **regia e inquadrature 2026** per massima immersione
- Garantisca **non-frustrazione**: storia fruibile, gratificante, senza blocchi invasivi
- Faccia sentire il giocatore **protagonista della scoperta** dell'Archivio

---

## 📚 STRUTTURA STORY MODE

### **1. PROGRESSIVE STORY PATH**

La storia principale si sviluppa in **5 Atti Narrativi**, sbloccabili progressivamente:

#### **ATTO I: L'INGRESSO**
- **Trigger**: Primo accesso al gioco
- **Obiettivo**: Introduzione a L'Archivio, L'Archivista, primo contatto con Entità
- **Scene cinematiche**:
  - Risveglio nel Limbo dell'Archivio (camera TweenService POV)
  - Prima apparizione dell'Archivista (cutscene skippabile)
  - Tutorial diegetico: L'Archivista spiega Iterazione/Rollback
- **Visual storytelling**: Ambienti corrotti, glitch visivi, prima Anomalia
- **Reward finale**: Titolo "Ricorrente Novizio", Frammento lore: "Origine dell'Archivio"

#### **ATTO II: LA CORRUZIONE**
- **Trigger**: Completamento 10 Runs (qualsiasi difficoltà)
- **Obiettivo**: Scoprire la Corruzione e i Custodi
- **Scene cinematiche**:
  - Incontro con un Custode corrotto (cinematic battle intro)
  - Visione del Nucleo Centrale (camera aerial shot)
  - Dialogo con L'Archivista: "Non sono l'unico prigioniero"
- **Visual storytelling**: Ambienti degradati, simboli extradimensionali, Eco feedback
- **Reward finale**: Maschera "Custode Oscuro", Frammento lore: "I Custodi"

#### **ATTO III: GLI UNIVERSI PERDUTI**
- **Trigger**: Completamento Path Velocità + Path Chase (Hard+)
- **Obiettivo**: Esplorare le origini delle Entità da universi diversi
- **Scene cinematiche**:
  - Flashback universo di Rush (Doors-style dimension)
  - Flashback folklore Mimic (Japanese yokai realm)
  - Flashback backrooms Apeirophobia
  - Camera cinematica: slow-motion + color grading per ogni universo
- **Visual storytelling**: Portali dimensionali, glitch multiversali
- **Reward finale**: Banner "Esploratore Multiversale", 3 Frammenti lore per ogni universo

#### **ATTO IV: IL MISTERO CENTRALE**
- **Trigger**: Completamento tutti i Path Lore Principale (Custom difficulty)
- **Obiettivo**: Avvicinarsi alla verità dell'Archivio
- **Scene cinematiche**:
  - Rivelazione: Anche il giocatore è un Ricorrente catturato
  - Confronto con Nucleo Centrale (boss cinematic)
  - L'Archivista tradisce/aiuta? (scelta narrativa visuale)
  - Camera: dramatic angles, lighting dinamico, slow-motion key moments
- **Visual storytelling**: Ambienti apocalittici, simboli arcani rivelati
- **Reward finale**: Titolo "Ricorrente Risvegliato", Maschera "Nucleo Spezzato"

#### **ATTO V: LA LIBERAZIONE (Endgame)**
- **Trigger**: Completamento 100 Runs + Achievement specifici
- **Obiettivo**: Finale narrativo — Liberazione o Accettazione?
- **Scene cinematiche**:
  - Finale A: Distruggi l'Archivio (cutscene epica)
  - Finale B: Diventa nuovo Custode (cutscene ambigua)
  - Finale C: Scopri il Vero Scopo (cutscene enigmatica)
  - Camera: cinematic trailer-quality, 2026 rendering tech
- **Visual storytelling**: Epilogo visuale personalizzato per scelta
- **Reward finale**: Titolo "Liberatore/Custode Eterno/Cercatore di Verità", Maschera unica per finale

---

## 🎬 SISTEMA CINEMATICO — Tech 2026

### **A. CUTSCENE SKIPPABILI**
- Ogni cutscene ha **prompt ESC/SKIP visibile** (non invasivo)
- Se saltata: **summary testuale breve** (5-10 parole) appare in HUD
- Possibilità di **rivedere cutscenes** nel Codex dell'Archivio

### **B. CAMERA TWEEN SERVICE**
Utilizzo avanzato di TweenService per:
- **POV transitions**: da First Person a Third Person cinematico
- **Aerial shots**: panoramiche dall'alto per reveal ambientali
- **Slow-motion sequences**: momenti chiave (es. primo incontro entità)
- **Dynamic tracking**: camera che segue azione (chase scenes)

### **C. INQUADRATURE E REGIA 2026**
- **Rule of thirds**: composizione cinematografica professionale
- **Color grading**: palette per ogni universo (es. Doors = blu freddo, Mimic = rosso folklore)
- **Lighting dinamico**: contrast lighting per suspense, soft light per lore reveals
- **Depth of field**: blur background per focus su personaggi/oggetti chiave
- **Motion blur**: per azioni veloci (chase entities)

### **D. AUDIO DESIGN CINEMATICO**
- **Score adattivo**: musica cambia intensità per emozione scena
- **Sound cues diegetici**: suoni ambientali (glitch, eco entità) sincronizzati con visual
- **Voice acting** (opzionale per L'Archivista): tono neutro/enigmatico

---

## 🌐 VISUAL STORYTELLING — Non-Intrusive Lore

### **Environmental Storytelling**
- **Simboli sui muri**: glifi extradimensionali che raccontano backstory Entità
- **Oggetti interagibili**: Frammenti dell'Archivio sparsi negli ambienti
- **Glitch narrativi**: effetti visivi che rivelano "verità nascoste" (es. muro glitcha → mostra universo originale)
- **NPC ambientali**: Echi di altri Ricorrenti (non ostili) che mormorano lore

### **HUD Diegetico**
- **Codex integrato**: lore collezionata visualizzata come "pagine dell'Archivio"
- **Timeline narrativa**: grafico visuale di progressione story unlock
- **Achievement narrativi**: icone che raccontano visivamente il viaggio del giocatore

### **Feedback Visivo Progressivo**
- **Iterazione 1-10**: Ambienti stabili, glitch minimi
- **Iterazione 50+**: Ambienti sempre più corrotti, glitch frequenti
- **Iterazione 100+**: Archivio al collasso, visual apocalittici

---

## 🎮 INTEGRAZIONE CON GAMEPLAY

### **Story Mode ≠ Separate Mode**
La storia NON è una modalità separata, ma **integrata nelle Runs**:
- **Path Lore**: Alcuni Path sono story-driven (più narrazione, meno chase)
- **Story Triggers**: Eventi narrativi accadono durante Runs normali (es. mid-run cutscene)
- **Scelte narrative**: Durante alcune Runs, scegli dialoghi con L'Archivista → influenza lore reveal

### **Balance Narrazione/Gameplay**
- **Story Runs**: ~60% esplorazione/lore, 40% chase/challenge
- **Chase Runs**: ~90% challenge, 10% lore ambientale
- Giocatore sceglie **intensità narrativa** con Custom difficulty: "Lore Focus" vs "Challenge Focus"

---

## 📊 PROGRESSION METRICS

| **Metrica**                  | **Unlock**                     | **Reward Narrativo**              |
|------------------------------|--------------------------------|-----------------------------------|
| 1 Run completata             | Atto I                         | Titolo + Frammento 1              |
| 10 Runs completate           | Atto II                        | Maschera + Frammento 2            |
| Path Velocità + Chase Hard+  | Atto III                       | Banner + 3 Frammenti universi     |
| Tutti Path Lore Custom       | Atto IV                        | Titolo epico + Maschera rara      |
| 100 Runs + Achievements      | Atto V                         | Finale + Titolo finale + Maschera |

---

## 🔄 REPLAY VALUE NARRATIVO

- **Multiple Endings**: 3 finali diversi → replay Atto V per vedere tutti
- **Hidden Lore**: Easter eggs narrativi nascosti in ambienti (richiede esplorazione)
- **Entity Backstories**: Ogni Entità ha lore sbloccabile (incontri multipli rivelano di più)
- **Gilda Lore Quests**: Missioni narrative collaborative per sbloccare lore esclusiva

---

## ✅ DESIGN PILLARS — Story Mode

1. **IMMERSIVO**: Player protagonista, non spettatore
2. **NON-FRUSTRANTE**: Skip cutscenes, lore opzionale ma rewarding
3. **CINEMATICO**: Tech 2026 per visual quality da AAA
4. **INTEGRATO**: Storia dentro gameplay, non separata
5. **GRATIFICANTE**: Ogni unlock lore = reward social (titoli, maschere)

---

**Status**: v1 — Design approvato, pronto per implementation Roblox Studio
**Next**: CINEMATIC_SYSTEM_v1.md per dettagli tecnici TweenService
