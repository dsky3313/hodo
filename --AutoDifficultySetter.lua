-- =================================================================
-- [설정] 여기서 원하는 난이도 번호를 수정하세요.
-- =================================================================
local CONFIG = {
    dungeon = 3, -- 1:일반, 2:영웅, 3:신화
    raid    = 2, -- 1:일반, 2:영웅, 3:신화
    legacy  = 2, -- 1:10인, 2:25인
}

-- =================================================================
-- [내부 데이터] 와우 시스템 ID 및 텍스트 매핑
-- =================================================================
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

local amILeader = false -- 파티장 상태 추적 변수

-- =================================================================
-- [핵심 로직] 난이도 업데이트 및 알림
-- =================================================================
local function UpdateDifficulties()
    -- 실행 차단 조건: 파티장이 아님 OR 인스턴스 내부 OR 전투 중
    -- 이 조건 중 하나라도 해당되면 CPU 연산을 즉시 중단하여 성능을 보존합니다.
    if not UnitIsGroupLeader("player") or IsInInstance() or UnitAffectingCombat("player") then 
        return 
    end

    -- 시스템 설정 변경
    SetDungeonDifficultyID(IDS.dungeon[CONFIG.dungeon] or 23)
    SetRaidDifficulties(true, IDS.raid[CONFIG.raid] or 16)
    SetRaidDifficulties(false, IDS.legacy[CONFIG.legacy] or 4)

    -- 메시지 생성
    local msg = string.format("[AutoDiff] 난이도 동기화 완료: 던전(%s), 레이드(%s), 레거시(%s)", 
        NAMES.dungeon[CONFIG.dungeon], NAMES.raid[CONFIG.raid], NAMES.legacy[CONFIG.legacy])

    -- 파티 채널 알림 (혼자일 때는 내 화면에만 출력)
    if IsInGroup(LE_PARTY_CATEGORY_HOME) then
        SendChatMessage(msg, "PARTY")
    else
        print("|cff00ff00" .. msg .. "|r")
    end
end

-- =================================================================
-- [이벤트 핸들러] 특정 상황 발생 시에만 동작
-- =================================================================
local frame = CreateFrame("Frame")
frame:RegisterEvent("PARTY_LEADER_CHANGED")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

frame:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_ENTERING_WORLD" then
        -- 로딩 직후 서버 데이터 응답을 기다리기 위한 3초 지연 실행
        C_Timer.After(3, function()
            amILeader = UnitIsGroupLeader("player")
            if amILeader then UpdateDifficulties() end
        end)
        
    elseif event == "PARTY_LEADER_CHANGED" then
        local currentlyLeader = UnitIsGroupLeader("player")
        
        -- '일반 파티원'이었다가 '파티장' 권한을 넘겨받은 순간에만 작동
        if currentlyLeader and not amILeader then
            UpdateDifficulties()
        end
        
        amILeader = currentlyLeader
    end
end)