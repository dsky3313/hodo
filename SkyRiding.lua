local _, ns = ...;

-- 1. Falcon 스타일 설정
ns.config = {
    font        = STANDARD_TEXT_FONT,
    fontSize    = 13,
    fontOutline = "OUTLINE",
    width       = 220,  -- Falcon처럼 조금 더 슬림하게
    height      = 6,    -- 매우 얇은 메인 바
    comboheight = 4,    -- 더 얇은 기력 바
    xpoint      = 0,
    ypoint      = -150, -- 캐릭터 하단 배치
};

ns.maxcombos = {};
ns.combobars = { {}, {} }; -- 1단, 2단 콤보바 저장소

local statusbarcolors = {
    [1] = {r = 0, g = 0.8, b = 1}, -- 쇄도 (하늘색)
    [2] = {r = 1, g = 0.5, b = 0}, -- 상승 (주황색)
}

-- 2. UI 초기화 함수
local function init_ui()
    -- 메인 프레임
    ns.frame = CreateFrame("FRAME", "MySkyRideFrame", UIParent);
    ns.frame:SetPoint("CENTER", UIParent, "CENTER", ns.config.xpoint, ns.config.ypoint)
    ns.frame:SetSize(ns.config.width, ns.config.height)

    -- 메인 속도 바 (Falcon 스타일: 배경은 어둡게, 바는 밝게)
    ns.bar = CreateFrame("StatusBar", nil, ns.frame)
    ns.bar:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8") -- 깔끔한 단색 테스처
    ns.bar:SetAllPoints(ns.frame)
    ns.bar:SetStatusBarColor(1, 1, 1, 0.7)
    
    ns.bar.bg = ns.bar:CreateTexture(nil, "BACKGROUND")
    ns.bar.bg:SetAllPoints(true)
    ns.bar.bg:SetColorTexture(0, 0, 0, 0.5)

    -- 속도 텍스트 (바 오른쪽에 작게 표시)
    ns.bar.text = ns.bar:CreateFontString(nil, "OVERLAY")
    ns.bar.text:SetFont(ns.config.font, ns.config.fontSize, ns.config.fontOutline)
    ns.bar.text:SetPoint("BOTTOM", ns.bar, "TOP", 0, 10)

    -- 기력(충전) 바 생성 (2줄)
    for row = 1, 2 do
        for i = 1, 10 do
            local cb = CreateFrame("StatusBar", nil, ns.frame)
            cb:SetStatusBarTexture("Interface\\Buttons\\WHITE8X8")
            cb:SetHeight(ns.config.comboheight)
            cb:SetStatusBarColor(statusbarcolors[row].r, statusbarcolors[row].g, statusbarcolors[row].b)
            
            cb.bg = cb:CreateTexture(nil, "BACKGROUND")
            cb.bg:SetAllPoints(true)
            cb.bg:SetColorTexture(0, 0, 0, 0.4)
            
            if i == 1 then
                local yOff = (row == 1) and -6 or -12
                cb:SetPoint("TOPLEFT", ns.bar, "BOTTOMLEFT", 0, yOff)
            else
                cb:SetPoint("LEFT", ns.combobars[row][i-1], "RIGHT", 2, 0)
            end
            cb:Hide()
            ns.combobars[row][i] = cb
        end
    end
end

-- 3. 로직 함수 (Falcon의 반응성 구현)
local function update_all()
    if not IsFlying() then
        ns.frame:Hide()
        return
    end
    ns.frame:Show()

    -- 속도 업데이트
    local _, _, forwardSpeed = C_PlayerInfo.GetGlidingInfo()
    local movespeed = math.floor((forwardSpeed or GetUnitSpeed("player")) / 7 * 100)
    
    ns.bar:SetMinMaxValues(0, 1100)
    ns.bar:SetValue(movespeed)
    ns.bar.text:SetText(movespeed .. "%")

    -- 충전량 업데이트 (주신 코드 로직 최적화)
    local spells = {372608, 425782}
    for index, spellID in ipairs(spells) do
        local chargeInfo = C_Spell.GetSpellCharges(spellID)
        if chargeInfo then
            local max = chargeInfo.maxCharges
            local cur = chargeInfo.currentCharges
            local width = (ns.config.width - (2 * (max - 1))) / max
            
            for i = 1, 10 do
                local cb = ns.combobars[index][i]
                if i <= max then
                    cb:SetWidth(width)
                    cb:Show()
                    cb:SetValue(i <= cur and 1 or 0.3) -- 충전됨: 밝게, 충전중: 흐리게
                else
                    cb:Hide()
                end
            end
        end
    end
end

-- 실행
init_ui()
C_Timer.NewTicker(0.05, update_all) -- Falcon처럼 부드러운 반응을 위해 0.05초