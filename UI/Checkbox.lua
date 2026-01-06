------------------------------
-- 체크박스
------------------------------
function Checkbox(category, varName, label, tooltip, default)
    local varID = "hodo_" .. varName

    local setting = Settings.GetSetting(varID)
        if not setting then
            setting = Settings.RegisterAddOnSetting(category, varID, varName, hodoDB, Settings.VarType.Boolean, label, default)
        end

    local initializer = Settings.CreateControlInitializer("SettingsCheckboxControlTemplate", setting, nil, tooltip)
        setting:SetValueChangedCallback(function()
            if AuctionFilter then AuctionFilter() end
        end)

    local layout = SettingsPanel:GetLayout(category)
        if layout then
            layout:AddInitializer(initializer)
        end
    return setting, initializer
end