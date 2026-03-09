# UX_FLOW_v1.md – COSOBOFFO

> Flow Design Mobile-First per "L'Archivio dei Ricorrenti"

## 1. FLOW MASTER
```text
[START] -> (CARICAMENTO) -> [HUB: L'ARCHIVIO]
                                 |
           (P0: CTA PRIMARIA) -> [ELEVATORE DELLE MEMORIE]
                                 |
        (SELEZIONE AUTOMATICA) -> [PRE-RUN LOBBY]
                                 |
             (COUNTDOWN 5s)   -> [LOADING ISTANZA]
                                 |
              (DIEGETIC HINT) -> [RUN: PATH A/B]
                                 |
         (OUTCOME: EXIT/DEATH) -> [SUMMARY SCREEN]
                                 |
              (AUTO-RETURN)   -> [HUB: L'ARCHIVIO]
```

## 2. FIRST SESSION FLOW (Nuovo Giocatore)
Obiettivo: In una run entro 180 secondi.

*   **Secondi 0-30**: Atterraggio nell'Hub. Visuale in prima persona (immersione). L'Archivista parla (testo a schermo centrale 15 parole max). Nessuna UI invadente. Solo un indicatore luminoso (affordance) verso l'Elevatore.
*   **Secondi 30-90**: Il giocatore cammina verso l'Elevatore (test di movimento mobile). Capisce che lo spazio è "l'Archivio" tramite l'ambiente. Non capisce ancora le gilde (non serve ora).
*   **Secondi 90-180**: Clicca l'Elevatore (CTA 90%). Appare UI selezione Path (solo Path A sbloccato per FTUE). Clicca "Inizia Ricorrenza".
*   **RISULTATO**: Al secondo 180 il giocatore è nella prima stanza della Pizzeria Distorta (Path A).

## 3. SCHERMATA HUB (Wireframe ASCII)
```text
________________________________________________________
| [MENU/SET]                        [VALUTA/RANK]      |
|                                                      |
|        (VISUALE 3D: L'ARCHIVIO)                      |
|                                                      |
|    [GILDA INFO]              [LOG CANON]             |
|    (Secondaria)              (Lore/Loot)             |
|                                                      |
|             __________________________               |
|             |    [INIZIA RICORRENZA] |  <-- CTA 1    |
|             |      (ELEVATORE)       |               |
|             --------------------------               |
| [SHOP/UPGRADE]                     [SOCIAL/FRIENDS]  |
|______________________________________________________|
```
*   **Gerarchia**: CTA Elevatore centrale, pulsanti secondari ai bordi.
*   **Returning Player**: All'apertura successiva, appaiono notifiche su [LOG CANON] se ha trovato nuovi loot narrativi.

## 4. PRE-RUN FLOW
*   **Selezione Ruolo**: Appare dopo aver cliccato l'Elevatore. 4 icone grandi (44x44+). Default: **Custode** (bilanciato). Saltabile (click fuori o timer 5s seleziona default).
*   **Selezione Path**: Solo Path A disponibile all'inizio. Altri hanno badge "Richiede Rank X".
*   **Party Assembly**: Sistema "Quick-Match" automatico. Se il giocatore aspetta 10s senza trovare nessuno, appare tasto "Inizia Solo" (evita drop-off).
*   **PreRunShop**: Piccolo pop-up laterale prima del loading. "Vuoi usare 1 Memoria per un Boost?". Scompare al loading.

## 5. IN-RUN UX
*   **Primo incontro entità**: Nessun pop-up. Lo schermo glitcha (Path A) o l'heartbeat aumenta (Path B). L'input visivo (silhouette luminosa) insegna il pericolo.
*   **Morte compagno**: Aura azzurra visibile attraverso i muri (Highlight). Icona "Soccorri" appare se vicino.
*   **Extraction ready**: Sirena audio soffusa + indicatore bussola diegetico nell'HUD (Archive Blue).
*   **Morte propria**: Schermo nero → Testo rosso (Lore-consistent) → Pulsante "Torna all'Archivio" (Chiaro e veloce).

## 6. MOBILE-SPECIFIC UX (Thumb Zones)
```text
_________________________________________
| [M] [L]                         [I]   |  M=Menu, L=Loot, I=Inv
|                                       |
|    (ZONE A)                (ZONE B)   |  A=Joystick Move
|    MOVIMENTO               VISUALE    |  B=Visuale/Look
|                                       |
|    [O]      (ZONE C)           [X]    |  O=Interact (44pt)
|             CONTROLLI          [J]    |  X=Ability, J=Jump
|_______________________________________|
```
*   **Joystick (Sinistra)**: Dinamico.
*   **Tap Targets**: Minimo 44x44px per pulsanti critici (Interact/Ability).
*   **Gestures**: Swipe rapido a destra per voltarsi di 180° (anti-horror move).
*   **Remap PC**: Interact (E) -> Bottone [O]; Sprint (Shift) -> Auto-sprint se Joystick è al massimo.

## 7. FTUE CHECKLIST (Diegetic Learning)
1.  **Muoversi**: Spostando il pollice (Visual feedback).
2.  **Guardare intorno**: Trascinando a destra.
3.  **Sprintare**: Spingendo joystick al limite (Auto-sprint).
4.  **Interagire**: Pulsante evidenziato quando vicino a oggetti.
5.  **Stealth (Path B)**: Riduzione velocità joystick riduce rumore (Affordance sonora).
6.  **Look-Away (Path A)**: Glitch visivo insegna a non guardare.
7.  **Raccogliere Loot**: Feedback tattile (Vibration) + suono "Archive Link".
8.  **Revive**: Icona compagno in difficoltà.
9.  **Trovare l'Uscita**: Bussola HUD si attiva a obiettivi completati.
10. **Morire**: Capire che è parte del loop (Schermata summary diegetica).
