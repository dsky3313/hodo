--------------------------------------
-- Background
--------------------------------------

local TeleportBackground = CreateFrame("Frame", "TeleportMenuFrame", GameMenuFrame, "BackdropTemplate") -- 배경 생성
TeleportBackground:SetSize(220, 300) -- 크기 설정
TeleportBackground:SetPoint("TOPLEFT", GameMenuFrame, "TOPRIGHT", 0, 0) -- 위치 설정

NineSliceUtil.ApplyLayoutByName(TeleportBackground, "Dialog") -- NineSlice 레이아웃 적용

TeleportBackground.Bg = TeleportBackground:CreateTexture(nil, "BACKGROUND")
TeleportBackground.Bg:SetPoint("TOPLEFT", 8, -8)
TeleportBackground.Bg:SetPoint("BOTTOMRIGHT", -8, 8)
TeleportBackground.Bg:SetAtlas("UI-DialogBox-Background-Dark")
TeleportBackground.Bg:SetAlpha(0.7)


--------------------------------------
-- Icon
--------------------------------------

-- 1. 버튼 생성 (이름: MyTeleButton, 부모: TeleportBackground)
local button = CreateFrame("Button", "MyTeleButton", TeleportBackground, "SecureActionButtonTemplate")

-- 2. 버튼의 물리적 크기와 위치 (매우 중요!)
-- SetAllPoints() 대신, 배경 안에서 버튼이 차지할 영역을 숫자로 정해줍니다.
button:SetSize(40, 40)
button:SetPoint("TOPLEFT", TeleportBackground, "TOPLEFT", 15, -15)

-- 3. 클릭 설정
button:RegisterForClicks("LeftButtonDown", "LeftButtonUp")

-- 4. 스펠 설정 (393262: 노쿠드 공격대 차원문 등)
button:SetAttribute("type", "spell")
button:SetAttribute("spell", 393262) 

-- 5. 눈에 보이게 만들기 (아이콘 추가)
-- 아이콘이 없으면 버튼이 투명해서 클릭이 되는지 알 수 없습니다.
local tex = button:CreateTexture(nil, "ARTWORK")
tex:SetAllPoints()
local spellInfo = C_Spell.GetSpellInfo(393262)
if spellInfo then
    tex:SetTexture(spellInfo.iconID)
else
    -- 스펠 정보를 못 불러올 경우 기본 물음표 아이콘
    tex:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
end

-- 6. 버튼 하이라이트
local btnhl = button:CreateTexture(nil, "HIGHLIGHT")
btnhl:SetAtlas("UI-HUD-ActionBar-IconFrame-MouseOver")
btnhl:SetAllPoints()

-- 7. 버튼 눌림
local btnpush = button:CreateTexture(nil, "OVERLAY")
btnpush:SetAtlas("UI-HUD-ActionBar-IconFrame-Down")
btnpush:SetAllPoints()
button:SetPushedTexture(btnpush)








--------------------------------------
-- Table
--------------------------------------

local teleportTable = {
    -- CATA
    { id = 410080, type = "spell", iconID = C_Spell.GetSpellInfo(410080).iconID, category = "CATA", name = L["The Vortex Pinnacle"] },
    { id = 424142, type = "spell", iconID = C_Spell.GetSpellInfo(424142).iconID, category = "CATA", name = L["Throne of the Tides"] },
    { id = 445424, type = "spell", iconID = C_Spell.GetSpellInfo(445424).iconID, category = "CATA", name = L["Grim Batol"] },

    -- MoP
    { id = 131204, type = "spell", iconID = C_Spell.GetSpellInfo(131204).iconID, category = "MoP", name = L["Temple of the Jade Serpentl"] },
    { id = 131205, type = "spell", iconID = C_Spell.GetSpellInfo(131205).iconID, category = "MoP", name = L["Stormstout Brewery"] },
    { id = 131206, type = "spell", iconID = C_Spell.GetSpellInfo(131206).iconID, category = "MoP", name = L["Shado-Pan Monastery"] },
    { id = 131222, type = "spell", iconID = C_Spell.GetSpellInfo(131222).iconID, category = "MoP", name = L["Mogu'shan Palace"] },
    { id = 131225, type = "spell", iconID = C_Spell.GetSpellInfo(131225).iconID, category = "MoP", name = L["Gate of the Setting Sun"] },
    { id = 131228, type = "spell", iconID = C_Spell.GetSpellInfo(131228).iconID, category = "MoP", name = L["Siege of Niuzao Temple"] },
    { id = 131229, type = "spell", iconID = C_Spell.GetSpellInfo(131229).iconID, category = "MoP", name = L["Scarlet Monastery"] },
    { id = 131231, type = "spell", iconID = C_Spell.GetSpellInfo(131231).iconID, category = "MoP", name = L["Scarlet Halls"] },
    { id = 131232, type = "spell", iconID = C_Spell.GetSpellInfo(131232).iconID, category = "MoP", name = L["Scholomance"] },

    -- WoD
    { id = 159901, type = "spell", iconID = C_Spell.GetSpellInfo(159901).iconID, category = "WoD", name = L["The Everblooml"] },
    { id = 159899, type = "spell", iconID = C_Spell.GetSpellInfo(159899).iconID, category = "WoD", name = L["Shadowmoon Burial Grounds"] },
    { id = 159900, type = "spell", iconID = C_Spell.GetSpellInfo(159900).iconID, category = "WoD", name = L["Grimrail Depot"] },
    { id = 159896, type = "spell", iconID = C_Spell.GetSpellInfo(159896).iconID, category = "WoD", name = L["Iron Docks"] },
    { id = 159895, type = "spell", iconID = C_Spell.GetSpellInfo(159895).iconID, category = "WoD", name = L["Bloodmaul Slag Mines"] },
    { id = 159897, type = "spell", iconID = C_Spell.GetSpellInfo(159897).iconID, category = "WoD", name = L["Auchindoun"] },
    { id = 159898, type = "spell", iconID = C_Spell.GetSpellInfo(159898).iconID, category = "WoD", name = L["Skyreach"] },
    { id = 159902, type = "spell", iconID = C_Spell.GetSpellInfo(159902).iconID, category = "WoD", name = L["Upper Blackrock Spire"] },

    -- Legion
    { id = 393764, type = "spell", iconID = C_Spell.GetSpellInfo(393764).iconID, category = "Legion", name = L["Halls of Valor"] },
    { id = 410078, type = "spell", iconID = C_Spell.GetSpellInfo(410078).iconID, category = "Legion", name = L["Neltharion's Lair"] },
    { id = 393766, type = "spell", iconID = C_Spell.GetSpellInfo(393766).iconID, category = "Legion", name = L["Court of Stars"] },
    { id = 373262, type = "spell", iconID = C_Spell.GetSpellInfo(373262).iconID, category = "Legion", name = L["Karazhan"] },
    { id = 424153, type = "spell", iconID = C_Spell.GetSpellInfo(424153).iconID, category = "Legion", name = L["Black Rook Hold"] },
    { id = 424163, type = "spell", iconID = C_Spell.GetSpellInfo(424163).iconID, category = "Legion", name = L["Darkheart Thicket"] },

    -- BfA
    { id = 410071, type = "spell", iconID = C_Spell.GetSpellInfo(410071).iconID, category = "BFA", name = L["Freehold"] },
    { id = 410074, type = "spell", iconID = C_Spell.GetSpellInfo(410074).iconID, category = "BFA", name = L["The Underrot"] },
    { id = 373274, type = "spell", iconID = C_Spell.GetSpellInfo(373274).iconID, category = "BFA", name = L["Mechagon"] },
    { id = 424167, type = "spell", iconID = C_Spell.GetSpellInfo(424167).iconID, category = "BFA", name = L["Waycrest Manor"] },
    { id = 424187, type = "spell", iconID = C_Spell.GetSpellInfo(424187).iconID, category = "BFA", name = L["Atal'Dazar"] },
    { id = 445418, type = "spell", iconID = C_Spell.GetSpellInfo(445418).iconID, category = "BFA", name = L["Siege of Boralus"] },
    { id = 464256, type = "spell", iconID = C_Spell.GetSpellInfo(464256).iconID, category = "BFA", name = L["Siege of Boralus"] },
    { id = 467553, type = "spell", iconID = C_Spell.GetSpellInfo(467553).iconID, category = "BFA", name = L["The MOTHERLODE!!"] },
    { id = 467555, type = "spell", iconID = C_Spell.GetSpellInfo(467555).iconID, category = "BFA", name = L["The MOTHERLODE!!"] },

    -- SL
    { id = 354462, type = "spell", iconID = C_Spell.GetSpellInfo(354462).iconID, category = "SL", name = L["The Necrotic Wake"] },
    { id = 354463, type = "spell", iconID = C_Spell.GetSpellInfo(354463).iconID, category = "SL", name = L["Plaguefall"] },
    { id = 354464, type = "spell", iconID = C_Spell.GetSpellInfo(354464).iconID, category = "SL", name = L["Mists of Tirna Scithe"] },
    { id = 354465, type = "spell", iconID = C_Spell.GetSpellInfo(354465).iconID, category = "SL", name = L["Halls of Atonement"] },
    { id = 354466, type = "spell", iconID = C_Spell.GetSpellInfo(354466).iconID, category = "SL", name = L["Bastion"] },
    { id = 354467, type = "spell", iconID = C_Spell.GetSpellInfo(354467).iconID, category = "SL", name = L["Theater of Pain"] },
    { id = 354468, type = "spell", iconID = C_Spell.GetSpellInfo(354468).iconID, category = "SL", name = L["De Other Side"] },
    { id = 354469, type = "spell", iconID = C_Spell.GetSpellInfo(354469).iconID, category = "SL", name = L["Sanguine Depths"] },
    { id = 367416, type = "spell", iconID = C_Spell.GetSpellInfo(367416).iconID, category = "SL", name = L["Tazavesh, the Veiled Market"] },
    { id = 373190, type = "spell", iconID = C_Spell.GetSpellInfo(373190).iconID, category = "SL", name = L["Castle Nathria"] },
    { id = 373191, type = "spell", iconID = C_Spell.GetSpellInfo(373191).iconID, category = "SL", name = L["Sanctum of Domination"] },
    { id = 373192, type = "spell", iconID = C_Spell.GetSpellInfo(373192).iconID, category = "SL", name = L["Sepulcher of the First Ones"] },

    -- DF
    { id = 393256, type = "spell", iconID = C_Spell.GetSpellInfo(393256).iconID, category = "DF", name = L["Ruby Life Pools"] },
    { id = 393262, type = "spell", iconID = C_Spell.GetSpellInfo(393262).iconID, category = "DF", name = L["The Nokhud Offensive"] },
    { id = 393267, type = "spell", iconID = C_Spell.GetSpellInfo(393267).iconID, category = "DF", name = L["Brackenhide Hollow"] },
    { id = 393273, type = "spell", iconID = C_Spell.GetSpellInfo(393273).iconID, category = "DF", name = L["Algeth'ar Academy"] },
    { id = 393276, type = "spell", iconID = C_Spell.GetSpellInfo(393276).iconID, category = "DF", name = L["Neltharus"] },
    { id = 393279, type = "spell", iconID = C_Spell.GetSpellInfo(393279).iconID, category = "DF", name = L["The Azure Vault"] },
    { id = 393283, type = "spell", iconID = C_Spell.GetSpellInfo(393283).iconID, category = "DF", name = L["Halls of Infusion"] },
    { id = 393222, type = "spell", iconID = C_Spell.GetSpellInfo(393222).iconID, category = "DF", name = L["Uldaman"] },
    { id = 424197, type = "spell", iconID = C_Spell.GetSpellInfo(424197).iconID, category = "DF", name = L["Dawn of the Infinite"] },
    { id = 432254, type = "spell", iconID = C_Spell.GetSpellInfo(432254).iconID, category = "DF", name = L["Vault of the Incarnates"] },
    { id = 432257, type = "spell", iconID = C_Spell.GetSpellInfo(432257).iconID, category = "DF", name = L["Aberrus, the Shadowed Crucible"] },
    { id = 432258, type = "spell", iconID = C_Spell.GetSpellInfo(432258).iconID, category = "DF", name = L["Amirdrassil, the Dream's Hope"] },

    -- TWW
    { id = 445416, type = "spell", iconID = C_Spell.GetSpellInfo(445416).iconID, category = "TWW", name = L["City of Threads"] },
    { id = 445414, type = "spell", iconID = C_Spell.GetSpellInfo(445414).iconID, category = "TWW", name = L["The Dawnbreaker"] },
    { id = 445269, type = "spell", iconID = C_Spell.GetSpellInfo(445269).iconID, category = "TWW", name = L["The Stonevault"] },
    { id = 445443, type = "spell", iconID = C_Spell.GetSpellInfo(445443).iconID, category = "TWW", name = L["The Rookery"] },
    { id = 445440, type = "spell", iconID = C_Spell.GetSpellInfo(445440).iconID, category = "TWW", name = L["Cinderbrew Meadery"] },
    { id = 445444, type = "spell", iconID = C_Spell.GetSpellInfo(445444).iconID, category = "TWW", name = L["Priory of the Sacred Flame"] },
    { id = 445417, type = "spell", iconID = C_Spell.GetSpellInfo(445417).iconID, category = "TWW", name = L["Ara-Kara, City of Echoes"] },
    { id = 445441, type = "spell", iconID = C_Spell.GetSpellInfo(445441).iconID, category = "TWW", name = L["Darkflame Cleft"] },
    { id = 1216786, type = "spell", iconID = C_Spell.GetSpellInfo(1216786).iconID, category = "TWW", name = L["Operation: Floodgate"] },
    { id = 1237215, type = "spell", iconID = C_Spell.GetSpellInfo(1237215).iconID, category = "TWW", name = L["Eco-Dome Al'dani"] },
    { id = 1226482, type = "spell", iconID = C_Spell.GetSpellInfo(1226482).iconID, category = "TWW", name = L["Liberation of Undermine"] },
    { id = 1239155, type = "spell", iconID = C_Spell.GetSpellInfo(1239155).iconID, category = "TWW", name = L["Manaforge Omega"] },

    -- Wormhole
    { id = 30542, type = "item", iconID = C_Item.GetItemInfoInstant(30542).iconID, category = "CATA", name = L["Dimensional Ripper - Area 52"] },
    { id = 18984, type = "item", iconID = C_Item.GetItemInfoInstant(18984).iconID, category = "CATA", name = L["Dimensional Ripper - Everlook"] },
    { id = 18986, type = "item", iconID = C_Item.GetItemInfoInstant(18986).iconID, category = "CATA", name = L["Ultrasafe Transporter: Gadgetzan"] },
    { id = 30544, type = "item", iconID = C_Item.GetItemInfoInstant(30544).iconID, category = "CATA", name = L["Ultrasafe Transporter: Toshley's Station"] },
    { id = 48933, type = "item", iconID = C_Item.GetItemInfoInstant(48933).iconID, category = "NL", name = L["Wormhole Generator: Northrend"] },
    { id = 87215, type = "item", iconID = C_Item.GetItemInfoInstant(87215).iconID, category = "MoP", name = L["Wormhole Generator: Pandaria"] },
    { id = 112059, type = "item", iconID = C_Item.GetItemInfoInstant(112059).iconID, category = "WoD", name = L["Wormhole Centrifuge (Dreanor)"] },
    { id = 151652, type = "item", iconID = C_Item.GetItemInfoInstant(151652).iconID, category = "Legion", name = L["Wormhole Generator: Argus"] },
    { id = 168807, type = "item", iconID = C_Item.GetItemInfoInstant(168807).iconID, category = "BfA", name = L["Wormhole Generator: Kul Tiras"] },
    { id = 168808, type = "item", iconID = C_Item.GetItemInfoInstant(168808).iconID, category = "BfA", name = L["Wormhole Generator: Zandalar"] },
    { id = 172924, type = "item", iconID = C_Item.GetItemInfoInstant(172924).iconID, category = "SL", name = L["Wormhole Generator: Shadowlands"] },
    { id = 198156, type = "item", iconID = C_Item.GetItemInfoInstant(198156).iconID, category = "DF", name = L["Wyrmhole Generator: Dragon Isles"] },
    { id = 221966, type = "item", iconID = C_Item.GetItemInfoInstant(221966).iconID, category = "TWW", name = L["Wormhole Generator: Khaz Algar"] },
}



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
