local assets =
{
	Asset( "ANIM", "anim/mikoto.zip" ),
	Asset( "ANIM", "anim/ghost_mikoto_build.zip" ),
}

local skins =
{
	normal_skin = "mikoto",
	ghost_skin = "ghost_mikoto_build",
}

return CreatePrefabSkin("mikoto_none",
{
	base_prefab = "mikoto",
	type = "base",
	assets = assets,
	skins = skins, 
	skin_tags = {"MIKOTO", "CHARACTER", "BASE"},
	build_name = "mikoto",
	rarity = "Common",
})