--------------------------------------
-- Background
--------------------------------------

local TeleportBackground = CreateFrame("Frame", "TeleportMenuFrame", GameMenuFrame, "BackdropTemplate") -- 배경 생성
TeleportBackground:SetSize(220, 300) -- 크기 설정
TeleportBackground:SetPoint("TOPLEFT", GameMenuFrame, "TOPRIGHT", 0, 0) -- 위치 설정

NineSliceUtil.ApplyLayoutByName(TeleportBackground, "Dialog") -- NineSlice 레이아웃 적용

TeleportBackground.Bg = TeleportBackground:CreateTexture(nil, "BACKGROUND") -- 배경 텍스처 생성
TeleportBackground.Bg:SetPoint("TOPLEFT", 8, -8)
TeleportBackground.Bg:SetPoint("BOTTOMRIGHT", -8, 8)
TeleportBackground.Bg:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Background-Dark") -- 배경 텍스쳐 설정
TeleportBackground.Bg:SetHorizTile(true)
TeleportBackground.Bg:SetVertTile(true)
TeleportBackground.Bg:SetAlpha(0.7) -- 투명도 설정


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

-- 6. 하이라이트 (마우스 올리면 반짝이게)
button:SetHighlightTexture("Interface\\Buttons\\ButtonHilight-Square")
button:SetPushedTexture("Interface\\Buttons\\UI-Quickslot-Depress")



--[[ 
CreateFrame 함수 : 생성할 프레임의 종류, 이름, 부모 프레임, 템플릿
	local frame = CreateFrame("frameType", "frameName", parentFrame, "template")
ㅇㄹ
ㄹㅇ
123
]]
