------------------------------
-- 프레임 스케일
------------------------------
function FrameScale()
    if not hodoDB then
        return
    end

    if hodoDB.GameMenuFrameScale and GameMenuFrame then -- 게임 메뉴 (ESC)
        GameMenuFrame:SetScale(hodoDB.GameMenuFrameScale)
    end

    if hodoDB.TalkingHeadFrameScale and TalkingHeadFrame then -- 말머리 (TalkingHead)
        TalkingHeadFrame:SetScale(hodoDB.TalkingHeadFrameScale)
    end

    if hodoDB.BackpackButtonScale and MainMenuBarBackpackButton then -- 가방 버튼
        MainMenuBarBackpackButton:SetScale(hodoDB.BackpackButtonScale)
    end
end

------------------------------
-- 이벤트
------------------------------
local initFrameScale = CreateFrame("Frame")
initFrameScale:RegisterEvent("PLAYER_LOGIN")
initFrameScale:SetScript("OnEvent", function(self, event)
    hodoDB = hodoDB or {}
    if FrameScale then
        FrameScale()
    end

    if hodoCreateOptions then
        hodoCreateOptions()
    end

    self:UnregisterAllEvents()
end)