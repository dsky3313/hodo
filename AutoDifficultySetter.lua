-- 1. [설정 영역] 사용자가 원하는 난이도 번호를 지정합니다.
local CONFIG = {
    dungeon = 3, -- 던전 설정 (1: 일반, 2: 영웅, 3: 신화)
    raid    = 3, -- 공격대 설정 (1: 일반, 2: 영웅, 3: 신화)
    legacy  = 2, -- 옛 공격대 크기 (1: 10인, 2: 25인)
}

-- 2. [ID 매핑 테이블] 설정 번호를 와우 내부 시스템 ID로 변환합니다.
local IDS = {
    dungeon = { [1] = 1, [2] = 2, [3] = 23 },  -- 23번은 신화 던전 ID
    raid    = { [1] = 14, [2] = 15, [3] = 16 }, -- 14: 일반, 15: 영웅, 16: 신화 레이드
    legacy  = { [1] = 3, [2] = 4 }              -- 3: 10인, 4: 25인
}

-- 3. [이름 매핑 테이블] 채팅창에 출력할 한글 텍스트입니다.
local NAMES = {
    dungeon = { [1] = "일반", [2] = "영웅", [3] = "신화" },
    raid    = { [1] = "일반", [2] = "영웅", [3] = "신화" },
    legacy  = { [1] = "10인", [2] = "25인" }
}

-- 내가 이전에 파티장이었는지 기억하는 변수 (중복 실행 방지용)
local amILeader = false

-- 4. [핵심 함수] 실제 난이도를 변경하고 채팅으로 알립니다.
local function UpdateDifficulties()
    -- [안전 장치 1] 내가 파티장이 아니면 실행하지 않음
    if not UnitIsGroupLeader("player") then return end
    
    -- [안전 장치 2] 인스턴스(던전/레이드 등) 내부이거나 전투 중이면 실행하지 않음 (오류 및 튕김 방지)
    -- OR 연산자를 사용하여 하나라도 해당되면 차단합니다.
    if IsInInstance() or UnitAffectingCombat("player") then return end

    -- [난이도 변경 실행] 와우 API를 호출하여 설정값을 적용합니다.
    SetDungeonDifficultyID(IDS.dungeon[CONFIG.dungeon] or 23) -- 던전 난이도 변경
    SetRaidDifficulties(true, IDS.raid[CONFIG.raid] or 16)    -- 공격대 난이도 변경
    SetRaidDifficulties(false, IDS.legacy[CONFIG.legacy] or 4) -- 옛 공격대 크기 변경

    -- [메시지 구성] 채팅창에 보낼 문구 생성
    local msg = string.format("[인스 난이도] 던전(%s), 레이드(%s)", 
        NAMES.dungeon[CONFIG.dungeon], NAMES.raid[CONFIG.raid])

    -- [채팅 전송] 파티 상태면 파티 채팅으로, 혼자면 나에게만 표시
    if IsInGroup(LE_PARTY_CATEGORY_HOME) then
        SendChatMessage(msg, "PARTY") -- 파티 채팅(/p)으로 전송
    else
        print("|cff00ff00" .. msg .. "|r") -- 내 화면에 초록색 글자로 표시
    end
end

-- 5. [이벤트 관리] 게임의 특정 상황을 감시합니다.
local frame = CreateFrame("Frame")
frame:RegisterEvent("PARTY_LEADER_CHANGED") -- 파티장이 바뀌었을 때 발생
frame:RegisterEvent("PLAYER_ENTERING_WORLD") -- 로딩 화면이 끝났을 때 발생

frame:SetScript("OnEvent", function(self, event)
    -- [상황 1] 게임 접속 또는 로딩이 끝났을 때
    if event == "PLAYER_ENTERING_WORLD" then
        -- 로딩 직후엔 서버 데이터가 불안정하므로 3초 뒤에 실행
        C_Timer.After(3, function()
            amILeader = UnitIsGroupLeader("player") -- 현재 파티장 상태 기록
            if amILeader then UpdateDifficulties() end -- 파티장이면 난이도 맞춤
        end)
        
    -- [상황 2] 파티장이 바뀌었을 때
    elseif event == "PARTY_LEADER_CHANGED" then
        local currentlyLeader = UnitIsGroupLeader("player")
        
        -- 이전에 파티장이 아니었다가(not amILeader) 지금 파티장이 되었을 때만 실행
        if currentlyLeader and not amILeader then
            UpdateDifficulties()
        end
        
        -- 현재 상태를 다시 저장 (다음 이벤트를 위해)
        amILeader = currentlyLeader
    end
end)