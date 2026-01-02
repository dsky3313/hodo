------------------------------
-- 함수
------------------------------
local function DecimalFormat1(value) -- 소수 1자리
    return string.format("%.1f", value)
end

local function PercentFormat(v) -- 백분율 (소수점 첫째자리에서 반올림)
    return ("%d%%"):format(math.floor((v or 0) * 100 + 0.5))
end

-- UI-ChatIcon-Discord
------------------------------
-- 설정창 생성
------------------------------
local function CreateHodoOptions()
    local hodoConfig = CreateFrame("Frame", "HodoConfigFrame", UIParent)
    hodoConfig.name = "1hodo" -- 애드온 메뉴 이름

    local hodoCategory = Settings.RegisterVerticalLayoutCategory(hodoConfig.name)
    Settings.RegisterAddOnCategory(hodoCategory)
    local hodolayout = SettingsPanel:GetLayout(hodoCategory)
    
    -- 프레임 크기
        local FrameScale = CreateSettingsListSectionHeaderInitializer("프레임 크기")
        hodolayout:AddInitializer(FrameScale)

        -- 게임 메뉴
            local GMF_Scale = Settings.RegisterProxySetting(hodoCategory, "HODO_GMF_SCALE", Settings.VarType.Number, 
                "게임 메뉴 크기", 0.9, -- 기본값
                function() 
                    return (hodoDB and hodoDB.GMF_SCALE) or 0.9 end, -- [Getter] 저장된 값이 있으면 쓰고, 없으면 기본값 0.9 사용
                
                function(v) 
                    GameMenuFrame:SetScale(v) -- [Setter] 1. 즉시 적용
                    if not hodoDB then hodoDB = {} end -- [Setter] 2. DB에 저장
                    hodoDB.GMF_SCALE = v
            end)

            local GMF_ScaleSlider = Settings.CreateSliderOptions(0.5, 1.0, 0.05) -- 슬라이더 세부 옵션 (최소 0.5, 최대 1.0, 0.05 단위)
                GMF_ScaleSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, PercentFormat) -- 백분율
                Settings.CreateSlider(hodoCategory, GMF_Scale, GMF_ScaleSlider, "ESC 키를 눌렀을 때 나타나는 게임 메뉴의 크기를 조절합니다.") -- 최종 슬라이더 생성

        -- 말머리
            local THF_Scale = Settings.RegisterProxySetting(hodoCategory, "HODO_THF_SCALE", Settings.VarType.Number, 
                "말머리 크기", 0.8, -- 기본값
                function() 
                    return (hodoDB and hodoDB.THF_SCALE) or 0.8 end, -- [Getter] 저장된 값이 있으면 쓰고, 없으면 기본값 0.8 사용
                function(v) 
                    TalkingHeadFrame:SetScale(v) -- [Setter] 1. 즉시 적용
                    if not hodoDB then hodoDB = {} end -- [Setter] 2. DB에 저장
                    hodoDB.THF_SCALE = v end)
            local THF_ScaleSlider = Settings.CreateSliderOptions(0.5, 1.0, 0.05) -- 슬라이더 세부 옵션 (최소 0.5, 최대 1.0, 0.05 단위)
                THF_ScaleSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, PercentFormat) -- 백분율
                Settings.CreateSlider(hodoCategory, THF_Scale, THF_ScaleSlider, "말머리의 크기를 조절합니다.") -- 최종 슬라이더 생성

        -- 가방
            local BP_Scale = Settings.RegisterProxySetting(hodoCategory, "HODO_BP_SCALE", Settings.VarType.Number, 
                "가방 크기", 0.65, -- 기본값
                function() 
                    return (hodoDB and hodoDB.BP_SCALE) or 0.65 end, -- [Getter] 저장된 값이 있으면 쓰고, 없으면 기본값 0.65 사용
                function(v) 
                    MainMenuBarBackpackButton:SetScale(v) -- [Setter] 1. 즉시 적용
                    if not hodoDB then hodoDB = {} end -- [Setter] 2. DB에 저장
                    hodoDB.BP_SCALE = v end)
            local BP_ScaleSlider = Settings.CreateSliderOptions(0.5, 1.0, 0.05) -- 슬라이더 세부 옵션 (최소 0.5, 최대 1.0, 0.05 단위)
                BP_ScaleSlider:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, PercentFormat) -- 백분율
                Settings.CreateSlider(hodoCategory, BP_Scale, BP_ScaleSlider, "가방의 크기를 조절합니다.") -- 최종 슬라이더 생성

    -- 명령어
        local FrameScale = CreateSettingsListSectionHeaderInitializer("명령어")
        hodolayout:AddInitializer(FrameScale)


        
    return hodoCategory
end



------------------------------
-- 이벤트
------------------------------
local initFrame = CreateFrame("Frame")
initFrame:RegisterEvent("ADDON_LOADED")
initFrame:RegisterEvent("PLAYER_LOGIN")

initFrame:SetScript("OnEvent", function(self, event, arg1)
    if event == "ADDON_LOADED" and arg1 == "1hodo" then
        hodoDB = hodoDB or {} -- DB 초기화
    elseif event == "PLAYER_LOGIN" then
        if hodoDB then 
            if hodoDB.GMF_SCALE then -- 게임 메뉴
                GameMenuFrame:SetScale(hodoDB.GMF_SCALE) end
            if hodoDB.THF_SCALE and TalkingHeadFrame then -- 말머리 프레임
                TalkingHeadFrame:SetScale(hodoDB.THF_SCALE) end
            if hodoDB.BP_SCALE and MainMenuBarBackpackButton then -- 가방 버튼
                MainMenuBarBackpackButton:SetScale(hodoDB.BP_SCALE) end
        end
        CreateHodoOptions() -- 설정창 메뉴 등록
        self:UnregisterAllEvents() -- 사용 완료한 이벤트 해제 (메모리 최적화)
    end
end)