------------------------------
-- 테이블
------------------------------
local addonName, ns = ...

local UnitName, IsInGroup, C_ChallengeMode, SendChatMessage, C_Timer = UnitName, IsInGroup, C_ChallengeMode, SendChatMessage, C_Timer
local partyMembers = {}

local function GetLib()
    return LibStub and LibStub:GetLibrary("LibOpenRaid-1.0", true)
end


------------------------------
-- 디스플레이
------------------------------
local KeyRollFrame = CreateFrame("Frame", "KeyRollFrame", UIParent)
KeyRollFrame:SetSize(500, 300)
KeyRollFrame:SetPoint("TOP", 0, -100)
KeyRollFrame:Hide()

KeyRollFrame.textTitle = KeyRollFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalHugeOutline")
KeyRollFrame.textTitle:SetPoint("TOPLEFT", KeyRollFrame, "TOPLEFT", 0, 0)
KeyRollFrame.textTitle:SetText("[ 파티 쐐기돌 ]")
KeyRollFrame.textTitle:SetTextColor(0.41, 0.8, 0.94)

KeyRollFrame.textMember = KeyRollFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLargeOutline")
KeyRollFrame.textMember:SetPoint("TOPLEFT", KeyRollFrame.textTitle, "BOTTOMLEFT", 0, -15) -- 제목 아래 15픽셀 지점
KeyRollFrame.textMember:SetTextColor(1, 1, 1)
KeyRollFrame.textMember:SetSpacing(6)

------------------------------
-- 동작
------------------------------
local function GetDungeonName(mapID)
    if not mapID or mapID == 0 then return "알 수 없음" end
    local name = C_ChallengeMode.GetMapUIInfo(mapID)
    if not name or name == "" then
        local mapInfo = C_Map.GetMapInfo(mapID)
        name = mapInfo and mapInfo.name or ("던전(" .. mapID .. ")")
    end
    return name
end

local function GetKeyLink(keystone)
    if not keystone or not keystone.level or keystone.level <= 0 then
        return "|cff808080쐐기돌 없음|r"
    end

    local mapID = keystone.challengeMapID or keystone.mythicPlusMapID
    local name = GetDungeonName(mapID)
    return string.format("+%d %s", keystone.level, name)
end

local function UpdateDisplay()
    local LibOpenRaid = GetLib()
    if not LibOpenRaid then return end

    wipe(partyMembers)
    partyMembers[1] = "player"
    local num = GetNumGroupMembers()
    if num > 1 then
        for i = 1, num - 1 do partyMembers[i + 1] = "party" .. i end
    end

    local displayText = ""
    local found = false

    for _, unit in ipairs(partyMembers) do
        local info = LibOpenRaid.GetKeystoneInfo(unit)
        local uName = UnitName(unit)
        local _, class = UnitClass(unit)
        local color = (RAID_CLASS_COLORS[class] and RAID_CLASS_COLORS[class].colorStr) or "ffffffff"

        if info then
            displayText = displayText .. string.format("|c%s%s|r: %s\n", color, uName, GetKeyLink(info))
            found = true
        end
    end

    if not found then
        displayText = "|cff808080수집된 정보가 없습니다.|r"
    end

    KeyRollFrame.textMember:SetText(displayText)
    KeyRollFrame:Show()
end

------------------------------
-- 이벤트
------------------------------
local initKeyRoll = CreateFrame("Frame")
initKeyRoll:RegisterEvent("CHALLENGE_MODE_COMPLETED")
initKeyRoll:SetScript("OnEvent", function(self, event)
    if event == "CHALLENGE_MODE_COMPLETED" then
        C_Timer.After(2, function()
            local _, _, _, onTime = C_ChallengeMode.GetCompletionInfo()
            if onTime then
                UpdateDisplay()
                C_Timer.After(5, function()
                    if IsInGroup() then SendChatMessage("돌 굴리세요!", "YELL") end
                    C_Timer.After(30, function() KeyRollFrame:Hide() end)
                end)
            end
        end)
    end
end)