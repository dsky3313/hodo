local ADDON_NAME, NS = ...
local openRaidLib = LibStub:GetLibrary("LibOpenRaid-1.0", true)

-- 1. 던전 이름 축약 테이블
local DungeonAbbr = {
    ["티르너 사이드의 안개"] = "티르너",
    ["죽음의 상흔"] = "죽상",
    ["보랄러스 공성전"] = "보랄",
    ["그림 바톨"] = "그림바톨",
    ["속죄의 전당"] = "속죄",
    ["바위금고"] = "거리",
    ["바위금고"] = "승부수",

    ["바위금고"] = "바위금고",
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

-----------------------------------------------------------------------
-- 2. 메인 드롭다운 버튼 (ActivityDropdown과 사이즈 강제 동기화)
-----------------------------------------------------------------------
local KeyDropDownBtn = CreateFrame("DropdownButton", "MDT_KeyTrackerDropDown", LFGListFrame.EntryCreation, "WowStyle1DropdownTemplate")

-- [사이즈 동기화 핵심] 
-- 상단 드롭다운의 왼쪽(LEFT)과 오른쪽(RIGHT) 지점을 기준으로 고정하여 가로 길이를 100% 일치시킵니다.
local target = LFGListFrame.EntryCreation.ActivityDropdown
KeyDropDownBtn:SetPoint("TOPLEFT", target, "BOTTOMLEFT", 0, -7)
KeyDropDownBtn:SetPoint("TOPRIGHT", target, "BOTTOMRIGHT", 0, -7)
-- 세로 높이만 표준인 25로 고정합니다.
KeyDropDownBtn:SetHeight(25)

local function GetMyKeyInfo()
    local mapID = C_MythicPlus.GetOwnedKeystoneChallengeMapID()
    local level = C_MythicPlus.GetOwnedKeystoneLevel()
    if mapID and level then
        return C_ChallengeMode.GetMapUIInfo(mapID), level
    end
    return nil, nil
end

-----------------------------------------------------------------------
-- 3. 복사 전용 다이얼로그 및 기능
-----------------------------------------------------------------------
local function CreateCopyDialog()
    local frame = CreateFrame("Frame", "MDT_CopyDialog", UIParent, "BackdropTemplate")
    frame:SetSize(350, 110)
    frame:SetPoint("CENTER", 0, 150)
    frame:SetFrameStrata("DIALOG")
    frame:SetToplevel(true)
    frame:EnableMouse(true)
    frame:Hide()

    frame:SetBackdrop({
        bgFile = "Interface\\Buttons\\WHITE8X8",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    frame:SetBackdropColor(0, 0, 0, 0.9)

    frame.text = frame:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    frame.text:SetPoint("TOP", 0, -25)
    frame.text:SetText("Ctrl+C를 누르면 복사 후 자동으로 닫힙니다")

    frame.editBox = CreateFrame("EditBox", nil, frame, "InputBoxTemplate")
    frame.editBox:SetSize(260, 30)
    frame.editBox:SetPoint("CENTER", 0, -5)
    frame.editBox:SetAutoFocus(false)

    frame.editBox:SetScript("OnKeyDown", function(self, key)
        if key == "C" and IsControlKeyDown() then
            C_Timer.After(0.1, function()
                frame:Hide()
                local nameBox = LFGListFrame.EntryCreation.Name
                if nameBox then
                    nameBox:SetFocus()
                    nameBox:HighlightText()
                end
            end)
        end
    end)

    frame.editBox:SetScript("OnEscapePressed", function() frame:Hide() end)
    frame.editBox:SetScript("OnEnterPressed", function() frame:Hide() end)

    frame.closeBtn = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate")
    frame.closeBtn:SetSize(80, 22)
    frame.closeBtn:SetText(DONE)
    frame.closeBtn:SetPoint("BOTTOM", 0, 15)
    frame.closeBtn:SetScript("OnClick", function() frame:Hide() end)

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
-- 4. 메뉴 구성 및 이벤트
-----------------------------------------------------------------------
KeyDropDownBtn:SetupMenu(function(dropdown, rootDescription)
    rootDescription:SetTag("MDT_KEY_MENU")

    local myName, myLevel = GetMyKeyInfo()
    if myName then
        local myShort = GetShortName(myName)
        local myTitle = string.format("+%d %s", myLevel, myShort)
        rootDescription:CreateButton("|cff00ff00[내 돌]|r " .. myTitle, function()
            ShowCopyWindow(myTitle)
        end)
    end

    if IsInGroup() and openRaidLib then
        local allKeys = openRaidLib.GetAllKeystonesInfo()
        for name, data in pairs(allKeys) do
            if name ~= UnitName("player") then
                local pName = name:gsub("%-.+", "")
                local dName = C_ChallengeMode.GetMapUIInfo(data.challengeMapID)
                local dShort = GetShortName(dName)
                local pTitle = string.format("+%d %s", data.level, dShort)
                rootDescription:CreateButton(string.format("|cff00ccff[%s]|r %s", pName, pTitle), function()
                    ShowCopyWindow(pTitle)
                end)
            end
        end
    end
end)

local function RefreshButtonText()
    local name, level = GetMyKeyInfo()
    if name then
        KeyDropDownBtn:SetText(string.format("+%d %s", level, GetShortName(name)))
    else
        KeyDropDownBtn:SetText("보유 돌 없음")
    end
end

local f = CreateFrame("Frame")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:SetScript("OnEvent", function()
    if openRaidLib then openRaidLib.RequestKeystoneDataFromParty() end
    RefreshButtonText()
end)

LFGListFrame.EntryCreation:HookScript("OnShow", RefreshButtonText)