------------------------------
-- 말풍선
------------------------------
FontOption = {
    { label = "2002", value = "Fonts\\2002.TTF" },
    { label = "2002b", value = "Fonts\\2002b.TTF" },
    { label = "ARIALN", value = "Fonts\\ARIALN.TTF" },
    { label = "FRIZQT__", value = "Fonts\\FRIZQT__.TTF" },
    { label = "K_DAMAGE", value = "Fonts\\K_DAMAGE.TTF" },
    { label = "K_PAGETEXT", value = "Fonts\\K_PAGETEXT.TTF" },
}

function ChatBubble()
    if not hodoDB then 
        return
    end
    
    local ChatBubbleFontPath = hodoDB.ChatBubbleFontPath or "Fonts\\2002.TTF"
    local ChatBubbleFontSize = hodoDB.ChatBubbleFontSize or 10

    -- 실제 말풍선 폰트 적용 로직
    if ChatBubbleFont then
        ChatBubbleFont:SetFont(ChatBubbleFontPath, ChatBubbleFontSize, "OUTLINE")
    end
end

-- ChatBubbleFontGeneral


------------------------------
-- 이벤트
------------------------------
local initChatBubble = CreateFrame("Frame")
initChatBubble:RegisterEvent("PLAYER_LOGIN")
initChatBubble:SetScript("OnEvent", function(self, event)
    hodoDB = hodoDB or {}
    if ChatBubble then
        ChatBubble()
    end

    if hodoCreateOptions then
        hodoCreateOptions()
    end

    self:UnregisterAllEvents()
end)