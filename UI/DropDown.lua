------------------------------
-- 드롭다운 함수 (최종 순정 규격)
------------------------------
function DropDown(category, varName, label, tooltip, options, default)
    local varID = "hodo_" .. varName
    
    -- [A] 설정 등록
    local setting = Settings.GetSetting(varID)
    if not setting then
        -- 폰트 경로는 문자열이므로 Settings.VarType.String
        setting = Settings.RegisterAddOnSetting(category, varID, varName, hodoDB, Settings.VarType.String, label, default or options[1].value)
    end

    -- [B] 옵션 생성 (보내주신 소스의 CreateControlTextContainer 방식)
    local function GetOptions()
        -- 소스 코드와 동일하게 Container 생성
        local container = Settings.CreateControlTextContainer()
        for _, option in ipairs(options) do
            -- Add(값, 라벨, 툴팁) 순서입니다. 툴팁은 생략 가능합니다.
            container:Add(option.value, option.label)
        end
        return container:GetData()
    end

    -- [C] 이니셜라이저 생성
    local initializer = Settings.CreateControlInitializer("SettingsDropDownControlTemplate", setting, GetOptions, tooltip)

    -- [D] 값 변경 콜백
    setting:SetValueChangedCallback(function()
        if ChatBubble then ChatBubble() end
        if Camera then Camera() end
        if FrameScale then FrameScale() end
        if AuctionFilter then AuctionFilter() end
    end)

    -- [E] 레이아웃에 추가
    local layout = SettingsPanel:GetLayout(category)
    if layout then
        layout:AddInitializer(initializer)
    end

    return setting, initializer
end