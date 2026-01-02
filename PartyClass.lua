------------------------------
-- 1. 데이터 정의 (ID 기반)
------------------------------
local class = {
    { id = 6, name = "죽기", iconID = 625998, dispell = { curse = false, disease = false, magic = false, poison = false }, bl = false, br = true, buff = false },
    { id = 11, name = "드루", iconID = 625999, dispell = { curse = true, disease = false, magic = false, poison = true }, bl = false, br = true, buff = false },
    { id = 3, name = "사냥꾼", iconID = 626000, dispell = { curse = false, disease = false, magic = false, poison = false }, bl = true, br = false, buff = false },
    { id = 8, name = "마법사", iconID = 626001, dispell = { curse = true, disease = false, magic = false, poison = false }, bl = true, br = false, buff = false },
    { id = 10, name = "수도사", iconID = 626002, dispell = { curse = false, disease = true, magic = false, poison = true }, bl = false, br = false, buff = true },
    { id = 2, name = "성기사", iconID = 626003, dispell = { curse = false, disease = true, magic = false, poison = true }, bl = false, br = true, buff = false },
    { id = 5, name = "사제", iconID = 626004, dispell = { curse = false, disease = true, magic = true, poison = false }, bl = false, br = false, buff = true },
    { id = 4, name = "도적", iconID = 626005, dispell = { curse = false, disease = false, magic = false, poison = false }, bl = false, br = false, buff = true },
    { id = 7, name = "주술사", iconID = 626006, dispell = { curse = true, disease = false, magic = false, poison = false }, bl = true, br = false, buff = false },
    { id = 9, name = "흑마", iconID = 626007, dispell = { curse = false, disease = false, magic = true, poison = false }, bl = false, br = true, buff = false },
    { id = 1, name = "전사", iconID = 626008, dispell = { curse = false, disease = false, magic = false, poison = false }, bl = false, br = false, buff = true },
    { id = 12, name = "악사", iconID = 1260827, dispell = { curse = false, disease = false, magic = false, poison = false }, bl = false, br = false, buff = true },
    { id = 13, name = "기원사", iconID = 4574311, dispell = { curse = false, disease = false, magic = false, poison = true }, bl = true, br = false, buff = false },
}

local layoutData = {
    { iconID = 132108, name = "독해제", key = "poison", type = "dispell" },
    { iconID = 136066, name = "마법해제", key = "magic", type = "dispell" },
    { iconID = 136140, name = "저주해제", key = "curse", type = "dispell" },
    { iconID = 132100, name = "질병해제", key = "disease", type = "dispell" },
    { iconID = 136012, name = "블러드", key = "bl", type = "util" },
    { iconID = 136080, name = "전부", key = "br", type = "util" },
    { iconID = 136243, name = "시너지", key = "buff", type = "util" }
}

------------------------------
-- 2. 배경 프레임 생성
------------------------------
local frame = CreateFrame("Frame", "MyPartyStatusBG", PVEFrame, "BackdropTemplate")
frame:SetSize(542, 212)
frame:SetPoint("TOPLEFT", PVEFrame, "BOTTOMLEFT", 20, 2)
frame:SetFrameStrata("LOW") 

NineSliceUtil.ApplyLayoutByName(frame, "ButtonFrameTemplateNoPortrait")

frame.TitleText = frame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
frame.TitleText:SetPoint("TOPRIGHT", frame, "TOPRIGHT", -40, -5)
local today = date("%m/%d") -- 예: 01/02
frame.TitleText:SetText("클래스 현황 (" .. today .. ")")
frame.TitleText:SetTextColor(1, 0.82, 0)



frame.Background = frame:CreateTexture(nil, "BACKGROUND")
frame.Background:SetPoint("TOPLEFT", 6, -2)
frame.Background:SetPoint("BOTTOMRIGHT", -2, 2)
frame.Background:SetAtlas("UI-DialogBox-Background-Dark")
frame.Background:SetAlpha(0.7)

------------------------------
-- 3. 아이콘 배치 (수치 고정)
------------------------------
local ICON_SIZE, CLASS_ICON_SIZE, X_GAP, Y_GAP, MAX_ROWS = 30, 30, 250, 2, 4
local START_X, START_Y = 25, -40
frame.classIcons = {}

for i, data in ipairs(layoutData) do
    local btn = CreateFrame("Frame", nil, frame)
    btn:SetSize(ICON_SIZE, ICON_SIZE)
    local col, row = math.floor((i - 1) / MAX_ROWS), (i - 1) % MAX_ROWS
    btn:SetPoint("TOPLEFT", frame, "TOPLEFT", START_X + (col * X_GAP), START_Y - (row * (ICON_SIZE + Y_GAP + 10)))

    btn.icon = btn:CreateTexture(nil, "ARTWORK")
    btn.icon:SetPoint("TOPLEFT", 2, -2); btn.icon:SetPoint("BOTTOMRIGHT", -2, 2)
    btn.icon:SetTexture(data.iconID)
    btn.border = btn:CreateTexture(nil, "OVERLAY")
    btn.border:SetAllPoints(); btn.border:SetAtlas("UI-HUD-ActionBar-IconFrame")

    local nameText = btn:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
    nameText:SetPoint("TOP", btn, "BOTTOM", 0, 5)
    nameText:SetFont(nameText:GetFont(), (strlenutf8(data.name) >= 4) and 10 or 11, "OUTLINE")
    nameText:SetTextColor(1, 0.82, 0); nameText:SetText(data.name)

    local classCount = 0
    for _, classInfo in ipairs(class) do
        local isMatch = (data.type == "dispell" and classInfo.dispell[data.key]) or (data.type ~= "dispell" and classInfo[data.key])
        if isMatch then
            classCount = classCount + 1
            local cBtn = CreateFrame("Frame", nil, btn)
            cBtn:SetSize(CLASS_ICON_SIZE, CLASS_ICON_SIZE)
            cBtn:SetPoint("LEFT", btn, "RIGHT", 20 + (classCount - 1) * (CLASS_ICON_SIZE + 5), 0)
            
            cBtn.icon = cBtn:CreateTexture(nil, "ARTWORK")
            cBtn.icon:SetPoint("TOPLEFT", 2, -2); cBtn.icon:SetPoint("BOTTOMRIGHT", -2, 2)
            cBtn.icon:SetTexture(classInfo.iconID)
            cBtn.icon:SetDesaturated(true); cBtn.icon:SetAlpha(0.4)

            cBtn.border = cBtn:CreateTexture(nil, "OVERLAY")
            cBtn.border:SetAllPoints(); cBtn.border:SetAtlas("UI-HUD-ActionBar-IconFrame")

            cBtn.text = cBtn:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
            cBtn.text:SetPoint("TOP", cBtn, "BOTTOM", 0, 5)
            cBtn.text:SetFont(cBtn.text:GetFont(), 10, "OUTLINE")
            cBtn.text:SetText(classInfo.name); cBtn.text:SetTextColor(0.6, 0.6, 0.6)

            cBtn.classID = classInfo.id 
            table.insert(frame.classIcons, cBtn)
        end
    end
end

------------------------------
-- 4. 업데이트 로직 (나 포함 체크 수정)
------------------------------
local function UpdateStatus()
    local inInstance, inGroup, inCombat = IsInInstance(), IsInGroup(), InCombatLockdown()
    if inCombat or inInstance or (not inGroup) then
        frame:Hide() return
    else
        frame:Show()
    end

    local activeIDs = {}
    
    -- [수정] 무조건 내 직업부터 수집 (player)
    local _, _, playerClassID = UnitClass("player")
    if playerClassID then activeIDs[playerClassID] = true end

    -- 파티원이 있다면 추가 수집
    local num = GetNumGroupMembers()
    if num > 0 then
        local p = IsInRaid() and "raid" or "party"
        for i=1, num do
            local _, _, classID = UnitClass(p..i)
            if classID then activeIDs[classID] = true end
        end
    end

    for _, b in ipairs(frame.classIcons) do
        if activeIDs[b.classID] then
            b.icon:SetDesaturated(false); b.icon:SetAlpha(1); b.text:SetTextColor(1, 1, 1)
        else
            b.icon:SetDesaturated(true); b.icon:SetAlpha(0.4); b.text:SetTextColor(0.6, 0.6, 0.6)
        end
    end
end

frame:RegisterEvent("GROUP_ROSTER_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
frame:RegisterEvent("PLAYER_REGEN_DISABLED")
frame:RegisterEvent("PLAYER_REGEN_ENABLED")
frame:SetScript("OnEvent", UpdateStatus)

UpdateStatus()