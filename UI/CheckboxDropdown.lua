------------------------------
-- 1. 이니셜라이저 생성기
------------------------------
function CreateSettingsCheckboxDropdownInitializer(cbSetting, cbLabel, cbTooltip, dropdownSetting, dropdownOptions, dropdownLabel, dropdownTooltip, newTagID)
    local data = {
        name = cbLabel,
        tooltip = cbTooltip,
        cbSetting = cbSetting,
        cbLabel = cbLabel,
        cbTooltip = cbTooltip,
        dropdownSetting = dropdownSetting,
        dropdownOptions = dropdownOptions,
        dropdownLabel = dropdownLabel,
        dropdownTooltip = dropdownTooltip,
        newTagID = newTagID,
    }
    local initializer = Settings.CreateSettingInitializer("SettingsCheckboxDropdownControlTemplate", data)
    initializer:AddSearchTags(cbLabel, dropdownLabel)
    return initializer
end

------------------------------
-- 2. 체크박스 + 드롭다운 결합 함수
------------------------------
function CheckBoxDropDown(category, varNameCB, varNameDD, label, tooltip, options, defaultCB, defaultDD)
    local varID_CB = "hodo_" .. varNameCB
    local varID_DD = "hodo_" .. varNameDD

    -- [A] 체크박스 설정 등록
    local cbSetting = Settings.GetSetting(varID_CB)
    if not cbSetting then
        cbSetting = Settings.RegisterAddOnSetting(category, varID_CB, varNameCB, hodoDB, Settings.VarType.Boolean, label, defaultCB or false)
    end

    -- [B] 드롭다운 설정 등록
    local ddSetting = Settings.GetSetting(varID_DD)
    if not ddSetting then
        ddSetting = Settings.RegisterAddOnSetting(category, varID_DD, varNameDD, hodoDB, Settings.VarType.String, label, defaultDD or options[1].CheckboxDropdownTextValue)
    end

    -- [C] 드롭다운 옵션 생성기 (InsDifficulty.lua의 키 값에 맞춤)
    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        for _, option in ipairs(options) do
            -- InsDifficulty.lua의 테이블 구조인 CheckboxDropdownTextValue / Text 사용
            container:Add(option.CheckboxDropdownTextValue, option.CheckboxDropdownText)
        end
        return container:GetData()
    end

    -- [D] 이니셜라이저 생성
    local initializer = CreateSettingsCheckboxDropdownInitializer(
        cbSetting, label, tooltip,
        ddSetting, GetOptions, label, tooltip
    )

    -- [E] 공통 콜백 설정
    local function OnValueChanged()
        if ChatBubble then ChatBubble() end
        if Camera then Camera() end
        if FrameScale then FrameScale() end
        if AuctionFilter then AuctionFilter() end
        -- 인스턴스 난이도 즉시 반영을 위해 추가
        if SetInsDifficulty then SetInsDifficulty(true) end 
    end

    cbSetting:SetValueChangedCallback(OnValueChanged)
    ddSetting:SetValueChangedCallback(OnValueChanged)

    -- [F] 레이아웃 추가
    local layout = SettingsPanel:GetLayout(category)
    if layout then
        layout:AddInitializer(initializer)
    end

    return cbSetting, ddSetting, initializer
end