local addonName, ns = ...

-- [오류 해결: 프레임을 생성하고 시스템에 반환하는 초기화 함수]
local function HodoCheckboxDropdownInitializer(frame, data)
    -- 스크롤 시스템을 위한 높이 설정
    frame:SetFixedSize(SettingsPanel.Container:GetWidth() - 40, 32)
    
    -- 1. 체크박스 생성
    if not frame.Checkbox then
        frame.Checkbox = CreateFrame("CheckButton", nil, frame, "SettingsCheckboxTemplate")
        frame.Checkbox:SetPoint("LEFT", 10, 0)
    end
    
    -- 2. 드롭다운 버튼 생성
    if not frame.Control then
        frame.Control = CreateFrame("DropdownButton", nil, frame, "WowStyle1DropdownTemplate")
        frame.Control:SetPoint("RIGHT", -10, 0)
        frame.Control:SetWidth(150)
    end -- [수정] 원본 코드에서 누락되었던 end 추가
    
    -- 3. 텍스트 라벨 생성
    if not frame.Text then
        frame.Text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        frame.Text:SetPoint("LEFT", frame.Checkbox, "RIGHT", 5, 0)
    end

    -- 4. 데이터 및 동작 연결
    frame.Text:SetText(data.name)
    frame.Checkbox:SetChecked(data.cbSetting:GetValue())
    frame.Checkbox:SetScript("OnClick", function(self) 
        data.cbSetting:SetValue(self:GetChecked()) 
    end)

    frame.Control:SetupMenu(function(dropdown, rootDescription)
        local options = data.dropdownOptions()
        if options then
            for _, opt in ipairs(options) do
                rootDescription:CreateButton(opt.label, function()
                    data.dropdownSetting:SetValue(opt.value)
                    frame.Control:SetText(opt.label)
                end)
            end
        end
    end)

    -- 현재 선택된 값 표시 업데이트
    local currentVal = data.dropdownSetting:GetValue()
    local options = data.dropdownOptions()
    local found = false
    if options then
        for _, opt in ipairs(options) do
            if opt.value == currentVal then 
                frame.Control:SetText(opt.label) 
                found = true
                break 
            end
        end
    end
    if not found then frame.Control:SetText("선택하세요") end

    -- [핵심] 생성된 프레임을 리턴 (에러 해결 지점)
    return frame
end

-- [이니셜라이저 생성 함수]
function CreateHodoInitializer(cbSetting, cbLabel, cbTooltip, dropdownSetting, dropdownOptions)
    local initializer = Settings.CreateElementInitializer(nil, {
        name = cbLabel,
        tooltip = cbTooltip,
        cbSetting = cbSetting,
        dropdownSetting = dropdownSetting,
        dropdownOptions = dropdownOptions,
    })
    
    -- 루아 초기화 함수 연결
    initializer.InitControls = HodoCheckboxDropdownInitializer
    return initializer
end

-- [메인 등록 함수]
function CheckBoxDropDown(category, varNameCB, varNameDD, label, tooltip, options, defaultCB, defaultDD, func)
    local varID_CB = "hodo_" .. varNameCB
    local varID_DD = "hodo_" .. varNameDD

    -- 설정값 가져오기 또는 등록
    local cbSetting = Settings.GetSetting(varID_CB) or Settings.RegisterAddOnSetting(category, varID_CB, varNameCB, hodoDB, Settings.VarType.Boolean, label, defaultCB or false)
    
    local fallbackValue = (options and options[1]) and options[1].value or ""
    local ddSetting = Settings.GetSetting(varID_DD) or Settings.RegisterAddOnSetting(category, varID_DD, varNameDD, hodoDB, Settings.VarType.String, label, defaultDD or fallbackValue)

    -- 옵션 데이터 컨테이너
    local function GetOptions()
        local container = Settings.CreateControlTextContainer()
        if options then
            for _, option in ipairs(options) do
                container:Add(option.value, option.label)
            end
        end
        return container:GetData()
    end

    local initializer = CreateHodoInitializer(cbSetting, label, tooltip, ddSetting, GetOptions)

    -- 콜백 연결
    local function OnValueChanged()
        if func then func() end
    end

    cbSetting:SetValueChangedCallback(OnValueChanged)
    ddSetting:SetValueChangedCallback(OnValueChanged)

    local layout = SettingsPanel:GetLayout(category)
    if layout and initializer then
        layout:AddInitializer(initializer)
    end

    return cbSetting, initializer
end