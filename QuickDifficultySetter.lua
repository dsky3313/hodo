local f = CreateFrame("Frame", "QuickDiffSelectorBar", UIParent)
f:SetSize(300, 150)
-- [수정] TOP에서 TOPLEFT로 변경, 위치를 왼쪽 위 구석으로 조정
f:SetPoint("TOPLEFT", 50, -50) 
f:Hide()

-- 난이도 ID 데이터
local IDS = {
    dungeon = { [1] = 1, [2] = 2, [3] = 23 },
    raid    = { [1] = 14, [2] = 15, [3] = 16 },
    legacy  = { [1] = 3, [2] = 4 }
}

-- 라벨 생성 함수
local function CreateTitleLabel(rowFrame, text)
    local labelBg = rowFrame:CreateTexture(nil, "ARTWORK")
    labelBg:SetSize(60, 50)
    -- 배경 줄의 왼쪽에 라벨 배치
    labelBg:SetPoint("RIGHT", rowFrame, "LEFT", -5, -15)
    labelBg:SetAtlas("tournamentarena-titlebackplate", false)
    labelBg:SetAlpha(0.9)

    local labelText = rowFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    labelText:SetPoint("CENTER", labelBg, "CENTER", 0, 15)
    labelText:SetText(text)
    labelText:SetTextColor(1, 0.9, 0)
    labelText:SetFont(labelText:GetFont(), 11, "OUTLINE")
end

-- 배경 생성 함수
local function CreateBackgroundRow(parent, yOffset, titleText)
    local bgFrame = CreateFrame("Frame", nil, parent)
    bgFrame:SetSize(200, 40) 
    -- 라벨(너비 약 60)이 왼쪽으로 삐져나가지 않도록 x축 여유(70)를 줌
    bgFrame:SetPoint("TOPLEFT", 70, yOffset) 
    bgFrame:SetAlpha(0.7)

    local bg = bgFrame:CreateTexture(nil, "BACKGROUND")
    bg:SetAllPoints()
    bg:SetAtlas("legionmission-hearts-background", false) 
    
    CreateTitleLabel(bgFrame, titleText)
    
    return bgFrame
end

-- 난이도 변경 실행 함수
local function ChangeDiff(type, index)
    if InCombatLockdown() or IsInInstance() then return end
    if type == "dungeon" then
        SetDungeonDifficultyID(IDS.dungeon[index])
    elseif type == "raid" then
        SetRaidDifficultyID(IDS.raid[index])
    elseif type == "legacy" then
        SetLegacyRaidDifficultyID(IDS.legacy[index])
    end
end

-- 버튼 생성 함수
local function CreateButton(rowFrame, label, xOffset, onClick)
    local btn = CreateFrame("Button", nil, f, "SecureActionButtonTemplate")
    btn:SetSize(60, 25)
    btn:SetPoint("CENTER", rowFrame, "CENTER", xOffset, 0)
    
    btn.text = btn:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
    btn.text:SetPoint("CENTER")
    btn.text:SetText(label)
    btn.text:SetFont(btn.text:GetFont(), 11, "OUTLINE") 
    btn.text:SetShadowOffset(1, -1)
    
    btn:SetScript("OnClick", onClick)
    btn:SetScript("OnEnter", function() btn.text:SetTextColor(1, 1, 1) end)
    btn:SetScript("OnLeave", function() btn.text:SetTextColor(1, 0.8, 0) end)
    return btn
end

-- --- 각 줄 생성 (TOPLEFT 기준으로 순차적 배치) ---
local row1 = CreateBackgroundRow(f, 0, "던전")
CreateButton(row1, "일반", -60, function() ChangeDiff("dungeon", 1) end) 
CreateButton(row1, "영웅", 0,   function() ChangeDiff("dungeon", 2) end) 
CreateButton(row1, "신화", 60,  function() ChangeDiff("dungeon", 3) end) 

local row2 = CreateBackgroundRow(f, -45, "공격대")
CreateButton(row2, "일반", -60, function() ChangeDiff("raid", 1) end)
CreateButton(row2, "영웅", 0,   function() ChangeDiff("raid", 2) end)
CreateButton(row2, "신화", 60,  function() ChangeDiff("raid", 3) end)

local row3 = CreateBackgroundRow(f, -90, "낭만")
CreateButton(row3, "10인", -40, function() ChangeDiff("legacy", 1) end)
CreateButton(row3, "25인", 40,  function() ChangeDiff("legacy", 2) end)

-- 상태 업데이트 로직
local function UpdateUI()
    if InCombatLockdown() then return end
    local isLeader = not IsInGroup() or UnitIsGroupLeader("player")
    if isLeader and not IsInInstance() then f:Show() else f:Hide() end
end

f:RegisterEvent("PLAYER_REGEN_ENABLED")
f:RegisterEvent("PLAYER_REGEN_DISABLED")
f:RegisterEvent("PLAYER_ENTERING_WORLD")
f:RegisterEvent("PARTY_LEADER_CHANGED")
f:RegisterEvent("GROUP_ROSTER_UPDATE")

f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_REGEN_DISABLED" then f:Hide() else UpdateUI() end
end)

UpdateUI()