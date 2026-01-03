-- 전역 변수 로컬화 (성능 향상)
local UnitName = UnitName
local IsInGroup = IsInGroup
local C_ChallengeMode = C_ChallengeMode
local SendChatMessage = SendChatMessage
local C_Timer = C_Timer

-- 쐐기돌 현황용 임시 테이블 (매번 생성하지 않고 재사용)
local partyMembers = {}

-- 라이브러리 로드 확인
local function GetLib()
    return LibStub and LibStub:GetLibrary("LibOpenRaid-1.0", true)
end

-- 1. UI 프레임 설정
local displayFrame = CreateFrame("Frame", "KeystoneRollFrame", UIParent)
displayFrame:SetSize(500, 200)
displayFrame:SetPoint("TOP", 0, -100)
displayFrame:Hide()

local text = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
text:SetPoint("TOP", 0, 0)
text:SetJustifyH("CENTER")
text:SetSpacing(5)

-- 쐐기돌 정보 텍스트 변환
local function GetKeyLink(keystone)
    if not keystone or not keystone.level or keystone.level <= 0 then 
        return "|cff808080쐐기돌 없음|r" 
    end
    
    local mapID = keystone.mythicPlusMapID or keystone.challengeMapID
    local mapName = C_ChallengeMode.GetMapUIInfo(mapID)
    
    -- 이름 획득 실패 시 대비
    mapName = (mapName and mapName ~= "") and mapName or ("알 수 없는 던전("..mapID..")")
    
    return string.format("|cffffffff%s %d단|r", mapName, keystone.level)
end

-- 2. 화면 업데이트 함수
local function UpdateDisplay()
    local LibOpenRaid = GetLib()
    if not LibOpenRaid or not IsInGroup() then return end

    -- 테이블 초기화 및 구성
    wipe(partyMembers)
    partyMembers[1] = "player"
    local numMembers = GetNumGroupMembers()
    if numMembers > 1 then
        for i = 1, numMembers - 1 do
            partyMembers[i + 1] = "party" .. i
        end
    end

    local displayText = "|cff00ff00[ 파티원 쐐기돌 현황 ]|r\n"
    for _, unit in ipairs(partyMembers) do
        local info = LibOpenRaid.GetKeystoneInfo(unit)
        local name = UnitName(unit)
        local _, class = UnitClass(unit)
        local color = (RAID_CLASS_COLORS[class] and RAID_CLASS_COLORS[class].colorStr) or "ffffffff"
        
        displayText = displayText .. string.format("|c%s%s|r: %s\n", color, name, GetKeyLink(info))
    end
    
    text:SetText(displayText)
    displayFrame:Show()
end

-- 3. 이벤트 핸들러
local f = CreateFrame("Frame")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        if not GetLib() then
            print("|cffff0000[KeystoneRoll]|r Details! 또는 LibOpenRaid가 필요합니다.")
        else
            print("|cff00ff00[KeystoneRoll]|r 애드온 로드 완료.")
        end

    elseif event == "CHALLENGE_MODE_COMPLETED" then
        -- 서버 데이터 갱신을 위해 1.5초 지연
        C_Timer.After(1.5, function()
            local _, _, _, onTime = C_ChallengeMode.GetCompletionInfo()
            
            -- onTime이 nil일 경우 false로 처리
            if onTime then
                UpdateDisplay()
                
                -- 5초 뒤 외침
                C_Timer.After(5, function()
                    if IsInGroup() then -- 외침 전 파티 여부 재확인
                        SendChatMessage("돌 굴리세요!", "YELL")
                    end
                    
                    -- 15초 뒤 숨기기
                    C_Timer.After(15, function()
                        displayFrame:Hide()
                    end)
                end)
            end
        end)
    end
end)