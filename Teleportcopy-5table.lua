--------------------------------------
-- Table
--------------------------------------
local L = setmetatable({}, { __index = function(t, k) return k end })

local teleportTable = {
    -- OG
    -- BC
    -- WoL
    { id = 48933, type = "item", category = "WoL", name = L["Wormhole Generator: Northrend"] },

    -- CATA
    { id = 30542, type = "item", category = "CATA", name = L["Dimensional Ripper - Area 52"] },
    { id = 18984, type = "item", category = "CATA", name = L["Dimensional Ripper - Everlook"] },
    { id = 18986, type = "item", category = "CATA", name = L["Ultrasafe Transporter: Gadgetzan"] },
    { id = 30544, type = "item", category = "CATA", name = L["Ultrasafe Transporter: Toshley's Station"] },
    { id = 410080, type = "spell", category = "CATA", name = L["The Vortex Pinnacle"] },
    { id = 424142, type = "spell", category = "CATA", name = L["Throne of the Tides"] },
    { id = 445424, type = "spell", category = "CATA", name = L["Grim Batol"] },

    -- MoP
    { id = 87215, type = "item", category = "MoP", name = L["Wormhole Generator: Pandaria"] },
    { id = 131204, type = "spell", category = "MoP", name = L["Temple of the Jade Serpentl"] },
    { id = 131205, type = "spell", category = "MoP", name = L["Stormstout Brewery"] },
    { id = 131206, type = "spell", category = "MoP", name = L["Shado-Pan Monastery"] },
    { id = 131222, type = "spell", category = "MoP", name = L["Mogu'shan Palace"] },
    { id = 131225, type = "spell", category = "MoP", name = L["Gate of the Setting Sun"] },
    { id = 131228, type = "spell", category = "MoP", name = L["Siege of Niuzao Temple"] },
    { id = 131229, type = "spell", category = "MoP", name = L["Scarlet Monastery"] },
    { id = 131231, type = "spell", category = "MoP", name = L["Scarlet Halls"] },
    { id = 131232, type = "spell", category = "MoP", name = L["Scholomance"] },

    -- WoD
    { id = 112059, type = "item", category = "WoD", name = L["Wormhole Centrifuge (Dreanor)"] },
    { id = 159901, type = "spell", category = "WoD", name = L["The Everblooml"] },
    { id = 159899, type = "spell", category = "WoD", name = L["Shadowmoon Burial Grounds"] },
    { id = 159900, type = "spell", category = "WoD", name = L["Grimrail Depot"] },
    { id = 159896, type = "spell", category = "WoD", name = L["Iron Docks"] },
    { id = 159895, type = "spell", category = "WoD", name = L["Bloodmaul Slag Mines"] },
    { id = 159897, type = "spell", category = "WoD", name = L["Auchindoun"] },
    { id = 159898, type = "spell", category = "WoD", name = L["Skyreach"] },
    { id = 159902, type = "spell", category = "WoD", name = L["Upper Blackrock Spire"] },

    -- Legion
    { id = 151652, type = "item", category = "Legion", name = L["Wormhole Generator: Argus"] },
    { id = 393764, type = "spell", category = "Legion", name = L["Halls of Valor"] },
    { id = 410078, type = "spell", category = "Legion", name = L["Neltharion's Lair"] },
    { id = 393766, type = "spell", category = "Legion", name = L["Court of Stars"] },
    { id = 373262, type = "spell", category = "Legion", name = L["Karazhan"] },
    { id = 424153, type = "spell", category = "Legion", name = L["Black Rook Hold"] },
    { id = 424163, type = "spell", category = "Legion", name = L["Darkheart Thicket"] },

    -- BfA
    { id = 168807, type = "item", category = "BfA", name = L["Wormhole Generator: Kul Tiras"] },
    { id = 168808, type = "item", category = "BfA", name = L["Wormhole Generator: Zandalar"] },
    { id = 410071, type = "spell", category = "BFA", name = L["Freehold"] },
    { id = 410074, type = "spell", category = "BFA", name = L["The Underrot"] },
    { id = 373274, type = "spell", category = "BFA", name = L["Mechagon"] },
    { id = 424167, type = "spell", category = "BFA", name = L["Waycrest Manor"] },
    { id = 424187, type = "spell", category = "BFA", name = L["Atal'Dazar"] },
    { id = 445418, type = "spell", category = "BFA", name = L["Siege of Boralus"] },
    { id = 464256, type = "spell", category = "BFA", name = L["Siege of Boralus"] },
    { id = 467553, type = "spell", category = "BFA", name = L["The MOTHERLODE!!"] },
    { id = 467555, type = "spell", category = "BFA", name = L["The MOTHERLODE!!"] },

    -- SL
    { id = 354462, type = "spell", category = "SL", name = L["The Necrotic Wake"] },
    { id = 354463, type = "spell", category = "SL", name = L["Plaguefall"] },
    { id = 354464, type = "spell", category = "SL", name = L["Mists of Tirna Scithe"] },
    { id = 354465, type = "spell", category = "SL", name = L["Halls of Atonement"] },
    { id = 354466, type = "spell", category = "SL", name = L["Bastion"] },
    { id = 354467, type = "spell", category = "SL", name = L["Theater of Pain"] },
    { id = 354468, type = "spell", category = "SL", name = L["De Other Side"] },
    { id = 354469, type = "spell", category = "SL", name = L["Sanguine Depths"] },
    { id = 367416, type = "spell", category = "SL", name = L["Tazavesh, the Veiled Market"] },
    { id = 373190, type = "spell", category = "SL", name = L["Castle Nathria"] },
    { id = 373191, type = "spell", category = "SL", name = L["Sanctum of Domination"] },
    { id = 373192, type = "spell", category = "SL", name = L["Sepulcher of the First Ones"] },

    -- DF
    { id = 172924, type = "item", category = "SL", name = L["Wormhole Generator: Shadowlands"] },
    { id = 393256, type = "spell", category = "DF", name = L["Ruby Life Pools"] },
    { id = 393262, type = "spell", category = "DF", name = L["The Nokhud Offensive"] },
    { id = 393267, type = "spell", category = "DF", name = L["Brackenhide Hollow"] },
    { id = 393273, type = "spell", category = "DF", name = L["Algeth'ar Academy"] },
    { id = 393276, type = "spell", category = "DF", name = L["Neltharus"] },
    { id = 393279, type = "spell", category = "DF", name = L["The Azure Vault"] },
    { id = 393283, type = "spell", category = "DF", name = L["Halls of Infusion"] },
    { id = 393222, type = "spell", category = "DF", name = L["Uldaman"] },
    { id = 424197, type = "spell", category = "DF", name = L["Dawn of the Infinite"] },
    { id = 432254, type = "spell", category = "DF", name = L["Vault of the Incarnates"] },
    { id = 432257, type = "spell", category = "DF", name = L["Aberrus, the Shadowed Crucible"] },
    { id = 432258, type = "spell", category = "DF", name = L["Amirdrassil, the Dream's Hope"] },

    -- TWW
    { id = 198156, type = "item", category = "DF", name = L["Wyrmhole Generator: Dragon Isles"] },
    { id = 221966, type = "item", category = "TWW", name = L["Wormhole Generator: Khaz Algar"] },
    { id = 445416, type = "spell", category = "TWW", name = L["City of Threads"] },
    { id = 445414, type = "spell", category = "TWW", name = L["The Dawnbreaker"] },
    { id = 445269, type = "spell", category = "TWW", name = L["The Stonevault"] },
    { id = 445443, type = "spell", category = "TWW", name = L["The Rookery"] },
    { id = 445440, type = "spell", category = "TWW", name = L["Cinderbrew Meadery"] },
    { id = 445444, type = "spell", category = "TWW", name = L["Priory of the Sacred Flame"] },
    { id = 445417, type = "spell", category = "TWW", name = L["Ara-Kara, City of Echoes"] },
    { id = 445441, type = "spell", category = "TWW", name = L["Darkflame Cleft"] },
    { id = 1216786, type = "spell", category = "TWW", name = L["Operation: Floodgate"] },
    { id = 1237215, type = "spell", category = "TWW", name = L["Eco-Dome Al'dani"] },
    { id = 1226482, type = "spell", category = "TWW", name = L["Liberation of Undermine"] },
    { id = 1239155, type = "spell", category = "TWW", name = L["Manaforge Omega"] },
}

--------------------------------------
-- Background
--------------------------------------

local TeleportBackground = CreateFrame("Frame", "TeleportMenuFrame", GameMenuFrame, "BackdropTemplate") -- 배경 생성
TeleportBackground:SetSize(600, 600) -- 크기 설정
TeleportBackground:SetPoint("TOPLEFT", GameMenuFrame, "TOPRIGHT", 50, 0) -- 위치 설정

NineSliceUtil.ApplyLayoutByName(TeleportBackground, "Dialog") -- NineSlice 레이아웃 적용

TeleportBackground.Bg = TeleportBackground:CreateTexture(nil, "BACKGROUND")
TeleportBackground.Bg:SetPoint("TOPLEFT", 8, -8)
TeleportBackground.Bg:SetPoint("BOTTOMRIGHT", -8, 8)
TeleportBackground.Bg:SetAtlas("UI-DialogBox-Background-Dark")
TeleportBackground.Bg:SetAlpha(0.7)


--------------------------------------
-- Icon
--------------------------------------

local BUTTON_SIZE = 36   -- 버튼 크기를 약간 줄임 (섹션 구분을 위해)
local START_X = 20
local START_Y = -20
local SPACING = 4        -- 버튼 간격
local SECTION_GAP = 15   -- 확장팩(섹션) 사이의 간격
local COLS = 15           -- 한 줄에 5개

local currentCategory = ""
local col, row = 0, 0
local totalOffset = 0    -- 섹션 간격으로 인해 추가되는 Y축 값

for i, data in ipairs(teleportTable) do
    -- 1. 카테고리가 바뀌었는지 확인 (확장팩 구분)
    if data.category ~= currentCategory then
        if currentCategory ~= "" then
            row = row + 1 -- 새 섹션은 무조건 다음 줄부터
            totalOffset = totalOffset + SECTION_GAP -- 섹션 사이 여백 추가
        end
        col = 0
        currentCategory = data.category
        
        -- (선택사항) 여기에 확장팩 이름을 텍스트로 표시하는 코드를 넣을 수도 있습니다.
    end

    -- 2. 버튼 생성 및 위치 계산
    local btn = CreateFrame("Button", "TeleBtn"..i, TeleportBackground, "SecureActionButtonTemplate")
    btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    
    local x = START_X + (col * (BUTTON_SIZE + SPACING))
    local y = START_Y - (row * (BUTTON_SIZE + SPACING)) - totalOffset
    btn:SetPoint("TOPLEFT", TeleportBackground, "TOPLEFT", x, y)


    -- 3. 아이콘 실시간 호출 (중요!)
    local displayIcon
    if data.type == "spell" then
        displayIcon = C_Spell.GetSpellTexture(data.id)
    else
        displayIcon = C_Item.GetItemIconByID(data.id)
    end

    local tex = btn:CreateTexture(nil, "ARTWORK")
    tex:SetAllPoints()
    -- 아이콘을 불러오지 못했다면 물음표(134400)를 기본값으로 사용
    tex:SetTexture(displayIcon or 134400)




    
    -- 4. 텍스처 및 하이라이트 (Atlas 적용)
    local tex = btn:CreateTexture(nil, "ARTWORK")
    tex:SetAllPoints()
    tex:SetTexture(data.iconID or 134400)

    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
    hl:SetAtlas("UI-HUD-ActionBar-IconFrame-MouseOver")
    hl:SetAllPoints()
    hl:SetBlendMode("ADD")
    
    local pushed = btn:CreateTexture(nil, "OVERLAY")
    pushed:SetAtlas("UI-HUD-ActionBar-IconFrame-Down")
    pushed:SetAllPoints()
    btn:SetPushedTexture(pushed)

    -- 5. 다음 버튼을 위한 좌표 업데이트
    col = col + 1
    if col >= COLS then
        col = 0
        row = row + 1
    end
end


-- 1. 아이콘을 갱신하는 공통 함수
local function RefreshTeleportIcons()
    for i, data in ipairs(teleportTable) do
        local btn = _G["TeleBtn"..i]
        if btn then
            local displayIcon
            if data.type == "spell" then
                displayIcon = C_Spell.GetSpellTexture(data.id)
            else
                displayIcon = C_Item.GetItemIconByID(data.id)
            end
            
            -- 정보가 확인되면 아이콘 적용
            if displayIcon then
                -- 버튼의 첫 번째 레이어(우리가 만든 tex)를 찾아 아이콘 설정
                if btn.iconTexture then
                    btn.iconTexture:SetTexture(displayIcon)
                end
            end
        end
    end
end

-- 2. 버튼 생성 루프 수정 (나중에 찾기 쉽게 참조 저장)
-- 기존 루프 안에서 'local tex = btn:CreateTexture...' 부분을 아래처럼 수정하세요.
-- btn.iconTexture = tex  <-- 이 한 줄을 추가해서 나중에 찾기 쉽게 합니다.

-- 3. 다중 이벤트 리스너
local updater = CreateFrame("Frame")
updater:RegisterEvent("PLAYER_ENTERING_WORLD") -- 접속/리로드 직후
updater:RegisterEvent("GET_ITEM_INFO_RECEIVED") -- 아이템 정보 수신 시
updater:RegisterEvent("SPELL_DATA_LOAD_RESULT") -- 주문 정보 수신 시

updater:SetScript("OnEvent", function(self, event)
    RefreshTeleportIcons()
end)

-- 4. 메뉴가 열릴 때마다 다시 확인 (가장 확실함)
TeleportBackground:SetScript("OnShow", function()
    RefreshTeleportIcons()
end)









--[[ 
CreateFrame 함수 : 생성할 프레임의 종류, 이름, 부모 프레임, 템플릿
	local frame = CreateFrame("frameType", "frameName", parentFrame, "template")

L["abc"] : 번역용
    if locale == "enUS" then
        L["Menu_Title"] = "Teleport Menu"
    elseif locale == "koKR" then
        L["Menu_Title"] = "텔레포트 메뉴"

-- 테이블
    생성
    local myConfig = {
        { id = 393262, name = "노쿠드", color = "green" },
        { id = 393256, name = "하늘웅덩이", color = "blue" },
    }

    테이블 사용
    for i, info in ipairs(myConfig) do
        print(info.id)   -- 393262
        print(info.name) -- "노쿠드"
    end





local tpitem = {
	-- Hearthstones
	{ id = 6948, type = "item", hearthstone = true }, -- Hearthstone
	{ id = 1233637, type = "housing"}, -- Teleport Home (Housing)
	{ id = 556, type = "spell" }, -- Astral Recall (Shaman)
	{ id = 110560, type = "toy", quest = { 34378, 34586 } }, -- Garrison Hearthstone
	{ id = 140192, type = "toy", quest = { 44184, 44663 } }, -- Dalaran Hearthstone
	-- Engineering
	{ type = "wormholes", iconID = 4620673 }, -- Engineering Wormholes
	{ type = "item_teleports", iconID = 133655 }, -- Item Teleports
	-- Class Teleports
	{ id = 1, type = "flyout", iconID = 237509, subtype = "mage" }, -- Teleport (Mage) (Horde)
	{ id = 8, type = "flyout", iconID = 237509, subtype = "mage" }, -- Teleport (Mage) (Alliance)
	{ id = 11, type = "flyout", iconID = 135744, subtype = "mage" }, -- Portals (Mage) (Horde)
	{ id = 12, type = "flyout", iconID = 135748, subtype = "mage" }, -- Portals (Mage) (Alliance)
	{ id = 126892, type = "spell" }, -- Zen Pilgrimage (Monk)
	{ id = 50977, type = "spell" }, -- Death Gate (Death Knight)
	{ id = 18960, type = "spell" }, -- Teleport: Moonglade (Druid)
	{ id = 193753, type = "spell" }, -- Dreamwalk (Druid) (replaces Teleport: Moonglade)
	-- Racials
	{ id = 312370, type = "spell" }, -- Make Camp (Vulpera)
	{ id = 312372, type = "spell" }, -- Return to Camp (Vulpera)
	{ id = 265225, type = "spell" }, -- Mole Machine (Dark Iron Dwarf)

	-- Dungeon/Raid Teleports
	{ id = 230, type = "flyout", iconID = 574788, name = L["Cataclysm"], subtype = "path" }, -- Hero's Path: Cataclysm
	{ id = 84, type = "flyout", iconID = 328269, name = L["Mists of Pandaria"], subtype = "path" }, -- Hero's Path: Mists of Pandaria
	{ id = 96, type = "flyout", iconID = 1413856, name = L["Warlords of Draenor"], subtype = "path" }, -- Hero's Path: Warlords of Draenor
	{ id = 224, type = "flyout", iconID = 1260827, name = L["Legion"], subtype = "path" }, -- Hero's Path: Legion
	{ id = 223, type = "flyout", iconID = 1869493, name = L["Battle for Azeroth"], subtype = "path" }, -- Hero's Path: Battle for Azeroth
	{ id = 220, type = "flyout", iconID = 236798, name = L["Shadowlands"], subtype = "path" }, -- Hero's Path: Shadowlands
	{ id = 222, type = "flyout", iconID = 4062765, name = L["Shadowlands Raids"], subtype = "path" }, -- Hero's Path: Shadowlands Raids
	{ id = 227, type = "flyout", iconID = 4640496, name = L["Dragonflight"], subtype = "path" }, -- Hero's Path: Dragonflight
	{ id = 231, type = "flyout", iconID = 5342925, name = L["Dragonflight Raids"], subtype = "path" }, -- Hero's Path: Dragonflight Raids
	{ id = 232, type = "flyout", iconID = 5872031, name = L["The War Within"], subtype = "path" }, -- Hero's Path: The War Within
	{ id = 242, type = "flyout", iconID = 6392630, name = L["The War Within Raids"], subtype = "path", currentExpansion=true }, -- Hero's Path: The War Within Raids


	{ id = 230, type = "flyout", iconID = 574788, name = L["Cataclysm"], subtype = "path" }, -- Hero's Path: Cataclysm
	{ id = 84, type = "flyout", iconID = 328269, name = L["Mists of Pandaria"], subtype = "path" }, -- Hero's Path: Mists of Pandaria
	{ id = 96, type = "flyout", iconID = 1413856, name = L["Warlords of Draenor"], subtype = "path" }, -- Hero's Path: Warlords of Draenor
	{ id = 224, type = "flyout", iconID = 1260827, name = L["Legion"], subtype = "path" }, -- Hero's Path: Legion

    
    -- Mage Teleports
    { id = 3561, type = "spell", iconID = C_Spell.GetSpellInfo(3561).iconID, name = L["Stormwind"] },
    { id = 3562, type = "spell", iconID = C_Spell.GetSpellInfo(3562).iconID, name = L["Ironforge"] },
    { id = 3563, type = "spell", iconID = C_Spell.GetSpellInfo(3563).iconID, name = L["Undercity"] },
    { id = 3565, type = "spell", iconID = C_Spell.GetSpellInfo(3565).iconID, name = L["Darnassus"] },
    { id = 3566, type = "spell", iconID = C_Spell.GetSpellInfo(3566).iconID, name = L["Thunder Bluff"] },
    { id = 3567, type = "spell", iconID = C_Spell.GetSpellInfo(3567).iconID, name = L["Orgrimmar"] },
    { id = 32271, type = "spell", iconID = C_Spell.GetSpellInfo(32271).iconID, name = L["Exodar"] },
    { id = 32272, type = "spell", iconID = C_Spell.GetSpellInfo(32272).iconID, name = L["Silvermoon"] },
    { id = 33690, type = "spell", iconID = C_Spell.GetSpellInfo(33690).iconID, name = L["Shattrath"] },
    { id = 49358, type = "spell", iconID = C_Spell.GetSpellInfo(49358).iconID, name = L["Stonard"] },
    { id = 49359, type = "spell", iconID = C_Spell.GetSpellInfo(49359).iconID, name = L["Theramore"] },
    { id = 53140, type = "spell", iconID = C_Spell.GetSpellInfo(53140).iconID, name = L["Dalaran - Northrend"] },
    { id = 88342, type = "spell", iconID = C_Spell.GetSpellInfo(88342).iconID, name = L["Tol Barad"] },
    { id = 120145, type = "spell", iconID = C_Spell.GetSpellInfo(120145).iconID, name = L["Dalaran - Ancient"] },
    { id = 132621, type = "spell", iconID = C_Spell.GetSpellInfo(132621).iconID, name = L["Vale of Eternal Blossoms"] },
    { id = 176242, type = "spell", iconID = C_Spell.GetSpellInfo(176242).iconID, name = L["Warspear"] },
    { id = 176248, type = "spell", iconID = C_Spell.GetSpellInfo(176248).iconID, name = L["Stormshield"] },
    { id = 193759, type = "spell", iconID = C_Spell.GetSpellInfo(193759).iconID, name = L["Hall of the Guardian"] },
    { id = 224869, type = "spell", iconID = C_Spell.GetSpellInfo(224869).iconID, name = L["Dalaran - Broken Isles"] },
    { id = 281403, type = "spell", iconID = C_Spell.GetSpellInfo(281403).iconID, name = L["Boralus"] },
    { id = 281404, type = "spell", iconID = C_Spell.GetSpellInfo(281404).iconID, name = L["Dazar'alor"] },
    { id = 344587, type = "spell", iconID = C_Spell.GetSpellInfo(344587).iconID, name = L["Oribos"] },
    { id = 395277, type = "spell", iconID = C_Spell.GetSpellInfo(395277).iconID, name = L["Valdrakken"] },
    { id = 446540, type = "spell", iconID = C_Spell.GetSpellInfo(446540).iconID, name = L["Dornogal"] },

    -- Mage Portals
    { id = 10059, type = "spell", iconID = C_Spell.GetSpellInfo(10059).iconID, name = L["Stormwind"] },
    { id = 11416, type = "spell", iconID = C_Spell.GetSpellInfo(11416).iconID, name = L["Ironforge"] },
    { id = 11417, type = "spell", iconID = C_Spell.GetSpellInfo(11417).iconID, name = L["Orgrimmar"] },
    { id = 11418, type = "spell", iconID = C_Spell.GetSpellInfo(11418).iconID, name = L["Undercity"] },
    { id = 11419, type = "spell", iconID = C_Spell.GetSpellInfo(11419).iconID, name = L["Darnassus"] },
    { id = 11420, type = "spell", iconID = C_Spell.GetSpellInfo(11420).iconID, name = L["Thunder Bluff"] },
    { id = 32266, type = "spell", iconID = C_Spell.GetSpellInfo(32266).iconID, name = L["Exodar"] },
    { id = 32267, type = "spell", iconID = C_Spell.GetSpellInfo(32267).iconID, name = L["Silvermoon"] },
    { id = 33691, type = "spell", iconID = C_Spell.GetSpellInfo(33691).iconID, name = L["Shattrath"] },
    { id = 49360, type = "spell", iconID = C_Spell.GetSpellInfo(49360).iconID, name = L["Theramore"] },
    { id = 49361, type = "spell", iconID = C_Spell.GetSpellInfo(49361).iconID, name = L["Stonard"] },
    { id = 53142, type = "spell", iconID = C_Spell.GetSpellInfo(53142).iconID, name = L["Dalaran - Northrend"] },
    { id = 88345, type = "spell", iconID = C_Spell.GetSpellInfo(88345).iconID, name = L["Tol Barad"] },
    { id = 88346, type = "spell", iconID = C_Spell.GetSpellInfo(88346).iconID, name = L["Tol Barad"] },
    { id = 120146, type = "spell", iconID = C_Spell.GetSpellInfo(120146).iconID, name = L["Dalaran - Ancient"] },
    { id = 132620, type = "spell", iconID = C_Spell.GetSpellInfo(132620).iconID, name = L["Vale of Eternal Blossoms"] },
    { id = 176244, type = "spell", iconID = C_Spell.GetSpellInfo(176244).iconID, name = L["Warspear"] },
    { id = 176246, type = "spell", iconID = C_Spell.GetSpellInfo(176246).iconID, name = L["Stormshield"] },
    { id = 224871, type = "spell", iconID = C_Spell.GetSpellInfo(224871).iconID, name = L["Dalaran - Broken Isles"] },
    { id = 281400, type = "spell", iconID = C_Spell.GetSpellInfo(281400).iconID, name = L["Boralus"] },
    { id = 281402, type = "spell", iconID = C_Spell.GetSpellInfo(281402).iconID, name = L["Dazar'alor"] },
    { id = 344597, type = "spell", iconID = C_Spell.GetSpellInfo(344597).iconID, name = L["Oribos"] },
    { id = 395289, type = "spell", iconID = C_Spell.GetSpellInfo(395289).iconID, name = L["Valdrakken"] },
    { id = 446534, type = "spell", iconID = C_Spell.GetSpellInfo(446534).iconID, name = L["Dornogal"] },
]]
