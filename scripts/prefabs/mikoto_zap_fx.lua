local assets = {
    Asset("ANIM","anim/mikoto_zap_fx.zip"),
    Asset("ANIM", "anim/shock_fx.zip"),
}
local zap_small = function (inst)  --被动2
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    --local snd = inst.entity:AddSoundEmitter()
    anim:SetBank("mikoto_zap_fx")
    anim:SetBuild("mikoto_zap_fx")
    anim:PlayAnimation("zap"..math.random(3))
    inst.entity:AddLight()
    inst.Light:Enable(true)
    inst.Light:SetRadius(1.5)
    inst.Light:SetFalloff(1)
    inst.Light:SetIntensity(.9)
    inst.Light:SetColour(235/255,121/255,12/255)
    
    inst.Transform:SetScale(1.5,1.5,1.5)
    inst:AddTag("fx")
    inst:ListenForEvent("animover", function(inst) inst:Remove() end )
    return inst
end

local function newfn() --被动1
    local inst = CreateEntity()
    local trans = inst.entity:AddTransform()
    local anim = inst.entity:AddAnimState()
    local snd = inst.entity:AddSoundEmitter()
    inst.Transform:SetFourFaced()
    anim:SetBank("shock_fx")
    anim:SetBuild("shock_fx")
    anim:PlayAnimation("shock")
    --snd:PlaySound("dontstarve_DLC001/common/shocked")
    inst:AddTag("fx")
    inst:ListenForEvent("animover", function(inst) inst:Remove() end )
    return inst
end
return
Prefab("common/fx/shock_fx_soundless", newfn, assets),
Prefab("mikoto_zap_small",zap_small,assets,prefabs)