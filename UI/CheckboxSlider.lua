------------------------------
-- 1. 테이블 (원본 유지)
------------------------------
local addonName, ns = ...
local Formatters = {
    ["Percent"] = function(v) return ("%d%%"):format(math.floor((v or 0) * 100 + 0.5)) end,
    ["Integer"] = function(v) return tostring(math.floor((v or 0) + 0.5)) end,
    ["Decimal"] = function(v) return ("%.1f"):format(v or 0) end
}

------------------------------
-- [수정] 스크롤 에러 해결용 이니셜라이저 (XML 대체)
------------------------------
local function HodoCheckboxSliderInitializer(frame, data)
    frame:SetSize(SettingsPanel.Container:GetWidth() - 40, 32)
    if not frame.Checkbox then
        frame.Checkbox = CreateFrame("CheckButton", nil, frame, "SettingsCheckboxTemplate")
        frame.Checkbox:SetPoint("LEFT", 10, 0)
    end
    if not frame.Slider then
        frame.Slider = CreateFrame("Slider", nil, frame, "MinimalSliderWithSteppersTemplate")
        frame.Slider:SetPoint("RIGHT", -40, 0)
        frame.Slider:SetWidth(180)
    end
    if not frame.Text then
        frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.Text:SetPoint("LEFT", frame.Checkbox, "RIGHT", 5, 0)
    end
    frame.Text:SetText(data.name)
    frame.Checkbox:SetChecked(data.cbSetting:GetValue())
    frame.Slider:Init(data.sliderSetting:GetValue(), data.min, data.max, data.step)
    frame.Checkbox:SetScript("OnClick", function(self) data.cbSetting:SetValue(self:GetChecked()) end)
    frame.Slider:RegisterCallback(MinimalSliderWithSteppersMixin.Event.OnValueChanged, function(_, val)
        data.sliderSetting:SetValue(val)
    end)

    return frame
end

------------------------------
-- 2. 체크박스 슬라이더 함수
------------------------------
function CheckboxSlider(category, varNameCB, varNameSlider, label, tooltip, min, max, step, defaultCB, defaultSlider, formatType)
    local varID_CB = "hodo_" .. varNameCB
    local varID_Slider = "hodo_" .. varNameSlider
    
    local cbSetting = Settings.GetSetting(varID_CB) or Settings.RegisterAddOnSetting(category, varID_CB, varNameCB, hodoDB, Settings.VarType.Boolean, label, defaultCB or false)
    local sliderSetting = Settings.GetSetting(varID_Slider) or Settings.RegisterAddOnSetting(category, varID_Slider, varNameSlider, hodoDB, Settings.VarType.Number, label, tonumber(defaultSlider) or min)

    local initializer = Settings.CreateElementInitializer("Frame", {
        name = label, cbSetting = cbSetting, sliderSetting = sliderSetting, min = min, max = max, step = step or 1
    })
    initializer.InitControls = HodoCheckboxSliderInitializer

    local function OnValueChanged()
        if ns.CameraTilt then ns.CameraTilt() end
        if ns.setDifficulty then ns.setDifficulty(true) end
    end
    cbSetting:SetValueChangedCallback(OnValueChanged)
    sliderSetting:SetValueChangedCallback(OnValueChanged)

    local layout = SettingsPanel:GetLayout(category)
    if layout then layout:AddInitializer(initializer) end
    return cbSetting, sliderSetting, initializer
end