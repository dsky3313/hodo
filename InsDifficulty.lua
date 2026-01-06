------------------------------
-- 테이블
------------------------------
InsDifficultyDungeonOption = {
    {CheckboxDropdownText="일반", CheckboxDropdownTextValue="1"},
    {CheckboxDropdownText="영웅", CheckboxDropdownTextValue="2"},
    {CheckboxDropdownText="신화", CheckboxDropdownTextValue="23"}
}

InsDifficultyRaidOption = {
    {CheckboxDropdownText="일반", CheckboxDropdownTextValue="14"},
    {CheckboxDropdownText="영웅", CheckboxDropdownTextValue="15"},
    {CheckboxDropdownText="신화", CheckboxDropdownTextValue="16"}
}

InsDifficultyLegacyOption = {
    {CheckboxDropdownText="10인", CheckboxDropdownTextValue="3"},
    {CheckboxDropdownText="25인", CheckboxDropdownTextValue="4"}
}


------------------------------
-- 인스턴스 난이도
------------------------------
-- InsDifficultyValue -> InsDifficultyText
function GetInsDifficultyName(id)
    if not id then return "미설정" end
    local idStr = tostring(id)
    local tables = { InsDifficultyDungeonOption, InsDifficultyRaidOption, InsDifficultyLegacyOption }
    for _, tbl in ipairs(tables) do
        for _, v in ipairs(tbl) do
            if v.CheckboxDropdownTextValue == idStr then return v.CheckboxDropdownText end
        end
    end
    return GetDifficultyInfo(id) or "기타("..idStr..")"
end

-- 인스턴스 난이도 설정, 알림
function SetInsDifficulty(silent)
    if InCombatLockdown() or IsInInstance() or not hodoDB then return end

    local useInsDifficultyDungeon = (hodoDB.useInsDifficultyDungeon == nil and true) or hodoDB.useInsDifficultyDungeon
    local useInsDifficultyRaid    = (hodoDB.useInsDifficultyRaid == nil and true) or hodoDB.useInsDifficultyRaid
    local useInsDifficultyLegacy  = (hodoDB.useInsDifficultyLegacy == nil and true) or hodoDB.useInsDifficultyLegacy

    local InsDifficultyDungeon = hodoDB.InsDifficultyDungeon or "23"
    local InsDifficultyRaid    = hodoDB.InsDifficultyRaid or "16"
    local InsDifficultyLegacy  = hodoDB.InsDifficultyLegacy or "4"

    -- 현재 설정값 확인
    local currntInsDifficultyDungeon = GetDungeonDifficultyID()
    local currntInsDifficultyRaid = select(1, GetRaidDifficultyID())
    local currntInsDifficultyLegacy = GetLegacyRaidDifficultyID()

    -- 변경 실행
    if useInsDifficultyDungeon and currntInsDifficultyDungeon ~= tonumber(InsDifficultyDungeon) then SetDungeonDifficultyID(tonumber(InsDifficultyDungeon)) end
    if useInsDifficultyRaid and currntInsDifficultyRaid ~= tonumber(InsDifficultyRaid) then SetRaidDifficulties(true, tonumber(InsDifficultyRaid)) end
    if useInsDifficultyLegacy and currntInsDifficultyLegacy ~= tonumber(InsDifficultyLegacy) then SetRaidDifficulties(false, tonumber(InsDifficultyLegacy)) end

    -- 알림 메시지 생성
    if not silent then
        local msgInsDifficultyDungeon = useInsDifficultyDungeon and GetInsDifficultyName(InsDifficultyDungeon) or GetInsDifficultyName(currntInsDifficultyDungeon)
        local msgInsDifficultyRaid = useInsDifficultyRaid and GetInsDifficultyName(InsDifficultyRaid) or GetInsDifficultyName(currntInsDifficultyRaid)
        local msgInsDifficultyLegacy = useInsDifficultyLegacy and GetInsDifficultyName(InsDifficultyLegacy) or GetInsDifficultyName(currntInsDifficultyLegacy)

        local msg = string.format("|cff00ff00[인스]|r 던전:%s, 레이드:%s, 낭만:%s", msgInsDifficultyDungeon, msgInsDifficultyRaid, msgInsDifficultyLegacy)

        if IsInGroup(LE_PARTY_CATEGORY_HOME) then
            SendChatMessage(msg, "PARTY")
        else
            print(msg)
        end
    end
end


------------------------------
-- 인스턴스 난이도
------------------------------
local initInsDifficulty = CreateFrame("Frame")
initInsDifficulty:RegisterEvent("PLAYER_LOGIN")
initInsDifficulty:RegisterEvent("PARTY_LEADER_CHANGED")
initInsDifficulty:RegisterEvent("GROUP_ROSTER_UPDATE")

local lastLeaderState = false
initInsDifficulty:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        C_Timer.After(1, function()
            lastLeaderState = UnitIsGroupLeader("player")
            SetInsDifficulty(false)
        end)
    else
        if not IsInInstance() and not InCombatLockdown() then
            local isLeader = UnitIsGroupLeader("player")
            if isLeader then
                local silent = (isLeader == lastLeaderState)
                SetInsDifficulty(silent)
            end
            lastLeaderState = isLeader
        end
    end
end)