-- 전역 변수 로컬화
local UnitName, IsInGroup, C_ChallengeMode, SendChatMessage, C_Timer = UnitName, IsInGroup, C_ChallengeMode, SendChatMessage, C_Timer
local partyMembers = {}

-- 라이브러리 로드 확인
local function GetLib()
    return LibStub and LibStub:GetLibrary("LibOpenRaid-1.0", true)
end

-- 1. UI 프레임 설정 (배경/버튼 모두 제거)
local displayFrame = CreateFrame("Frame", "KeystoneRollFrame", UIParent)
displayFrame:SetSize(500, 200)
displayFrame:SetPoint("TOP", 0, -100) -- 화면 상단 위치
displayFrame:Hide()

-- 텍스트만 생성
local text = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
text:SetPoint("TOP", 0, 0)
text:SetJustifyH("CENTER")
text:SetSpacing(5)

-- 2. 던전 이름을 가져오는 가장 확실한 로직 (BigWigs 방식)
local function GetDungeonName(mapID)
    if not mapID or mapID == 0 then return "알 수 없음" end
    
    -- C_ChallengeMode.GetMapUIInfo 가 던전 이름을 가져오는 표준 API입니다.
    local name = C_ChallengeMode.GetMapUIInfo(mapID)
    
    -- 이름이 없다면 던전 목록에서 직접 매칭 시도
    if not name or name == "" then
        local mapInfo = C_Map.GetMapInfo(mapID)
        name = mapInfo and mapInfo.name or "던전(" .. mapID .. ")"
    end
    
    return name
end

local function GetKeyLink(keystone)
    if not keystone or not keystone.level or keystone.level <= 0 then 
        return "|cff808080쐐기돌 없음|r" 
    end
    
    -- LibOpenRaid에서 제공하는 챌린지 맵 ID 사용
    local mapID = keystone.challengeMapID or keystone.mythicPlusMapID
    local name = GetDungeonName(mapID)
    
    return string.format("|cffffffff%s %d단|r", name, keystone.level)
end

-- 3. 화면 업데이트 함수
local function UpdateDisplay()
    local LibOpenRaid = GetLib()
    if not LibOpenRaid or not IsInGroup() then return end

    wipe(partyMembers)
    partyMembers[1] = "player"
    local num = GetNumGroupMembers()
    if num > 1 then
        for i = 1, num - 1 do partyMembers[i + 1] = "party" .. i end
    end

    local displayText = "|cff00ff00[ 파티원 쐐기돌 현황 ]|r\n\n"
    for _, unit in ipairs(partyMembers) do
        local info = LibOpenRaid.GetKeystoneInfo(unit)
        local uName = UnitName(unit)
        local _, class = UnitClass(unit)
        local color = (RAID_CLASS_COLORS[class] and RAID_CLASS_COLORS[class].colorStr) or "ffffffff"
        
        -- 정보가 있는 경우에만 표시
        if info then
            displayText = displayText .. string.format("|c%s%s|r: %s\n", color, uName, GetKeyLink(info))
        end
    end
    
    text:SetText(displayText)
    displayFrame:Show()
end

-- 4. 이벤트 핸들러
local f = CreateFrame("Frame")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")

f:SetScript("OnEvent", function(self, event)
    if event == "CHALLENGE_MODE_COMPLETED" then
        -- 완료 후 서버 데이터 동기화를 위해 2초 대기
        C_Timer.After(2, function()
            local _, _, _, onTime = C_ChallengeMode.GetCompletionInfo()
            
            if onTime then
                UpdateDisplay()
                
                -- 5초 뒤 외침
                C_Timer.After(5, function()
                    if IsInGroup() then
                        SendChatMessage("돌 굴리세요!", "YELL")
                    end
                    
                    -- 20초 뒤 텍스트 숨김
                    C_Timer.After(20, function()
                        displayFrame:Hide()
                    end)
                end)
            end
        end)
    end
end)