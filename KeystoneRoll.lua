-- 라이브러리 로드 확인 함수
local function GetLib()
    if not LibStub then return nil end
    return LibStub:GetLibrary("LibOpenRaid-1.0", true)
end

-- 1. 화면 상단 프레임 설정
local displayFrame = CreateFrame("Frame", "DungeonKeyDisplayFrame", UIParent)
displayFrame:SetSize(500, 200)
displayFrame:SetPoint("TOP", 0, -100)
displayFrame:Hide()

local text = displayFrame:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
text:SetPoint("TOP", 0, 0)
text:SetJustifyH("CENTER")
text:SetSpacing(5)

-- 쐐기돌 정보를 텍스트로 변환하는 함수
local function GetKeyLink(keystone)
    if not keystone or (not keystone.level or keystone.level <= 0) then return "|cff808080없음|r" end
    local mapID = keystone.mythicPlusMapID or keystone.challengeMapID
    local mapName = C_ChallengeMode.GetMapUIInfo(mapID) or "알 수 없음"
    return string.format("|cffffffff%s %d단|r", mapName, keystone.level)
end

-- 2. 화면에 쐐기돌 현황 업데이트 함수
local function UpdateDisplay()
    local LibOpenRaid = GetLib()
    if not LibOpenRaid then 
        print("|cffff0000[KeystoneRoll]|r 라이브러리를 찾을 수 없어 현황을 표시할 수 없습니다.")
        return 
    end
    if not IsInGroup() then return end

    local displayText = "|cff00ff00[ 파티원 쐐기돌 현황 ]|r\n"
    local partyMembers = {"player"}
    for i = 1, GetNumGroupMembers() - 1 do table.insert(partyMembers, "party" .. i) end

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

-- 3. 이벤트 처리
local f = CreateFrame("Frame")
f:RegisterEvent("CHALLENGE_MODE_COMPLETED")
f:RegisterEvent("PLAYER_LOGIN")

f:SetScript("OnEvent", function(self, event)
    if event == "PLAYER_LOGIN" then
        if not GetLib() then
            print("|cffff0000[KeystoneRoll]|r Details! 또는 LibOpenRaid가 필요합니다.")
        else
            print("|cff00ff00[KeystoneRoll]|r 애드온이 로드되었습니다. 쐐기 시한 완료 시 작동합니다.")
        end

    elseif event == "CHALLENGE_MODE_COMPLETED" then
        -- 던전 완료 후 서버 데이터가 갱신될 때까지 1초 대기 후 체크
        C_Timer.After(1, function()
            local _, _, _, onTime = C_ChallengeMode.GetCompletionInfo()
            
            -- 테스트용: 시한 완료가 아니더라도 이벤트 발생 확인을 위해 print 추가 (나중에 삭제 가능)
            if not onTime then
                print("|cffff0000[KeystoneRoll]|r 던전이 소진되었습니다. 리롤이 불가능합니다.")
                return 
            end

            -- 시한 내 완료 시 실행
            UpdateDisplay()
            
            C_Timer.After(5, function()
                SendChatMessage("돌 굴리세요!", "YELL")
                C_Timer.After(10, function()
                    displayFrame:Hide()
                end)
            end)
        end)
    end
end)