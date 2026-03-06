# ENTITIES_HIERARCHY_AND_LORE_v1.md
> Versione: 2.0 | Stato: AGGIORNATO | Canon: allineato a LORE_CORE_ULTIMATE_2026.md v2.0
> Integrazione: SCP Foundation + Backrooms + Analog Horror

---

## 1. GERARCHIA DELL'ARCHIVIO

| Tier | Classe | Ruolo Gameplay |
|---|---|---|
| 1 | Nucleo | L'Archivio stesso, non affrontabile |
| 2 | Custodi | Boss di fine Arco Narrativo |
| 3 | Correttori | Inseguono attivamente, elite |
| 4 | Scarti | Ostacoli ambientali, semi-statici |
| 5 | Echi | Nemici base, abbondanti |
| 6 | Avatar di Gilda | Manifestazioni benigne, NPC alleati |

---

## 2. ROSTER COMPLETO VERTICAL SLICE + NUOVE ENTITA'

### TIER 3 - CORRETTORI

#### 1. Il Silenziatore [PATH: Cross] [VS-CORE]
- **Lore:** Silhouette allungata senza volto. Toglie l'audio all'ambiente (e al giocatore) se si avvicina.
- **Ispirazione:** SCP-096 (trigger visivo), Silent Hill (deformazione)
- **Comportamento:** IDLE->PATROL->ALERT->CHASE. In ALERT emette un silenzio totale nel raggio di 15 studs.
- **Mechanic:** Il giocatore che lo guarda attiva la CHASE. Gli altri no. Richiede coordinazione.
- **Core Sound:** Assenza di suono. Il silenzio e' il segnale.
- **lookAwayImmune:** false
- **VS Priority:** P0

#### 2. Il Correttore Meccanico [PATH: FNaF] [VS-CORE]
- **Lore:** Ispirato alle memorie dei ristoranti. Animatronic corrotto che cerca pezzi mancanti. Si muove a scatti solo quando non osservato.
- **Ispirazione:** FNaF, SCP-173 (no-sight movement)
- **Comportamento:** IDLE->PATROL->ALERT->CHASE. Si ferma se almeno 1 giocatore lo guarda.
- **Mechanic:** Look-Away cooperativa - uno guarda, l'altro agisce.
- **Core Sound:** Suoni metallici, risate infantili distorte, musica jingle rallentata.
- **lookAwayImmune:** false
- **VS Priority:** P0

#### 3. L'Archiviato [PATH: SCP] [NUOVO]
- **Lore:** Ex-anomalia SCP assorbita dall'Archivio. Non ricorda cosa era. Porta ancora un numero inciso sul corpo (es. ARK-049, ARK-106, ARK-173 - NON i nomi SCP ufficiali). Esegue protocolli di contenimento ormai privi di senso.
- **Ispirazione:** SCP Foundation (estetica e comportamento burocratico), Dead Space (body horror istituzionale)
- **Comportamento:** IDLE->PATROL->ALERT->PROCEDURE->CHASE. Lo stato PROCEDURE e' unico: l'Archiviato si ferma e "cataloga" i giocatori in vista (crea un delay di 3 sec prima di inseguire - finestra di fuga).
- **Mechanic:** Le porte del Sito si chiudono automaticamente quando l'Archiviato entra in CHASE. Servono 2 giocatori per riabilitarle (terminali a doppio input).
- **Core Sound:** Voce robotica che recita numeri di protocollo. Allarmi istituzionali. Porte metalliche.
- **lookAwayImmune:** true (non si ferma guardandolo)
- **VS Priority:** P1

### TIER 4 - SCARTI

#### 4. Lo Scarto Abbandonato [PATH: Poppy] [VS-CORE]
- **Lore:** Giocattolo gigante rianimato. Lento ma con arti estensibili. Segue i suoni.
- **Comportamento:** IDLE->PATROL->ALERT->CHASE. Detect solo audio (hearingRange 25 studs, detectionRange visivo solo 10 studs).
- **Core Sound:** Cigolii di plastica, ninnananne distorte.
- **lookAwayImmune:** true
- **VS Priority:** P1

#### 5. Il Collezionista di Passi [PATH: Cross] [VS-CORE]
- **Lore:** Scarto che rallenta lasciando tracce visibili. Segue i Ricorrenti lentamente ma inesorabilmente.
- **Comportamento:** PATROL permanente verso ultima posizione nota giocatore. Non entra mai in CHASE veloce.
- **Core Sound:** Passi pesanti, suono di qualcosa che si trascina.
- **lookAwayImmune:** true
- **VS Priority:** P1

#### 6. La Procedura [PATH: SCP] [NUOVO]
- **Lore:** Non e' un essere. E' un protocollo rimasto attivo. Un processo burocratico dell'Archivio che si manifesta come sequenza di azioni automatiche: porte che si chiudono, luci che si spengono in pattern, gas di contenimento che si attiva. Non ha corpo.
- **Ispirazione:** SCP-079 (entita' informatica), Alien Isolation (sistema di sicurezza ostile)
- **Comportamento:** Non si muove. E' ambientale. Attiva trappole in sequenza quando i giocatori entrano in certe zone.
- **Mechanic:** I giocatori possono "hackerare" i terminali del Sito per interrompere La Procedura temporaneamente. Richiede un giocatore al terminale e gli altri a proteggere.
- **Core Sound:** Avvisi di sistema, beep di conferma, voci sintetiche che recitano protocolli.
- **VS Priority:** P2

### TIER 5 - ECHI

#### 7. L'Osservatore [PATH: Cross] [VS-CORE]
- **Lore:** Appare solo se non guardato. Eco di una memoria voyeuristica.
- **Comportamento:** Esiste solo quando i giocatori NON lo guardano. Scompare immediatamente alla vista diretta. Causa danno da prossimita' invisibile.
- **Core Sound:** Respiro affannoso, impercettibile.
- **VS Priority:** P1

#### 8. L'Urlo Sordo [PATH: Cross] [VS-CORE]
- **Lore:** Frammento di memoria di un urlo che nessuno ha sentito. Attira altri nemici.
- **Comportamento:** Non attacca direttamente. Se agganciato, emette un segnale che mette in ALERT tutti i Correttori nel raggio di 50 studs.
- **Core Sound:** Urlo distorto, subsonic, quasi inudibile.
- **VS Priority:** P1

#### 9. L'Eco Liminale [PATH: Backrooms] [NUOVO]
- **Lore:** Presenza senza forma definita che esiste negli Spazi tra le Memorie. Non attacca. Disorientano.
- **Ispirazione:** Backrooms entities (Smilers, Hounds), SCP-106 (atmospheric dread)
- **Comportamento:** Appare ai margini della visuale. Si avvicina lentamente. A contatto non causa danno fisico ma inverte i controlli del giocatore per 10 secondi e distorce la minimappa.
- **Mechanic:** Solo il contatto fisico con un altro Ricorrente annulla l'effetto disorientamento (cooperazione obbligatoria).
- **Core Sound:** Nessun suono diretto. Cambia il soundscape dell'ambiente (eco infinita, frequenze basse).
- **lookAwayImmune:** true
- **VS Priority:** P2

#### 10. La Voce dal Segnale [PATH: Analog Horror] [NUOVO]
- **Lore:** Eco di una trasmissione televisiva che non avrebbe dovuto esistere. Si manifesta sui monitor dell'ambiente. Non ha corpo fisico.
- **Ispirazione:** Mandela Catalogue (Alternates), Local 58, SCP-1548
- **Comportamento:** Appare su tutti gli schermi nell'area. UN SOLO giocatore la vede (client-side). Deve comunicare agli altri la posizione. Se la fonte (monitor/antenna) non viene spenta entro 60 sec, materializza un Correttore nell'area.
- **Mechanic:** Asimmetria informativa pura. Genera comunicazione verbale reale via proximity chat.
- **Core Sound:** Static TV, voce distorta che chiama i nomi (nome del personaggio nel gioco), sigle televisive degli anni '80 rallentate.
- **lookAwayImmune:** N/A (non fisico)
- **VS Priority:** P2

---

## 3. CUSTODI (BOSS DI ARCO NARRATIVO)

| Nome | Path | Mechanic Boss | VS |
|---|---|---|---|
| Custode del Ristorante | FNaF | Look-away di gruppo obbligatoria | Post-VS |
| Custode della Fabbrica | Poppy | Stealth totale, nessun suono | Post-VS |
| Il Catalogatore | SCP | Divide il party in celle separate | Post-VS |
| L'Eco Primordiale | Liminal | Disorientamento di massa, hub temporaneo | Post-VS |
| Il Trasmettitore Madre | Analog | Tutti vedono cose diverse | Post-VS |

---

## 4. NOTE DI DESIGN ENTITA'

### Regole universali (da trend research)
- **Ogni entita' ha 1 Core Sound unico e riconoscibile** - i giocatori imparano a identificarle dall'audio prima di vederle.
- **Ogni entita' forza cooperazione** - nessuna entita' e' gestibile in perfetto isolamento.
- **Varianza comportamentale** - ogni entita' ha un seed RNG che modifica leggermente velocita', detection range e patrol path ogni run. Mai identici.
- **Mistero residuo** - le entita' dei path Backrooms e Analog NON hanno lore completo nei file. I frammenti di loot rivelano pezzi. Mai il quadro completo.

### Tabella parametri gameplay

| Entita' | MoveSpeed | DetectRange | HearRange | LookAway | Tier | Path |
|---|---|---|---|---|---|---|
| Silenziatore | 14 | 35 | 25 | false | 3 | Cross |
| Correttore Meccanico | 12 | 30 | 20 | false | 3 | FNaF |
| Archiviato | 10 | 40 | 15 | true | 3 | SCP |
| Scarto Abbandonato | 5 | 10 | 25 | true | 4 | Poppy |
| Collezionista di Passi | 4 | 20 | 30 | true | 4 | Cross |
| La Procedura | 0 | N/A | N/A | true | 4 | SCP |
| Osservatore | 8 | 15 | 5 | false | 5 | Cross |
| Urlo Sordo | 3 | 10 | 10 | true | 5 | Cross |
| Eco Liminale | 6 | 25 | 10 | true | 5 | Backrooms |
| Voce dal Segnale | 0 | N/A | N/A | true | 5 | Analog |
