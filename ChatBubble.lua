-- ==========================================
-- 말풍선 폰트 변경 스크립트
-- ==========================================

-- 1. 설정값 (원하는 폰트 경로와 크기를 입력하세요)
-- 기본적으로 와우 기본 폰트 경로를 적거나, 직접 가지고 있는 폰트 경로를 입력합니다.
local FONT_PATH = "Fonts\\2002.TTF" -- 한글 폰트 경로 (예: 2002.TTF 또는 2002B.TTF)
local FONT_SIZE = 10                -- 폰트 크기
local FONT_FLAG = "OUTLINE"         -- 외곽선 설정 ("OUTLINE", "THICKOUTLINE", "MONOCHROME" 등)

-- 2. 실제 폰트를 적용하는 함수
local function ApplyChatBubbleFont()
    -- ChatBubbleFont는 게임 내 말풍선 텍스트를 담당하는 전역 객체입니다.
    if ChatBubbleFont then
        ChatBubbleFont:SetFont(FONT_PATH, FONT_SIZE, FONT_FLAG)
        
        -- 가끔 적용이 안 되는 하위 객체들을 위해 추가 설정 (선택 사항)
        if ChatBubbleFontGeneral then
            ChatBubbleFontGeneral:SetFont(FONT_PATH, FONT_SIZE, FONT_FLAG)
        end
    end
end

-- 3. 이벤트 등록 (게임 접속 시 실행)
local frame = CreateFrame("Frame")
frame:RegisterEvent("PLAYER_ENTERING_WORLD") -- 캐릭터가 접속하거나 로딩이 끝났을 때
frame:SetScript("OnEvent", function(self, event, ...)
    ApplyChatBubbleFont()
    
    -- 한 번 적용 후 프레임 제거 (메모리 절약)
    self:UnregisterAllEvents()
end)

-- 4. (참고) 다른 애드온이 폰트를 덮어쓰는 경우를 대비해 1초 뒤에 한 번 더 실행
C_Timer.After(0.5, function()
    ApplyChatBubbleFont()
end)