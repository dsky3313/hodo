local addonName, addonTable = ...
local frame = CreateFrame("Frame")

-- 설정 값
local showFor = 3
local leaderOnly = true
local onlyMPlus = false

-- 상태 변수
local lastApps = 0
local armedAt = 0
local lastTrig = 0

-- 쐐기돌 판별 함수
local function IsMythicPlusListing()
    local entry = C_LFGList.GetActiveEntryInfo()
    if not entry then return false end
    local actID = entry.activityID
    if actID then
        local t = C_LFGList.GetActivityInfoTable(actID)
        if t then
            if t.isMythicPlusActivity ~= nil then return t.isMythicPlusActivity end
            if Enum and Enum.LFGListDisplayType and t.displayType == Enum.LFGListDisplayType.MythicPlus then return true end
        end
    end
    local title = (entry.name or ""):lower()
    return title:find("%+") or title:find("m%+") or title:find("쐐기") or false
end

-- 알림 출력 함수
local function ShowAlert()
    -- 화면 중앙에 큰 글씨로 알림 (Raid Warning 스타일)
    RaidNotice_AddMessage(RaidWarningFrame, "|cff00ff00[신규 신청]|r 파티 확인", ChatTypeInfo["RAID_WARNING"])
    -- 소리 재생
    PlaySound(9379, "Master") -- 신청자 알림 소리
end

frame:SetScript("OnEvent", function(self, event, ...)
    -- 파장 체크
    if leaderOnly then
        if IsInGroup() and not UnitIsGroupLeader("player") then
            lastApps = 0
            return
        end
    end

    -- 내가 올린 모집글 확인
    if not (C_LFGList and C_LFGList.HasActiveEntryInfo and C_LFGList.HasActiveEntryInfo()) then
        lastApps = 0
        return
    end

    -- 쐐기 전용 체크
    if onlyMPlus and not IsMythicPlusListing() then
        return
    end

    -- 등록 직후 무시
    if GetTime() < armedAt then
        local a = C_LFGList.GetApplicants()
        lastApps = (a and #a) or 0
        return
    end

    -- 리셋 이벤트
    if event == "LFG_LIST_ACTIVE_ENTRY_UPDATE" or event == "PLAYER_ENTERING_WORLD" then
        local a = C_LFGList.GetApplicants()
        lastApps = (a and #a) or 0
        armedAt = GetTime() + 1
        return
    end

    -- 신청자 수 비교
    local apps = C_LFGList.GetApplicants()
    local count = (apps and #apps) or 0
    
    if count > lastApps then
        local now = GetTime()
        if (now - lastTrig) > 0.5 then -- 0.5초 내부 쿨타임
            ShowAlert()
            lastTrig = now
        end
    end
    
    lastApps = count
end)

frame:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED")
frame:RegisterEvent("LFG_LIST_APPLICANT_UPDATED")
frame:RegisterEvent("LFG_LIST_ACTIVE_ENTRY_UPDATE")
frame:RegisterEvent("PLAYER_ENTERING_WORLD")

-- 초기화
armedAt = GetTime() + 2