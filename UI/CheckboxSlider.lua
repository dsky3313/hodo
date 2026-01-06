------------------------------
-- 테이블
------------------------------
local Formatters = {
    ["Percent"] = function(v) 
        return ("%d%%"):format(math.floor((v or 0) * 100 + 0.5)) 
    end,

    ["Integer"] = function(v) 
        return tostring(math.floor((v or 0) + 0.5)) 
    end,

    ["Decimal"] = function(v)
        return ("%.1f"):format(v or 0)
    end
}

------------------------------
-- 체크박스 + 슬라이더
------------------------------
function CreateSettingsCheckboxSliderInitializer(cbSetting, cbLabel, cbTooltip, sliderSetting, sliderOptions, sliderLabel, sliderTooltip, newTagID)
    local data = {
        name = cbLabel,
        tooltip = cbTooltip,
        cbSetting = cbSetting,
        cbLabel = cbLabel,
        cbTooltip = cbTooltip,
        sliderSetting = sliderSetting,
        sliderOptions = sliderOptions,
        sliderLabel = sliderLabel,
        sliderTooltip = sliderTooltip,
        newTagID = newTagID,
    }
    -- 블리자드 표준 템플릿 사용
    local initializer = Settings.CreateSettingInitializer("SettingsCheckboxSliderControlTemplate", data)
    initializer:AddSearchTags(cbLabel, sliderLabel)
    return initializer
end

------------------------------
-- 3. 체크박스 + 슬라이더 결합 함수
------------------------------
function CheckboxSlider(category, varNameCB, varNameSlider, label, tooltip, min, max, step, defaultCB, defaultSlider, formatType)
    local varID_CB = "hodo_" .. varNameCB
    local varID_Slider = "hodo_" .. varNameSlider

    -- [A] 체크박스 설정 등록
    local cbSetting = Settings.GetSetting(varID_CB)
    if not cbSetting then
        cbSetting = Settings.RegisterAddOnSetting(category, varID_CB, varNameCB, hodoDB, Settings.VarType.Boolean, label, defaultCB or false)
    end

    -- [B] 슬라이더 설정 등록
    local sliderSetting = Settings.GetSetting(varID_Slider)
    if not sliderSetting then
    local safeDefault = tonumber(defaultSlider) or min
    sliderSetting = Settings.RegisterAddOnSetting(category, varID_Slider, varNameSlider, hodoDB, Settings.VarType.Number, label, safeDefault)
    end
    
    -- [C] 슬라이더 옵션 및 포맷터 설정
    local sliderOptions = Settings.CreateSliderOptions(min, max, step)
    local selectedFormatter = Formatters[formatType] or Formatters["Integer"]
    sliderOptions:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, selectedFormatter)

    -- [D] 이니셜라이저 생성
    local initializer = CreateSettingsCheckboxSliderInitializer(
        cbSetting, label, tooltip,
        sliderSetting, sliderOptions, label, tooltip
    )

    -- [E] 공통 콜백 설정
    local function OnValueChanged()
        if ChatBubble then ChatBubble() end
        if Camera then Camera() end
        if FrameScale then FrameScale() end
        if AuctionFilter then AuctionFilter() end
        if SetInsDifficulty then SetInsDifficulty(true) end
    end

    cbSetting:SetValueChangedCallback(OnValueChanged)
    sliderSetting:SetValueChangedCallback(OnValueChanged)

    -- [F] 레이아웃 추가
    local layout = SettingsPanel:GetLayout(category)
    if layout then
        layout:AddInitializer(initializer)
    end

    return cbSetting, sliderSetting, initializer
end