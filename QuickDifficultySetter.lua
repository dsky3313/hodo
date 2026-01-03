-----------------------------------------------------------
-- 1. [설정 및 ID 테이블]
-----------------------------------------------------------
local CONFIG = { 
    dungeon = 3, 
    raid = 3,    
    legacy = 2   
}

local IDS = {
    dungeon = { [1] = 1,  [2] = 2,  [3] = 23 },
    raid    = { [1] = 14, [2] = 15, [3] = 16 },
    legacy  = { [1] = 3,  [2] = 4 }
}

local NAMES = {
    dungeon = { [1] = "일반", [2] = "영웅", [3] = "신화" },
    raid    = { [1] = "일반", [2] = "영웅", [3] = "신화" },
    legacy  = { [1] = "10인", [2] = "25인" }
}

local amILeader = false

-----------------------------------------------------------
-- 2. [메인 프레임 설정]
-----------------------------------------------------------
local f = CreateFrame("Frame", "QuickDiffSelectorBar", UIParent)
f:SetSize(320, 170) 
f:SetPoint("TOPLEFT", 30, -30)
f:Hide()

-----------------------------------------------------------
-- 3. [UI 생성 함수]
-----------------------------------------------------------

-- 1. 라벨 행 생성
local function CreateRow(parent, yOffset, titleText)
    local row = CreateFrame("Frame", nil, parent)
    row:SetSize(300, 40)
    row:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, yOffset)

    row.labelBg = row:CreateTexture(nil, "ARTWORK")
    row.labelBg:SetSize(60, 30)
    row.labelBg:SetPoint("LEFT", row, "LEFT", 0, 0)
    row.labelBg:SetAtlas("UI-Character-Info-Title", false)

    row.title = row:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    row.title:SetPoint("CENTER", row.labelBg, "CENTER", 0, 0)
    row.title:SetText(titleText)
    row.title:SetTextColor(1, 1, 1)
    row.title:SetFont(row.title:GetFont(), 12, "OUTLINE")

    row.bgBar = row:CreateTexture(nil, "BACKGROUND")
    row.bgBar:SetSize(220, 45)
    row.bgBar:SetPoint("LEFT", row.labelBg, "RIGHT", -50, 0)
    row.bgBar:SetAtlas("legionmission-hearts-background", false)
    row.bgBar:SetAlpha(0.6)

    return row
end

-- 2. 난이도 선택 버튼 생성
local function CreateButton(parentRow, xOffset, label)
    local btn = CreateFrame("Button", nil, parentRow, "SecureActionButtonTemplate")
    btn:SetSize(65, 25)
    btn:SetPoint("LEFT", parentRow, "LEFT", 60 + xOffset, 0)
    
    btn.selectTex = btn:CreateTexture(nil, "OVERLAY")
    btn.selectTex:SetAtlas("common-button-tertiary-selected", true)
    btn.selectTex:SetScale(0.5) 
    btn.selectTex:SetPoint("CENTER", btn, "CENTER", -4, 0)
    btn.selectTex:Hide()

    btn.hoverTex = btn:CreateTexture(nil, "HIGHLIGHT")
    btn.hoverTex:SetAllPoints()
    btn.hoverTex:SetAtlas("glues-characterSelect-nameBG")
    btn.hoverTex:SetAlpha(0.7)

    btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    btn.text:SetPoint("CENTER", btn, "CENTER", 0, 0) 
    btn.text:SetText(label)
    btn.text:SetFont(btn.text:GetFont(), 12, "OUTLINE")
    
    return btn
end

-- 3. 인스 초기화 버튼 생성 (자동 크기 조절형)
local function CreateResetButton(parent)
    local btn = CreateFrame("Button", nil, parent, "UIPanelButtonTemplate")
    
    -- 텍스트 설정
    btn:SetText("초기화")
    
    -- 텍스트 객체(FontString) 추출 및 너비 계산
    local fs = btn:GetFontString()
    if fs then
        fs:SetFont(fs:GetFont(), 11, "OUTLINE")
        local textWidth = fs:GetStringWidth() -- 에러 해결 포인트
        btn:SetSize(textWidth + 25, 26)
    else
        btn:SetSize(120, 26)
    end
    
    -- 부모(f) 기준 위치 설정 (수치 유지)
    btn:SetPoint("TOPLEFT", parent, "TOPLEFT", 0, -130)
    
    btn:SetScript("OnClick", function()
        StaticPopup_Show("CONFIRM_RESET_INSTANCES")
    end)
    
    return btn
end

-----------------------------------------------------------
-- 4. [UI 배치]
-----------------------------------------------------------
local rowD = CreateRow(f, 0, "던전")
f.btnD1 = CreateButton(rowD, 0, "일반"); f.btnD2 = CreateButton(rowD, 40, "영웅"); f.btnD3 = CreateButton(rowD, 80, "신화")

local rowR = CreateRow(f, -45, "공격대")
f.btnR1 = CreateButton(rowR, 0, "일반"); f.btnR2 = CreateButton(rowR, 40, "영웅"); f.btnR3 = CreateButton(rowR, 80, "신화")

local rowL = CreateRow(f, -90, "낭만")
f.btnL1 = CreateButton(rowL, 15, "10인"); f.btnL2 = CreateButton(rowL, 65, "25인")

-- 인스 초기화 버튼
f.resetBtn = CreateResetButton(f)

-----------------------------------------------------------
-- 5. [핵심 로직]
-----------------------------------------------------------

local function RefreshSelection()
    local curD = GetDungeonDifficultyID()
    local curR = GetRaidDifficultyID()
    local curL = GetLegacyRaidDifficultyID()

    local function UpdateBtn(btn, cat, idx)
        local isSelected = IDS[cat][idx] == ((cat=="dungeon" and curD) or (cat=="raid" and curR) or (cat=="legacy" and curL))
        if isSelected then
            btn.text:SetTextColor(1, 1, 1)
            btn.selectTex:Show()
        else
            btn.text:SetTextColor(1, 0.8, 0)
            btn.selectTex:Hide()
        end
    end

    UpdateBtn(f.btnD1, "dungeon", 1); UpdateBtn(f.btnD2, "dungeon", 2); UpdateBtn(f.btnD3, "dungeon", 3)
    UpdateBtn(f.btnR1, "raid", 1); UpdateBtn(f.btnR2, "raid", 2); UpdateBtn(f.btnR3, "raid", 3)
    UpdateBtn(f.btnL1, "legacy", 1); UpdateBtn(f.btnL2, "legacy", 2)
end

local function SetDiff(category, index, silent)
    if InCombatLockdown() or IsInInstance() then return end
    
    if category == "dungeon" then 
        SetDungeonDifficultyID(IDS.dungeon[index])
    elseif category == "raid" then 
        SetRaidDifficultyID(IDS.raid[index])
    elseif category == "legacy" then 
        SetLegacyRaidDifficultyID(IDS.legacy[index])
    elseif category == "ALL" then
        SetDungeonDifficultyID(IDS.dungeon[CONFIG.dungeon])
        SetRaidDifficulties(true, IDS.raid[CONFIG.raid])
        SetRaidDifficulties(false, IDS.legacy[CONFIG.legacy])
    end

    RefreshSelection()

    if not silent then
        local msg = string.format("[난이도] 던전(%s), 레이드(%s)", 
            NAMES.dungeon[category == "dungeon" and index or (category == "ALL" and CONFIG.dungeon or 1)], 
            NAMES.raid[category == "raid" and index or (category == "ALL" and CONFIG.raid or 1)])
        
        if IsInGroup(LE_PARTY_CATEGORY_HOME) then
            SendChatMessage(msg, "PARTY")
        else
            print("|cff00ff00" .. msg .. "|r")
        end
    end
end

f.btnD1:SetScript("OnClick", function() SetDiff("dungeon", 1) end)
f.btnD2:SetScript("OnClick", function() SetDiff("dungeon", 2) end)
f.btnD3:SetScript("OnClick", function() SetDiff("dungeon", 3) end)
f.btnR1:SetScript("OnClick", function() SetDiff("raid", 1) end)
f.btnR2:SetScript("OnClick", function() SetDiff("raid", 2) end)
f.btnR3:SetScript("OnClick", function() SetDiff("raid", 3) end)
f.btnL1:SetScript("OnClick", function() SetDiff("legacy", 1) end)
f.btnL2:SetScript("OnClick", function() SetDiff("legacy", 2) end)

-----------------------------------------------------------
-- 6. [이벤트 관리]
-----------------------------------------------------------

local function UpdateUIStatus()
    if InCombatLockdown() then return end
    if not IsInInstance() then f:Show() else f:Hide() end
    RefreshSelection()
end

f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PARTY_LEADER_CHANGED")
f:RegisterEvent("GROUP_ROSTER_UPDATE")
f:RegisterEvent("PLAYER_DIFFICULTY_CHANGED")

f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        C_Timer.After(3, function()
            amILeader = UnitIsGroupLeader("player")
            if amILeader then SetDiff("ALL", nil, true) end 
            UpdateUIStatus()
        end)
    elseif event == "PARTY_LEADER_CHANGED" then
        local currentlyLeader = UnitIsGroupLeader("player")
        if currentlyLeader and not amILeader then 
            SetDiff("ALL", nil, false) 
        end
        amILeader = currentlyLeader
        UpdateUIStatus()
    elseif event == "PLAYER_REGEN_DISABLED" then
        f:Hide()
    else
        UpdateUIStatus()
    end
end)