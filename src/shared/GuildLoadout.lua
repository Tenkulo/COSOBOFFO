--!strict
-- GuildLoadout.lua – COSOBOFFO
-- Sistema ruoli di gilda, perks e loadout per run
-- Versione: 1.0 | Data: 2026-03-07
-- 4 ruoli gilda: Osservatore, Corriere, Medium, Tecnico
-- Perks sbloccabili con XP gilda (non individuale)

local GuildLoadout = {}
GuildLoadout.__index = GuildLoadout

-- ============================================================
-- RUOLI DI GILDA
-- ============================================================
local ROLES = {
	-- OSSERVATORE: Alta percezione, vede di piu', piu' vulnerabile fisicamente
	Osservatore = {
		id = "Osservatore",
		desc = "Membro d'avanguardia della gilda. Sente cio' che gli altri non vedono.",
		loreDesc = "I tessuti dell'Archivio gli mostrano le crepe prima che si allarghino.",
		baseStats = {
			speed = 14,				-- studs/sec walk
			sprintSpeed = 22,
			stamina = 80,			-- max stamina points
			staminaRegen = 1.0,		-- per secondo
			perception = 1.3,		-- moltiplicatore range avviso entita'
			noiseMult = 1.0,
			interactSpeed = 1.0,
		},
		perks = {
			{ id = "terzo_occhio",			xpCost = 50,		desc = "Visione offuscata rivela sagome entita' attraverso i muri a 15 studs" },
			{ id = "echi_residui",			xpCost = 100,		desc = "Oggetti narrativi emettono aura visibile nel buio" },
			{ id = "senso_archivio_pro",	xpCost = 200,		desc = "Avviso sonoro 3s prima che un'entita' entri in CHASE" },
		},
		guildPerkId = "perception", -- usato da LootTable per bonus drop
	},

	-- CORRIERE: Mobilita' alta, resistenza media, buono per rescue e extract
	Corriere = {
		id = "Corriere",
		desc = "Il piu' veloce della gilda. Sa quando e come fuggire.",
		loreDesc = "Ha attraversato piu' Ricorrenze di chiunque altro. Conosce ogni uscita.",
		baseStats = {
			speed = 16,
			sprintSpeed = 26,
			stamina = 120,
			staminaRegen = 1.6,
			perception = 0.9,
			noiseMult = 0.85,		-- passi piu' silenziosi di default
			interactSpeed = 1.0,
		},
		perks = {
			{ id = "sprint_archivio",	xpCost = 50,		desc = "Sprint dura 20% in piu' prima di consumare stamina" },
			{ id = "caduta_silenziosa",	xpCost = 100,		desc = "Saltare non genera rumore di impatto (no aggro Silenziatore)" },
			{ id = "estrazione_rapida",	xpCost = 200,		desc = "Activation extraction point 40% piu' veloce" },
		},
		guildPerkId = "speed",
	},

	-- MEDIUM: Percezione paranormale, alta vulnerabilita', unlock lore speciale
	Medium = {
		id = "Medium",
		desc = "Avverte la presenza dell'Archivio con ogni fibra. Paga un prezzo.",
		loreDesc = "L'Archivista lo ha notato. Le entita' lo notano di piu'.",
		baseStats = {
			speed = 13,
			sprintSpeed = 20,
			stamina = 70,
			staminaRegen = 0.9,
			perception = 1.5,		-- massima percezione
			noiseMult = 1.1,		-- leggero rumore paranormale
			interactSpeed = 1.0,
			sanityDrainMult = 1.2,	-- perde sanity piu' in fretta
			paranormalBonus = true,	-- unlock eventi speciali
		},
		perks = {
			{ id = "eco_vivo",				xpCost = 50,		desc = "Sente gli Echi nelle stanze vuote: audio hint sulla prossima stanza" },
			{ id = "maschera_archivio",		xpCost = 100,		desc = "Una volta per run: diventa invisibile alle entita' per 5 secondi" },
			{ id = "voce_dell_archiviato",	xpCost = 200,		desc = "Sblocca dialogo con entita' Eco Liminale: rivela obiettivi nascosti" },
		},
		guildPerkId = "paranormal",
	},

	-- TECNICO: Velocita' interazione alta, sblocca shortcut tecnici
	Tecnico = {
		id = "Tecnico",
		desc = "Risolve problemi tecnici dove gli altri vedono solo caos.",
		loreDesc = "Capisce l'Archivio come sistema. Trova sempre l'interruttore giusto.",
		baseStats = {
			speed = 14,
			sprintSpeed = 21,
			stamina = 100,
			staminaRegen = 1.2,
			perception = 1.0,
			noiseMult = 0.95,
			interactSpeed = 1.5,	-- molto piu' veloce su leve/porte/generatori
		},
		perks = {
			{ id = "bypass_sistema",		xpCost = 50,		desc = "Porte bloccate richiedono 50% meno tempo per essere forzate" },
			{ id = "generatore_silenzioso",	xpCost = 100,		desc = "Attivare generatori non produce rumore (no aggro Silenziatore)" },
			{ id = "jammer_correttore",		xpCost = 200,		desc = "Una volta per run: jamma il Correttore Meccanico per 8 secondi (IDLE forzato)" },
		},
		guildPerkId = "interact",
	},
}

-- ============================================================
-- RUN MODIFIERS
-- ============================================================
local RUN_MODIFIERS = {
	{ id = "blackout",			name = "Blackout",			desc = "Luci instabili per tutta la run. Reward +50%",			rewardMult = 1.5, lightFlicker = true, entityAggro = 1.0 },
	{ id = "infestation",		name = "Infestazione",		desc = "Piu' entita' minori, meno macro-eventi. Reward +30%",		rewardMult = 1.3, extraMinorEntities = 2, macroEventMult = 0.5 },
	{ id = "silent_shift",		name = "Turno Silenzioso",	desc = "Nessun audio entita'. Solo cue visive. Reward +80%",		rewardMult = 1.8, muteEntities = true },
	{ id = "easy_mode",			name = "Ricognizione",		desc = "Entita' meno aggressive, piu' luce. Reward -50%",		rewardMult = 0.5, reducedAggro = true, extraLight = true },
	{ id = "hard_mode",			name = "Ricorrenza Critica",	desc = "Spawn densi, buio, meno loot. Reward +120%",			rewardMult = 2.2, extraEntities = 2, reducedLoot = true },
}

-- ============================================================
-- API PUBBLICA
-- ============================================================

function GuildLoadout.GetRole(roleId: string): any?
	return ROLES[roleId]
end

function GuildLoadout.GetAllRoles(): {string}
	local ids: {string} = {}
	for id in pairs(ROLES) do
		table.insert(ids, id)
	end
	return ids
end

-- Calcola stats finali applicando perk sbloccati
-- unlockedPerks: lista di perk id sbloccati
function GuildLoadout.ResolveStats(roleId: string, unlockedPerks: {string}): any
	local role = ROLES[roleId]
	if not role then
		return ROLES["Corriere"].baseStats
	end

	-- Copia base stats
	local stats: {[string]: any} = {}
	for k, v in pairs(role.baseStats) do
		stats[k] = v
	end

	-- Applica modificatori perk specifici
	for _, perkId in ipairs(unlockedPerks) do
		if perkId == "sprint_archivio" then
			stats.stamina = (stats.stamina :: number) * 1.2
		elseif perkId == "caduta_silenziosa" then
			stats.noiseMult = (stats.noiseMult :: number) * 0.0 -- jump silenzioso
		elseif perkId == "estrazione_rapida" then
			stats.extractSpeed = 1.4
		elseif perkId == "bypass_sistema" then
			stats.interactSpeed = (stats.interactSpeed :: number) * 1.5
		end
	end

	return stats
end

-- Ritorna modifier di run per ID
function GuildLoadout.GetModifier(modId: string): any?
	for _, mod in ipairs(RUN_MODIFIERS) do
		if mod.id == modId then return mod end
	end
	return nil
end

function GuildLoadout.GetAllModifiers(): {any}
	return RUN_MODIFIERS
end

GuildLoadout.ROLES = ROLES
GuildLoadout.RUN_MODIFIERS = RUN_MODIFIERS
return GuildLoadout
