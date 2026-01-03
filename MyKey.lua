local ADDON_NAME, NS = ...
local openRaidLib = LibStub:GetLibrary("LibOpenRaid-1.0", true)

-----------------------------------------------------------------------
-- 1. 데이터 및 유틸리티 (절대 수정 금지)
-----------------------------------------------------------------------
local DungeonAbbr = {
    ["그림 바톨"] = "그림바톨",
    ["보랄러스 공성전"] = "보랄", 
    ["죽음의 상흔"] = "죽상",
    ["티르너 사이드의 안개"] = "티르너", 
    ["속죄의 전당"] = "속죄",
    ["미지의 시장 타자베쉬: 경이의 거리"] = "거리",
    ["미지의 시장 타자베쉬: 소레아의 승부수"] = "승부수",
    ["부화장"] = "부화장",
    ["새벽인도자호"] = "새인호", 
    ["신성한 불꽃의 수도원"] = "수도원", 
    ["작전명: 수문"] = "수문",
    ["실타래의 도시"] = "실타래",
    ["아라카라: 메아리의 도시"] = "아라카라", 
    ["생태지구 알다니"] = "알다니",
    ["잿불맥주 양조장"] = "양조장",
    ["어둠불꽃 동굴"] = "어불동",
}

local function GetShortName(fullName)
    return DungeonAbbr[fullName] or fullName
end

local function GetMyKeyInfo()
    local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local level = C_MythicPlus.GetOwnedKeystoneLevel()
    if mapID and level then
        return C_ChallengeMode.GetMapUIInfo(mapID), level
    end
    return nil, nil
end

-----------------------------------------------------------------------
-- 2. 드롭다운 버튼 설정 (코드 순서 유지 및 위치/너비 수정)
-----------------------------------------------------------------------
local target = LFGListFrame.EntryCreation.ActivityDropdown
local KeyDropDownBtn = CreateFrame("DropdownButton", nil, target, "WowStyle1DropdownTemplate")

-- 너비 175 고정 및 양쪽 정렬 설정 (빼먹지 않고 적용)
KeyDropDownBtn:SetSize(175, 25)
KeyDropDownBtn:SetPoint("TOPLEFT", target, "BOTTOMLEFT", 0, -7)
KeyDropDownBtn:SetPoint("TOPRIGHT", target, "BOTTOMRIGHT", 0, -7)

-- [중요] ActivityDropdown이 숨겨지거나 크기가 0이 될 때 물리적으로 숨김 처리
target:HookScript("OnShow", function() KeyDropDownBtn:Show() end)
target:HookScript("OnHide", function() KeyDropDownBtn:Hide() end)
target:HookScript("OnSizeChanged", function(self, width, height)
    if height <= 1 then KeyDropDownBtn:Hide() else KeyDropDownBtn:Show() end
end)

-----------------------------------------------------------------------
-- 3. 복사 다이얼로그 생성 (나중에 정의)
-----------------------------------------------------------------------
local function CreateCopyDialog()
    local frame = CreateFrame("Frame", "HodoCopyDialog", UIParent)
    frame:SetSize(350, 110)
    frame:SetPoint("CENTER", 0, 150)
    frame:SetFrameStrata("DIALOG")
    frame:SetToplevel(true)
    frame:EnableMouse(true)
    frame:Hide()

    NineSliceUtil.ApplyLayoutByName(frame, "Dialog")
    frame.Bg = frame:CreateTexture(nil, "BACKGROUND")
    frame.Bg:SetPoint("TOPLEFT", 8, -8)
    frame.Bg:SetPoint("BOTTOMRIGHT", -8, 8)
    frame.Bg:SetAtlas("UI-DialogBox-Background-Dark")
    frame.Bg:SetAlpha(0.8)

    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.text:SetPoint("TOP", 0, -25)
    frame.text:SetText("Ctrl+C로 복사하면 자동으로 닫힙니다")

    frame.editBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    frame.editBox:SetSize(260, 30)
    frame.editBox:SetPoint("CENTER", 0, -5)
    frame.editBox:SetAutoFocus(false)

    frame.editBox:SetScript("OnKeyDown", function(self, key)
        if key == "C" and IsControlKeyDown() then
            C_Timer.After(0.1, function()
                frame:Hide()
                local nameBox = LFGListFrame.EntryCreation.Name
                if nameBox and nameBox:IsVisible() then
                    nameBox:SetFocus()
                    nameBox:HighlightText()
                end
            end)
        end
    end)

    frame.editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
    return frame
end

local CopyDialog = CreateCopyDialog()

local function ShowCopyWindow(text)
    CopyDialog:Show()
    CopyDialog.editBox:SetText(text)
    CopyDialog.editBox:SetFocus()
    CopyDialog.editBox:HighlightText()
end

-----------------------------------------------------------------------
-- 4. 메뉴 구성 및 자동 관리
-----------------------------------------------------------------------
KeyDropDownBtn:SetupMenu(function(dropdown, rootDescription)
    if InCombatLockdown() then return end

    local myName, myLevel = GetMyKeyInfo()
    if myName then
        local myTitle = string.format("+%d %s", myLevel, GetShortName(myName))
        rootDescription:CreateButton("|cff00ff00[내 돌]|r " .. myTitle, function() ShowCopyWindow(myTitle) end)
    end

    if IsInGroup() and openRaidLib then
        local allKeys = openRaidLib.GetAllKeystonesInfo()
        for name, data in pairs(allKeys) do
            if name ~= UnitName("player") then
                local pName = name:gsub("%-.+", "")
                local dName = C_ChallengeMode.GetMapUIInfo(data.challengeMapID)
                local pTitle = string.format("+%d %s", data.level, GetShortName(dName))
                rootDescription:CreateButton(string.format("|cff00ccff[%s]|r %s", pName, pTitle), function() ShowCopyWindow(pTitle) end)
            end
        end
    end
end)

LFGListFrame.EntryCreation:HookScript("OnHide", function()
    if KeyDropDownBtn:IsMenuOpen() then KeyDropDownBtn:CloseMenu() end
    if CopyDialog:IsVisible() then CopyDialog:Hide() end
end)

local function Refresh()
    if InCombatLockdown() or not target:IsVisible() then return end
    local name, level = GetMyKeyInfo()
    if name then
        KeyDropDownBtn:SetText(string.format("+%d %s", level, GetShortName(name)))
    else
        KeyDropDownBtn:SetText("보유 돌 없음")
    end
end

local EventFrame = CreateFrame("Frame")
EventFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
EventFrame:RegisterEvent("GROUP_ROSTER_UPDATE")
EventFrame:RegisterEvent("PLAYER_REGEN_ENABLED")
EventFrame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_ENABLED" then Refresh() return end
    if openRaidLib then openRaidLib.RequestKeystoneDataFromParty() end
    Refresh()
end)

LFGListFrame.EntryCreation:HookScript("OnShow", function()
    if InCombatLockdown() then
        KeyDropDownBtn:SetAlpha(0.5)
        KeyDropDownBtn:Disable()
    else
        KeyDropDownBtn:SetAlpha(1)
        KeyDropDownBtn:Enable()
        -- 창이 열릴 때 target의 가시성에 맞춰 즉시 결정
        KeyDropDownBtn:SetShown(target:IsVisible() and target:GetHeight() > 0)
        Refresh()
    end
end)