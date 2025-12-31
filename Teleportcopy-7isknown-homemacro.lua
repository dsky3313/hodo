--------------------------------------
-- 테이블
--------------------------------------
local L = setmetatable({}, { __index = function(t, k) return k end })

local teleportTable = {
    -- Classic
    { spellID = 1233637, type = "macro", iconID = 409599, category = "11", name = L["하우징"] },
    { spellID = 18984, type = "item", iconID = 133873, category = "Classic", name = L["기공얼라"] },
    { spellID = 18986, type = "item", iconID = 133870, category = "Classic", name = L["기공호드"] },

    -- BC
    { spellID = 30544, type = "item", iconID = 321487, category = "BC", name = L["기공얼라"] },
    { spellID = 30542, type = "item", iconID = 133865, category = "BC", name = L["기공호드"] },

    -- WoL
    { spellID = 48933, type = "item", iconID = 135778, category = "WoL", name = L["기공"] },

    -- CATA
    { spellID = 410080, type = "spell", iconID = 409599, category = "CATA", name = L["소용돌이"] },
    { spellID = 424142, type = "spell", iconID = 409600, category = "CATA", name = L["파도"] },
    { spellID = 445424, type = "spell", iconID = 409596, category = "CATA", name = L["그림바톨"] },

    -- MoP
    { spellID = 87215, type = "item", iconID = 651094, category = "MoP", name = L["기공"] },
    { spellID = 131204, type = "spell", iconID = 603529, category = "MoP", name = L["옥룡사"] },
    { spellID = 131205, type = "spell", iconID = 594272, category = "MoP", name = L["Stormstout Brewery"] },
    { spellID = 131206, type = "spell", iconID = 603795, category = "MoP", name = L["Shado-Pan Monastery"] },
    { spellID = 131222, type = "spell", iconID = 615499, category = "MoP", name = L["Mogu'shan Palace"] },
    { spellID = 131225, type = "spell", iconID = 603962, category = "MoP", name = L["Gate of the Setting Sun"] },
    { spellID = 131228, type = "spell", iconID = 615986, category = "MoP", name = L["Siege of Niuzao Temple"] },
    { spellID = 131229, type = "spell", iconID = 135955, category = "MoP", name = L["Scarlet Monastery"] },
    { spellID = 131231, type = "spell", iconID = 133154, category = "MoP", name = L["Scarlet Halls"] },
    { spellID = 131232, type = "spell", iconID = 135974, category = "MoP", name = L["Scholomance"] },

    -- WoD
    { spellID = 112059, type = "item", iconID = 892831, category = "WoD", name = L["기공"] },
    { spellID = 159901, type = "spell", iconID = 1052644, category = "WoD", name = L["상록숲"] },
    { spellID = 159899, type = "spell", iconID = 1002600, category = "WoD", name = L["어둠달"] },
    { spellID = 159900, type = "spell", iconID = 1002598, category = "WoD", name = L["정비소"] },
    { spellID = 159896, type = "spell", iconID = 1003154, category = "WoD", name = L["선착장"] },
    { spellID = 159895, type = "spell", iconID = 1002599, category = "WoD", name = L["Bloodmaul Slag Mines"] },
    { spellID = 159897, type = "spell", iconID = 1002597, category = "WoD", name = L["Auchindoun"] },
    { spellID = 159898, type = "spell", iconID = 1002596, category = "WoD", name = L["Skyreach"] },
    { spellID = 159902, type = "spell", iconID = 1002601, category = "WoD", name = L["Upper Blackrock Spire"] },

    -- Legion
    { spellID = 151652, type = "item", iconID = 237560, category = "Legion", name = L["기공"] },
    { spellID = 393764, type = "spell", iconID = 1417427, category = "Legion", name = L["용맹"] },
    { spellID = 410078, type = "spell", iconID = 1417429, category = "Legion", name = L["넬둥"] },
    { spellID = 393766, type = "spell", iconID = 1417424, category = "Legion", name = L["별궁"] },
    { spellID = 373262, type = "spell", iconID = 1530372, category = "Legion", name = L["카라잔"] },
    { spellID = 424153, type = "spell", iconID = 1417423, category = "Legion", name = L["검떼"] },
    { spellID = 424163, type = "spell", iconID = 1417425, category = "Legion", name = L["어숲"] },

    -- BfA
    { spellID = 168807, type = "item", iconID = 2000841, category = "BfA", name = L["기공얼라"] },
    { spellID = 168808, type = "item", iconID = 2000840, category = "BfA", name = L["기공호드"] },
    { spellID = 410071, type = "spell", iconID = 2011112, category = "BfA", name = L["자유지대"] },
    { spellID = 410074, type = "spell", iconID = 2011151, category = "BfA", name = L["썩은굴"] },
    { spellID = 373274, type = "spell", iconID = 3024540, category = "BfA", name = L["메카곤"] },
    { spellID = 424167, type = "spell", iconID = 2011154, category = "BfA", name = L["저택"] },
    { spellID = 424187, type = "spell", iconID = 2011105, category = "BfA", name = L["아탈"] },
    { spellID = 445418, type = "spell", iconID = 2011139, category = "BfA", name = L["보랄"] },
    { spellID = 464256, type = "spell", iconID = 2011139, category = "BfA", name = L["보랄"] },
    { spellID = 467553, type = "spell", iconID = 2011121, category = "BfA", name = L["왕노"] },
    { spellID = 467555, type = "spell", iconID = 2011121, category = "BfA", name = L["왕노"] },

    -- SL
    { spellID = 172924, type = "item", iconID = 3610528, category = "SL", name = L["기공"] },
    { spellID = 354462, type = "spell", iconID = 3601560, category = "SL", name = L["죽상"] },
    { spellID = 354463, type = "spell", iconID = 3601535, category = "SL", name = L["역병"] },
    { spellID = 354464, type = "spell", iconID = 3601531, category = "SL", name = L["티르너"] },
    { spellID = 354465, type = "spell", iconID = 3601526, category = "SL", name = L["속죄"] },
    { spellID = 354466, type = "spell", iconID = 3601545, category = "SL", name = L["승천"] },
    { spellID = 354467, type = "spell", iconID = 3601550, category = "SL", name = L["고투"] },
    { spellID = 354468, type = "spell", iconID = 3601561, category = "SL", name = L["저편"] },
    { spellID = 354469, type = "spell", iconID = 3601540, category = "SL", name = L["핏빛"] },
    { spellID = 367416, type = "spell", iconID = 4062727, category = "SL", name = L["타자베쉬"] },
    { spellID = 373190, type = "spell", iconID = 3614361, category = "SL", name = L["나스리아"] },
    { spellID = 373191, type = "spell", iconID = 4062765, category = "SL", name = L["지배"] },
    { spellID = 373192, type = "spell", iconID = 4254074, category = "SL", name = L["태존매"] },

    -- DF
    { spellID = 198156, type = "item", iconID = 4548860, category = "DF", name = L["기공"] },
    { spellID = 393256, type = "spell", iconID = 4578416, category = "DF", name = L["루비"] },
    { spellID = 393262, type = "spell", iconID = 4578413, category = "DF", name = L["노쿠드"] },
    { spellID = 393267, type = "spell", iconID = 4578412, category = "DF", name = L["담쟁이"] },
    { spellID = 393273, type = "spell", iconID = 4578414, category = "DF", name = L["대학"] },
    { spellID = 393276, type = "spell", iconID = 4578417, category = "DF", name = L["넬타"] },
    { spellID = 393279, type = "spell", iconID = 4578411, category = "DF", name = L["보관소"] },
    { spellID = 393283, type = "spell", iconID = 4578415, category = "DF", name = L["주입"] },
    { spellID = 393222, type = "spell", iconID = 4578418, category = "DF", name = L["울다만"] },
    { spellID = 424197, type = "spell", iconID = 5247561, category = "DF", name = L["여명"] },
    { spellID = 432254, type = "spell", iconID = 4630363, category = "DF", name = L["금고"] },
    { spellID = 432257, type = "spell", iconID = 5161748, category = "DF", name = L["아베루스"] },
    { spellID = 432258, type = "spell", iconID = 5342929, category = "DF", name = L["아미드랏실"] },

    -- TWW
    { spellID = 221966, type = "item", iconID = 4548859, category = "TWW", name = L["기공"] },
    { spellID = 445416, type = "spell", iconID = 5899328, category = "TWW", name = L["실타래"] },
    { spellID = 445414, type = "spell", iconID = 5899330, category = "TWW", name = L["새인호"] },
    { spellID = 445269, type = "spell", iconID = 5899333, category = "TWW", name = L["바금"] },
    { spellID = 445443, type = "spell", iconID = 5899332, category = "TWW", name = L["부화장"] },
    { spellID = 445440, type = "spell", iconID = 5899327, category = "TWW", name = L["양조장"] },
    { spellID = 445444, type = "spell", iconID = 5899331, category = "TWW", name = L["수도원"] },
    { spellID = 445417, type = "spell", iconID = 5899326, category = "TWW", name = L["아라카라"] },
    { spellID = 445441, type = "spell", iconID = 5899329, category = "TWW", name = L["어불동"] },
    { spellID = 1216786, type = "spell", iconID = 6392629, category = "TWW", name = L["수문"] },
    { spellID = 1237215, type = "spell", iconID = 6921877, category = "TWW", name = L["알다니"] },
    { spellID = 1226482, type = "spell", iconID = 6392630, category = "TWW", name = L["언더마인"] },
    { spellID = 1239155, type = "spell", iconID = 6997112, category = "TWW", name = L["마괴종"] },
}


--------------------------------------
-- 배경
--------------------------------------

local TeleportBackground = CreateFrame("Frame", "TeleportMenuFrame", GameMenuFrame, "BackdropTemplate") -- 배경 생성
TeleportBackground:SetSize(650, 600) -- 크기 설정
TeleportBackground:SetPoint("TOPLEFT", GameMenuFrame, "TOPRIGHT", 30, 0) -- 위치 설정

NineSliceUtil.ApplyLayoutByName(TeleportBackground, "Dialog") -- NineSlice 레이아웃 적용

TeleportBackground.Bg = TeleportBackground:CreateTexture(nil, "BACKGROUND")
TeleportBackground.Bg:SetPoint("TOPLEFT", 8, -8)
TeleportBackground.Bg:SetPoint("BOTTOMRIGHT", -8, 8)
TeleportBackground.Bg:SetAtlas("UI-DialogBox-Background-Dark")
TeleportBackground.Bg:SetAlpha(0.7)

--------------------------------------
-- 아이콘
--------------------------------------

local BUTTON_SIZE = 40   -- 버튼 크기
local START_X = 20
local START_Y = -20
local SPACING = 3        -- 버튼 간격
local SECTION_GAP = 10   -- 확장팩(섹션) 사이의 간격
local COLS = 20           -- 한 줄에 20개

local currentCategory = ""
local col, row = 0, 0
local totalOffset = 0    -- 섹션 간격으로 인해 추가되는 Y축 값

for i, data in ipairs(teleportTable) do
    -- [수집/학습 여부 판별 로직]
    local isKnown = false
        if data.type == "spell" then
            isKnown = IsSpellKnown(data.spellID)
        elseif data.type == "item" then
            isKnown = PlayerHasToy(data.spellID) or (C_Item.GetItemCount(data.spellID) > 0)
        else -- type == "icon"
            isKnown = true
        end

    -- [섹션 처리]
    if data.category ~= currentCategory then
        if currentCategory ~= "" then
            row = row + 1
            col = 0
            totalOffset = totalOffset + SECTION_GAP
        end
        currentCategory = data.category
    end

    -- [버튼 생성] SecureActionButtonTemplate 적용 (이름 필수)
    local btn = CreateFrame("Button", "TeleBtn"..i, TeleportBackground, "SecureActionButtonTemplate")
        btn:SetSize(BUTTON_SIZE, BUTTON_SIZE)
    
    local x = START_X + (col * (BUTTON_SIZE + SPACING))
    local y = START_Y - (row * (BUTTON_SIZE + SPACING)) - totalOffset
        btn:SetPoint("TOPLEFT", TeleportBackground, "TOPLEFT", x, y)

    
    -- [디자인: 배경 슬롯]
    local slot = btn:CreateTexture(nil, "BACKGROUND")
        slot:SetAllPoints()
        slot:SetAtlas("UI-HUD-ActionBar-IconFrame-Slot")
    
    -- [디자인: 아이콘]
    local tex = btn:CreateTexture(nil, "ARTWORK")
        tex:SetPoint("TOPLEFT", 2, -2)
        tex:SetPoint("BOTTOMRIGHT", -2, 2)
        tex:SetTexture(data.iconID or 134400)
    
    -- [디자인: 둥근 모서리 마스크]
    local mask = btn:CreateMaskTexture()
        mask:SetAllPoints(tex)
        mask:SetTexture("Interface\\CharacterFrame\\TempPortraitAlphaMask")
        tex:AddMaskTexture(mask)
    
    -- [디자인: 테두리 통일]
    local border = btn:CreateTexture(nil, "OVERLAY")
        border:SetAllPoints()
        border:SetAtlas("UI-HUD-ActionBar-IconFrame")
    
    -- [디자인: 쿨타임 레이어]
    local cd = CreateFrame("Cooldown", "TeleBtnCD"..i, btn, "CooldownFrameTemplate")
        cd:SetAllPoints()
        cd:SetSwipeColor(0, 0, 0, 0.8)
        cd:SetDrawEdge(false) -- 쿨타임 노란선
        btn.cooldown = cd -- 나중에 불러올 수 있게 버튼 객체에 저장

        local eventFrame = CreateFrame("Frame") -- 쿨타임 업데이트

        local function UpdateAllCooldowns()
            -- 창이 열려 있을 때만 버튼들의 쿨타임을 갱신
            for i, data in ipairs(teleportTable) do
                local btn = _G["TeleBtn"..i]
                if btn and btn.cooldown then
                    local start, duration
                    if data.type == "spell" then
                        local cooldownInfo = C_Spell.GetSpellCooldown(data.spellID)
                        start = cooldownInfo and cooldownInfo.startTime or 0
                        duration = cooldownInfo and cooldownInfo.duration or 0
                    elseif data.type == "item" then
                        start, duration = C_Item.GetItemCooldown(data.spellID)
                    end
                    
                    if start and start > 0 and duration > 0 then
                        btn.cooldown:SetCooldown(start, duration)
                    else
                        btn.cooldown:Clear()
                    end
                end
            end
        end

        -- 이벤트가 발생했을 때 실행할 동작
        eventFrame:SetScript("OnEvent", UpdateAllCooldowns)

        -- 창이 열릴 때, 이벤트 등록 + 즉시 업데이트
        TeleportMenuFrame:SetScript("OnShow", function()
            eventFrame:RegisterEvent("SPELL_UPDATE_COOLDOWN")
            eventFrame:RegisterEvent("BAG_UPDATE_COOLDOWN")
            UpdateAllCooldowns()
        end)

        -- 창이 닫힐 때, 이벤트 해제
        TeleportMenuFrame:SetScript("OnHide", function()
            eventFrame:UnregisterEvent("SPELL_UPDATE_COOLDOWN")
            eventFrame:UnregisterEvent("BAG_UPDATE_COOLDOWN")
        end)

 -- [수집/학습 효과]
    if isKnown then
        tex:SetDesaturated(false); btn:SetAlpha(1.0)
        border:SetVertexColor(1, 1, 1)
    else
        tex:SetDesaturated(true); btn:SetAlpha(0.4)
        border:SetVertexColor(0.4, 0.4, 0.4)
    end

   -- [디자인: 텍스트 레이어 추가]
    local nameText = btn:CreateFontString(nil, "OVERLAY", "SystemFont_Outline_Small")
        nameText:SetDrawLayer("OVERLAY", 7)
        nameText:SetIgnoreParentAlpha(true)
        nameText:SetPoint("TOP", btn, "BOTTOM", 0, 3) -- 위치지정
        nameText:SetWidth(BUTTON_SIZE + 20) -- 텍스트가 잘리지 않게 너비를 조금 더 확보
        nameText:SetHeight(13) -- 폰트 크기에 맞춰 높이 조절
        nameText:SetText(data.name) -- 테이블 name = L["..."] 값을 텍스트로 사용
        nameText:SetJustifyH("CENTER") -- 가운데 정렬
        nameText:SetWordWrap(false)    -- 자동 줄바꿈 끄기
        nameText:SetTextColor(1, 1, 1) -- 텍스트 색상 흰색

        local displayName = data.name or ""
        local charCount = strlenutf8(displayName) -- 한글/영문 상관없이 글자 수 계산
        local fontSize = 12 -- 기본 크기
            if charCount >= 4 then
                fontSize = 10   -- 4글자 이상 (아라카라)
            end

        local path = nameText:GetFont()
            nameText:SetFont(path, fontSize, "OUTLINE")
            nameText:SetShadowColor(0, 0, 0, 1)    -- 검은색 그림자
            nameText:SetShadowOffset(1, -1)        -- 그림자 위치

        if isKnown then
            btn:SetAlpha(1.0) -- 버튼과 텍스트 모두 선명
            nameText:SetTextColor(1, 1, 1, 1) -- 마지막 1은 불투명도(Alpha)
            nameText:SetAlpha(1)
        else
            btn:SetAlpha(0.5) -- 버튼과 텍스트 모두 같이 흐려짐 (레이어 동기화)
            nameText:SetTextColor(1, 1, 1, 1) -- 여전히 흰색으로 설정 (원하시면 0.7 정도로 조절)
            nameText:SetAlpha(1)
        end
    
    btn.nameLabel = nameText -- 버튼 객체에 저장
    
    -- [마우스 오버 효과]
    local hl = btn:CreateTexture(nil, "HIGHLIGHT")
        hl:SetAtlas("UI-HUD-ActionBar-IconFrame-MouseOver")
        hl:SetAllPoints()
    
    -- [클릭 효과]
    local pushed = btn:CreateTexture(nil, "OVERLAY")
        pushed:SetAtlas("UI-HUD-ActionBar-IconFrame-Down")
        pushed:SetAllPoints()
        btn:SetPushedTexture(pushed)

    -- [시전 기능 설정] RegisterForClicks와 Attribute 설정
    btn:RegisterForClicks("AnyUp", "AnyDown")

        if data.type == "spell" then
            btn:SetAttribute("type", "spell")
            btn:SetAttribute("spell", data.spellID)
        elseif data.type == "item" then
            btn:SetAttribute("type", "item")
            btn:SetAttribute("item", "item:"..data.spellID) -- ID 형식으로 언어 문제 방지
        elseif data.name == L["하우징"] then -- 테이블에 '하우징' 항목이 있다고 가정
            btn:SetAttribute("type", "macro")
            btn:SetAttribute("macrotext", "/run m=IsModifierKeyDown() and 2 or 1 EventUtil.RegisterOnceFrameEventAndCallback('PLAYER_HOUSE_LIST_UPDATED',function(a)h=a[m]C_Housing.TeleportHome(h.neighborhoodGUID,h.houseGUID,h.plotID)end)C_Housing.GetPlayerOwnedHouses()")
        elseif data.type == "macro" then
            btn:SetAttribute("type", "macro")
            btn:SetAttribute("macrotext", data.macro or "")
        end
    
    -- [툴팁]
    btn:SetScript("OnEnter", function(self)
        GameTooltip:SetOwner(self, "ANCHOR_RIGHT")

        if data.type == "spell" then 
            GameTooltip:SetSpellByID(data.spellID)
        elseif data.type == "item" then 
            GameTooltip:SetItemByID(data.spellID)
        else GameTooltip:SetText(data.name) end
        GameTooltip:Show()
    end)
    
    btn:SetScript("OnLeave", GameTooltip_Hide)
    
    -- [좌표 업데이트]
    col = col + 1
    if col >= COLS then 
        col = 0; row = row + 1 end
end








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



--------------------------------------
-- 테이블
--------------------------------------
local L = setmetatable({}, { __index = function(t, k) return k end })

local teleportTable = {
    -- Classic

    -- BC
    
    -- WoL
    { id = 48933, type = "item", iconID = 135778, category = "WoL", name = L["Wormhole Generator: Northrend"] },

    -- CATA
    { id = 30542, type = "item", iconID = 133865, category = "CATA", name = L["Dimensional Ripper - Area 52"] },
    { id = 18984, type = "item", iconID = 133873, category = "CATA", name = L["Dimensional Ripper - Everlook"] },
    { id = 18986, type = "item", iconID = 133870, category = "CATA", name = L["Ultrasafe Transporter: Gadgetzan"] },
    { id = 30544, type = "item", iconID = 321487, category = "CATA", name = L["Ultrasafe Transporter: Toshley's Station"] },
    { id = 410080, type = "spell", iconID = 409599, category = "CATA", name = L["The Vortex Pinnacle"] },
    { id = 424142, type = "spell", iconID = 409600, category = "CATA", name = L["Throne of the Tides"] },
    { id = 445424, type = "spell", iconID = 409596, category = "CATA", name = L["Grim Batol"] },

    -- MoP
    { id = 87215, type = "item", iconID = 651094, category = "MoP", name = L["Wormhole Generator: Pandaria"] },
    { id = 131204, type = "spell", iconID = 603529, category = "MoP", name = L["Temple of the Jade Serpent"] },
    { id = 131205, type = "spell", iconID = 594272, category = "MoP", name = L["Stormstout Brewery"] },
    { id = 131206, type = "spell", iconID = 603795, category = "MoP", name = L["Shado-Pan Monastery"] },
    { id = 131222, type = "spell", iconID = 615499, category = "MoP", name = L["Mogu'shan Palace"] },
    { id = 131225, type = "spell", iconID = 603962, category = "MoP", name = L["Gate of the Setting Sun"] },
    { id = 131228, type = "spell", iconID = 615986, category = "MoP", name = L["Siege of Niuzao Temple"] },
    { id = 131229, type = "spell", iconID = 135955, category = "MoP", name = L["Scarlet Monastery"] },
    { id = 131231, type = "spell", iconID = 133154, category = "MoP", name = L["Scarlet Halls"] },
    { id = 131232, type = "spell", iconID = 135974, category = "MoP", name = L["Scholomance"] },

    -- WoD
    { id = 112059, type = "item", iconID = 892831, category = "WoD", name = L["Wormhole Centrifuge (Dreanor)"] },
    { id = 159901, type = "spell", iconID = 1052644, category = "WoD", name = L["The Everbloom"] },
    { id = 159899, type = "spell", iconID = 1002600, category = "WoD", name = L["Shadowmoon Burial Grounds"] },
    { id = 159900, type = "spell", iconID = 1002598, category = "WoD", name = L["Grimrail Depot"] },
    { id = 159896, type = "spell", iconID = 1003154, category = "WoD", name = L["Iron Docks"] },
    { id = 159895, type = "spell", iconID = 1002599, category = "WoD", name = L["Bloodmaul Slag Mines"] },
    { id = 159897, type = "spell", iconID = 1002597, category = "WoD", name = L["Auchindoun"] },
    { id = 159898, type = "spell", iconID = 1002596, category = "WoD", name = L["Skyreach"] },
    { id = 159902, type = "spell", iconID = 1002601, category = "WoD", name = L["Upper Blackrock Spire"] },

    -- Legion
    { id = 151652, type = "item", iconID = 237560, category = "Legion", name = L["Wormhole Generator: Argus"] },
    { id = 393764, type = "spell", iconID = 1417427, category = "Legion", name = L["Halls of Valor"] },
    { id = 410078, type = "spell", iconID = 1417429, category = "Legion", name = L["Neltharion's Lair"] },
    { id = 393766, type = "spell", iconID = 1417424, category = "Legion", name = L["Court of Stars"] },
    { id = 373262, type = "spell", iconID = 1530372, category = "Legion", name = L["Karazhan"] },
    { id = 424153, type = "spell", iconID = 1417423, category = "Legion", name = L["Black Rook Hold"] },
    { id = 424163, type = "spell", iconID = 1417425, category = "Legion", name = L["Darkheart Thicket"] },

    -- BfA
    { id = 168807, type = "item", iconID = 2000841, category = "BfA", name = L["Wormhole Generator: Kul Tiras"] },
    { id = 168808, type = "item", iconID = 2000840, category = "BfA", name = L["Wormhole Generator: Zandalar"] },
    { id = 410071, type = "spell", iconID = 2011112, category = "BfA", name = L["Freehold"] },
    { id = 410074, type = "spell", iconID = 2011151, category = "BfA", name = L["The Underrot"] },
    { id = 373274, type = "spell", iconID = 3024540, category = "BfA", name = L["Mechagon"] },
    { id = 424167, type = "spell", iconID = 2011154, category = "BfA", name = L["Waycrest Manor"] },
    { id = 424187, type = "spell", iconID = 2011105, category = "BfA", name = L["Atal'Dazar"] },
    { id = 445418, type = "spell", iconID = 2011139, category = "BfA", name = L["Siege of Boralus"] },
    { id = 464256, type = "spell", iconID = 2011139, category = "BfA", name = L["Siege of Boralus"] },
    { id = 467553, type = "spell", iconID = 2011121, category = "BfA", name = L["The MOTHERLODE!!"] },
    { id = 467555, type = "spell", iconID = 2011121, category = "BfA", name = L["The MOTHERLODE!!"] },

    -- SL
    { id = 172924, type = "item", iconID = 3610528, category = "SL", name = L["Wormhole Generator: Shadowlands"] },
    { id = 354462, type = "spell", iconID = 3601560, category = "SL", name = L["The Necrotic Wake"] },
    { id = 354463, type = "spell", iconID = 3601535, category = "SL", name = L["Plaguefall"] },
    { id = 354464, type = "spell", iconID = 3601531, category = "SL", name = L["Mists of Tirna Scithe"] },
    { id = 354465, type = "spell", iconID = 3601526, category = "SL", name = L["Halls of Atonement"] },
    { id = 354466, type = "spell", iconID = 3601545, category = "SL", name = L["Bastion"] },
    { id = 354467, type = "spell", iconID = 3601550, category = "SL", name = L["Theater of Pain"] },
    { id = 354468, type = "spell", iconID = 3601561, category = "SL", name = L["De Other Side"] },
    { id = 354469, type = "spell", iconID = 3601540, category = "SL", name = L["Sanguine Depths"] },
    { id = 367416, type = "spell", iconID = 4062727, category = "SL", name = L["Tazavesh, the Veiled Market"] },
    { id = 373190, type = "spell", iconID = 3614361, category = "SL", name = L["Castle Nathria"] },
    { id = 373191, type = "spell", iconID = 4062765, category = "SL", name = L["Sanctum of Domination"] },
    { id = 373192, type = "spell", iconID = 4254074, category = "SL", name = L["Sepulcher of the First Ones"] },

    -- DF
    { id = 198156, type = "item", iconID = 4548860, category = "DF", name = L["Wyrmhole Generator: Dragon Isles"] },
    { id = 393256, type = "spell", iconID = 4578416, category = "DF", name = L["Ruby Life Pools"] },
    { id = 393262, type = "spell", iconID = 4578413, category = "DF", name = L["The Nokhud Offensive"] },
    { id = 393267, type = "spell", iconID = 4578412, category = "DF", name = L["Brackenhide Hollow"] },
    { id = 393273, type = "spell", iconID = 4578414, category = "DF", name = L["Algeth'ar Academy"] },
    { id = 393276, type = "spell", iconID = 4578417, category = "DF", name = L["Neltharus"] },
    { id = 393279, type = "spell", iconID = 4578411, category = "DF", name = L["The Azure Vault"] },
    { id = 393283, type = "spell", iconID = 4578415, category = "DF", name = L["Halls of Infusion"] },
    { id = 393222, type = "spell", iconID = 4578418, category = "DF", name = L["Uldaman"] },
    { id = 424197, type = "spell", iconID = 5247561, category = "DF", name = L["Dawn of the Infinite"] },
    { id = 432254, type = "spell", iconID = 4630363, category = "DF", name = L["Vault of the Incarnates"] },
    { id = 432257, type = "spell", iconID = 5161748, category = "DF", name = L["Aberrus, the Shadowed Crucible"] },
    { id = 432258, type = "spell", iconID = 5342929, category = "DF", name = L["Amirdrassil, the Dream's Hope"] },

    -- TWW
    { id = 221966, type = "item", iconID = 4548859, category = "TWW", name = L["Wormhole Generator: Khaz Algar"] },
    { id = 445416, type = "spell", iconID = 5899328, category = "TWW", name = L["City of Threads"] },
    { id = 445414, type = "spell", iconID = 5899330, category = "TWW", name = L["The Dawnbreaker"] },
    { id = 445269, type = "spell", iconID = 5899333, category = "TWW", name = L["The Stonevault"] },
    { id = 445443, type = "spell", iconID = 5899332, category = "TWW", name = L["The Rookery"] },
    { id = 445440, type = "spell", iconID = 5899327, category = "TWW", name = L["Cinderbrew Meadery"] },
    { id = 445444, type = "spell", iconID = 5899331, category = "TWW", name = L["Priory of the Sacred Flame"] },
    { id = 445417, type = "spell", iconID = 5899326, category = "TWW", name = L["Ara-Kara, City of Echoes"] },
    { id = 445441, type = "spell", iconID = 5899329, category = "TWW", name = L["Darkflame Cleft"] },
    { id = 1216786, type = "spell", iconID = 6392629, category = "TWW", name = L["Operation: Floodgate"] },
    { id = 1237215, type = "spell", iconID = 6921877, category = "TWW", name = L["Eco-Dome Al'dani"] },
    { id = 1226482, type = "spell", iconID = 6392630, category = "TWW", name = L["Liberation of Undermine"] },
    { id = 1239155, type = "spell", iconID = 6997112, category = "TWW", name = L["Manaforge Omega"] },
}
















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
