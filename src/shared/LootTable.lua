--!strict
-- LootTable.lua – COSOBOFFO
-- Sistema loot ARPG-soft: Common/Rare/Epic con affissi narrativi
-- Versione: 1.0 | Data: 2026-03-07
-- Loot diegetico: ogni oggetto ha giustificazione nella lore dell'Archivio

local LootTable = {}
LootTable.__index = LootTable

-- ============================================================
-- TIER ENUM
-- ============================================================
local TIER = {
	COMMON = "Common",
	RARE = "Rare",
	EPIC = "Epic",
	NARRATIVO = "Narrativo", -- solo lore, nessun bonus gameplay
}

-- ============================================================
-- AFFISSI (modificatori narrativi + gameplay)
-- ============================================================
local AFFIXES = {
	-- Percezione (ruolo Osservatore)
	{ id = "eco_visivo",			desc = "Percepisce echi visivi delle entita' vicine",			statBonus = { perception = 0.15 } },
	{ id = "senso_archivio",		desc = "L'Archivio sussurra pericoli imminenti",				statBonus = { perception = 0.25, sanity = -0.05 } },
	-- Movimento (ruolo Corriere)
	{ id = "passo_silenzioso",	desc = "Passi attutiti, meno aggro da entita' sonore",		statBonus = { noiseMult = 0.6 } },
	{ id = "adrenalina_residua",	desc = "Stamina si rigenera piu' velocemente",				statBonus = { staminaRegen = 1.4 } },
	{ id = "traccia_liminale",	desc = "Velocita' lievemente aumentata nei corridoi",			statBonus = { speed = 0.1 } },
	-- Sopravvivenza (ruolo Tecnico)
	{ id = "memoria_tecnica",	desc = "Interazioni con oggetti tecnici 30% piu' rapide",	statBonus = { interactSpeed = 1.3 } },
	{ id = "schermatura_statica",	desc = "Riduce il danno del glitch da entita' Correttore",	statBonus = { correttoreDmgMult = 0.7 } },
	-- Lore/Narrativo (ruolo Medium)
	{ id = "frammento_archivio",	desc = "Rivela un frammento di lore sull'Archivio",			statBonus = {} },
	{ id = "risonanza_eco",		desc = "Permette di sentire sussurri di Echi nelle stanze",	statBonus = { perception = 0.10 } },
}

-- ============================================================
-- POOL LOOT PER PATH
-- ============================================================
local LOOT_POOLS = {
	-- PATH A: Pizzeria della Memoria
	A = {
		{ id = "nastro_audio_distorto",	tier = TIER.COMMON,		weight = 12, affix = nil,					desc = "Registrazione vocale corrotta con voci infantili" },
		{ id = "menu_originale_1985",		tier = TIER.COMMON,		weight = 10, affix = nil,					desc = "Menu della pizzeria con annotazioni a mano" },
		{ id = "foto_famiglia",			tier = TIER.RARE,		weight = 6,	affix = "frammento_archivio",	desc = "Foto di una famiglia sorridente davanti al palco" },
		{ id = "chiave_ufficio",			tier = TIER.RARE,		weight = 5,	affix = "memoria_tecnica",		desc = "Chiave con etichetta 'SOLO PERSONALE'" },
		{ id = "badge_animatronic",		tier = TIER.EPIC,		weight = 2,	affix = "schermatura_statica",	desc = "Piastrina di identificazione di un animatronic mai classificato" },
		{ id = "diario_cuoco",			tier = TIER.NARRATIVO,	weight = 3,	affix = "risonanza_eco",			desc = "Diario del cuoco. L'ultima pagina e' bianca ma emette calore" },
	},
	-- PATH B: Fabbrica degli Scarti
	B = {
		{ id = "manuale_produzione",		tier = TIER.COMMON,		weight = 12, affix = nil,					desc = "Manuale tecnico con pagine mancanti" },
		{ id = "cassetta_vhs_test",		tier = TIER.RARE,		weight = 6,	affix = "frammento_archivio",	desc = "VHS etichettata TEST_07. Non riprodurla da sola" },
		{ id = "bozzetto_design",			tier = TIER.COMMON,		weight = 10, affix = "passo_silenzioso",	desc = "Bozzetto di un giocattolo mai prodotto" },
		{ id = "chip_memoria",			tier = TIER.EPIC,		weight = 2,	affix = "adrenalina_residua",	desc = "Chip estratto da uno Scarto. Vibra leggermente" },
	},
	-- PATH C: Siti Dimenticati (SCP)
	C = {
		{ id = "documento_classificato",	tier = TIER.COMMON,		weight = 11, affix = nil,					desc = "Documento con testo censurato, solo data e timbro visibili" },
		{ id = "foto_personale_sparito",	tier = TIER.RARE,		weight = 6,	affix = "frammento_archivio",	desc = "Foto tessera. Occhi ritagliati" },
		{ id = "registrazione_esperimento",tier = TIER.RARE,		weight = 5,	affix = "eco_visivo",			desc = "Audio di un esperimento. Soggetto non nominato" },
		{ id = "badge_fondazione",		tier = TIER.EPIC,		weight = 2,	affix = "schermatura_statica",	desc = "Badge Fondazione. Accesso revocato. Data: mai" },
		{ id = "codice_protocollo",		tier = TIER.NARRATIVO,	weight = 3,	affix = "memoria_tecnica",		desc = "Codice scritto a mano. Nessuna procedura corrispondente" },
	},
	-- PATH D: Backrooms/Liminal
	D = {
		{ id = "oggetto_personale",		tier = TIER.COMMON,		weight = 15, affix = nil,					desc = "Oggetto comune senza contesto. Ti sembra familiare" },
		{ id = "biglietto_senza_mittente",	tier = TIER.RARE,		weight = 5,	affix = "risonanza_eco",			desc = "Biglietto scritto in una lingua che riesci a leggere solo a meta'" },
		{ id = "mappa_impossibile",		tier = TIER.EPIC,		weight = 2,	affix = "senso_archivio",			desc = "Mappa che non corrisponde a nessun posto reale. Eppure" },
	},
	-- PATH E: Trasmissione Distorta (Analog Horror)
	E = {
		{ id = "vhs_disturbante",		tier = TIER.COMMON,		weight = 11, affix = nil,					desc = "VHS con contenuto che cambia ogni visione" },
		{ id = "trascrizione_trasmissione",tier = TIER.RARE,		weight = 6,	affix = "frammento_archivio",	desc = "Trascrizione di segnale radio. Mittente sconosciuto" },
		{ id = "mappa_frequenze",		tier = TIER.RARE,		weight = 5,	affix = "eco_visivo",			"Mappa delle frequenze attive. 3 segnali non identificati" },
		{ id = "dente_antenna",			tier = TIER.EPIC,		weight = 2,	affix = "traccia_liminale",	desc = "Frammento di antenna. Emette statica al tocco" },
	},
}

-- ============================================================
-- UTILITY
-- ============================================================
local function weightedRandom(pool: {any}, rng: Random): any
	local total = 0
	for _, item in ipairs(pool) do total += (item.weight or 1) end
	local roll = rng:NextNumber() * total
	local cum = 0
	for _, item in ipairs(pool) do
		cum += (item.weight or 1)
		if roll <= cum then return item end
	end
	return pool[#pool]
end

local function getAffix(affixId: string?): any?
	if not affixId then return nil end
	for _, affix in ipairs(AFFIXES) do
		if affix.id == affixId then return affix end
	end
	return nil
end

-- ============================================================
-- API PUBBLICA
-- ============================================================

-- Genera drop loot per una run completata
-- pathId: "A".."E" | difficulty: 1-3 | guildPerk: string? (es. "perception")
function LootTable.GenerateDrop(pathId: string, difficulty: number?, guildPerk: string?): {any}
	local diff = difficulty or 2
	local rng = Random.new(math.floor(os.clock() * 10000))
	local pool = LOOT_POOLS[pathId]
	if not pool then pool = LOOT_POOLS["A"] end

	-- Numero drop: 2 base + 1 per difficulty + bonus gilda
	local dropCount = 2 + (diff - 1)
	if guildPerk == "perception" then dropCount += 1 end -- Osservatore vede piu' loot

	local drops: {any} = {}
	local usedIds: {[string]: boolean} = {}

	for i = 1, dropCount do
		local item = weightedRandom(pool, rng)
		if not usedIds[item.id] then
			usedIds[item.id] = true
			local affix = getAffix(item.affix)
			table.insert(drops, {
				id = item.id,
				tier = item.tier,
				desc = item.desc,
				affix = affix,
				path = pathId,
			})
		end
	end

	return drops
end

-- Valore gilda-valuta di un item (usato per sblocchi nella base)
function LootTable.GetGuildValue(item: any): number
	local base = 0
	if item.tier == TIER.COMMON then base = 10
	elseif item.tier == TIER.RARE then base = 25
	elseif item.tier == TIER.EPIC then base = 60
	elseif item.tier == TIER.NARRATIVO then base = 15 -- lore ha valore sociale
	end
	return base
end

LootTable.TIER = TIER
return LootTable
