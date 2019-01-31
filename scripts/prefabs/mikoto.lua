local MakePlayerCharacter = require "prefabs/player_common"


local assets = {
    Asset( "ANIM", "anim/mikoto.zip" ),
    Asset("SCRIPT", "scripts/prefabs/player_common.lua"),
    Asset("ANIM", "anim/lightning_goat_build.zip"),
    Asset("ANIM", "anim/lightning_goat_shocked_build.zip"),
    Asset("ANIM", "anim/lightning_goat_basic.zip"),
    Asset("ANIM", "anim/lightning_goat_actions.zip"),
}
local prefabs = {}

-- Custom starting inventory
local start_inv = {
}

local function IsChargedGoat(dude)
    return dude:HasTag("lightninggoat") and dude:HasTag("charged")
end

local function OnAttacked(inst, data)
    if data ~= nil and data.attacker ~= nil then
        if data.attacker.components.health ~= nil and not data.attacker.components.health:IsDead() and
            (data.weapon == nil or ((data.weapon.components.weapon == nil or data.weapon.components.weapon.projectile == nil) and data.weapon.components.projectile == nil)) and
            not (data.attacker.components.inventory ~= nil and data.attacker.components.inventory:IsInsulated()) then

            data.attacker.components.health:DoDelta(-99, nil, inst.prefab, nil, inst)
            if data.attacker:HasTag("player") then
                data.attacker.sg:GoToState("electrocute")
            end
            local zap_fx = SpawnPrefab("mikoto_zap_small") 
            local pos = inst:GetPosition() 
            pos.y = pos.y + 1
            zap_fx.Transform:SetPosition(pos:Get()) 
            zap_fx.Transform:SetScale(2,2,2)  
        end
        inst.components.combat:SetTarget(data.attacker)
        inst.components.combat:ShareTarget(data.attacker, 20, IsChargedGoat, 3)
    end
end


-- When the character is revived from human
local function onbecamehuman(inst)
	-- Set speed when not a ghost (optional)
	inst.components.locomotor:SetExternalSpeedMultiplier(inst, "mikoto_speed_mod", 1)
end

local function onbecameghost(inst)
	-- Remove speed modifier when becoming a ghost
   inst.components.locomotor:RemoveExternalSpeedMultiplier(inst, "mikoto_speed_mod")
end

-- When loading or spawning the character
local function onload(inst)
    inst:ListenForEvent("ms_respawnedfromghost", onbecamehuman)
    inst:ListenForEvent("ms_becameghost", onbecameghost)

    if inst:HasTag("playerghost") then
        onbecameghost(inst)
    else
        onbecamehuman(inst)
    end
end


-- This initializes for both the server and client. Tags can be added here.
local common_postinit = function(inst) 
	-- Minimap icon
    inst.MiniMapEntity:SetIcon("mikoto.tex")
    
    -- 制作书
    inst:AddTag("bookbuilder")
end

-- This initializes for the server only. Components are added here.
local master_postinit = function(inst)
	-- choose which sounds this character will play
	inst.soundsname = "willow"
	
	-- Uncomment if "wathgrithr"(Wigfrid) or "webber" voice is used
    --inst.talker_path_override = "dontstarve_DLC001/characters/"
	
	-- Stats	
	inst.components.health:SetMaxHealth(9999)
	inst.components.hunger:SetMax(9999)
	inst.components.sanity:SetMax(9999)
	
	-- Damage multiplier (optional)
	inst.components.combat.damagemultiplier = 0.6
	
	-- inst:AddTag("electricdamageimmune")--机器人也有这个标签，但不知道有什么用
    inst:AddTag("mikoto")
    inst:ListenForEvent("attacked", OnAttacked)

    -- 可以读书
    inst:AddComponent("reader")

    inst:AddComponent("lootdropper")
	
	-- Hunger rate (optional)
	inst.components.hunger.hungerrate = 1 * TUNING.WILSON_HUNGER_RATE
	
	inst.OnLoad = onload
    inst.OnNewSpawn = onload
	
end

local zap = function (inst)
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local snd = inst.entity:AddSoundEmitter()
    -- inst.Transform:SetFourFaced()

    anim:SetBank("shock_railgun_fx")
    anim:SetBuild("shock_railgun_fx")
    anim:PlayAnimation("electricity")

    inst.entity:AddLight()
    inst.Light:Enable(true)
    inst.Light:SetRadius(2)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.9)
    inst.Light:SetColour(235/255,121/255,12/255)
    
    inst:AddTag("fx")
    inst:ListenForEvent( "animover", function(inst) inst:Remove() end )
    return inst
end

return MakePlayerCharacter("mikoto", prefabs, assets, common_postinit, master_postinit, start_inv)
