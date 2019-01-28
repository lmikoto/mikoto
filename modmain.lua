PrefabFiles = {
	"mikoto",
    "mikoto_none",
    "fesword",
    -- "mikoto_zap_fx",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/mikoto.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/mikoto.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/mikoto.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/mikoto.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/mikoto_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/mikoto_silho.xml" ),

    Asset( "IMAGE", "bigportraits/mikoto.tex" ),
    Asset( "ATLAS", "bigportraits/mikoto.xml" ),
	
	Asset( "IMAGE", "images/map_icons/mikoto.tex" ),
	Asset( "ATLAS", "images/map_icons/mikoto.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_mikoto.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_mikoto.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_mikoto.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_mikoto.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_mikoto.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_mikoto.xml" ),
	
	Asset( "IMAGE", "images/names_mikoto.tex" ),
    Asset( "ATLAS", "images/names_mikoto.xml" ),
	
	Asset( "IMAGE", "images/names_gold_mikoto.tex" ),
    Asset( "ATLAS", "images/names_gold_mikoto.xml" ),
	
    Asset( "IMAGE", "bigportraits/mikoto_none.tex" ),
    Asset( "ATLAS", "bigportraits/mikoto_none.xml" ),

}

AddMinimapAtlas("images/map_icons/mikoto.xml")

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

-- The character select screen lines
STRINGS.CHARACTER_TITLES.mikoto = "The Sample Character"
STRINGS.CHARACTER_NAMES.mikoto = "Esc"
STRINGS.CHARACTER_DESCRIPTIONS.mikoto = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.mikoto = "\"Quote\""

-- Custom speech strings
STRINGS.CHARACTERS.MIKOTO = require "speech_mikoto"

-- The character's name as appears in-game 
STRINGS.NAMES.MIKOTO = "Esc"

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("mikoto", "FEMALE")

-- 制作物品栏
local mikototab = AddRecipeTab( "物品", 999, "images/hud/mikoto_tab.xml", "mikoto_tab.tex", "mikoto")
local TECH = GLOBAL.TECH

-- 铁砂之剑
local fesword = Recipe( "fesword", {}, mikototab, TECH.NONE, nil, nil, nil, nil, nil,"images/inventoryimages/fesword.xml") 
fesword.sortkey = 4
STRINGS.NAMES.FESWORD = "铁砂之剑"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.FESWORD = "通过使铁砂震动而形成的类链锯，\n被砍中的话可是会见血的哦。"
STRINGS.RECIPE_DESC.FESWORD = "用磁力聚集方圆两百米的铁砂" 