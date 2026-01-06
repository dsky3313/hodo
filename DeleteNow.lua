------------------------------
-- 테이블
------------------------------
-- 아이템 링크
local DeleteNowItemLink = StaticPopup1:CreateFontString(nil, "OVERLAY", "GameFontNormalMed1")
    DeleteNowItemLink:SetPoint("CENTER", StaticPopup1, "CENTER", 0, 0)

-- 자동기입
local function WriteDeleteNow()
    local rawText = gsub(DELETE_GOOD_ITEM, "[\r\n]", "")
    local _, DeleteNowText = strsplit('"', rawText)
    return DeleteNowText or "삭제"
end

-- 안내 문구 제거
local TypeDeleteLine = gsub(DELETE_GOOD_ITEM, "[\r\n]", "@")
local _, DeleteNowLocalizeDeleteText = strsplit("@", TypeDeleteLine, 2)
DeleteNowLocalizeDeleteText = gsub(DeleteNowLocalizeDeleteText or "", "%%s", "")
DeleteNowLocalizeDeleteText = gsub(DeleteNowLocalizeDeleteText, "@", "")


------------------------------
-- 지금삭제
------------------------------
local function DeleteNow()
    if not hodoDB then
        return
    end

    if not StaticPopup1 or not StaticPopup1EditBox then
        return
    end

    local infoType, itemID, itemLink = GetCursorInfo()
        SetCVar("alwaysCompareItems", 0)

    if itemLink then
        itemLink:SetText("")
    end

    if hodoDB.DeleteNowEditbox then -- 자동입력
        StaticPopup1EditBox:Show()
        StaticPopup1EditBox:SetText(WriteDeleteNow())
        StaticPopup1EditBox:SetFocus()
        StaticPopup1Button1:Enable()
    else
        StaticPopup1EditBox:Hide() -- Editbox 숨김
        StaticPopup1Button1:Enable()

        if itemLink and itemLink then
            itemLink:SetText(itemLink)
        end

        local currentText = StaticPopup1Text:GetText() or ""
        if DeleteNowLocalizeDeleteText ~= "" then
            currentText = gsub(currentText, DeleteNowLocalizeDeleteText, "")
        end
        StaticPopup1Text:SetText(currentText)
    end

    if itemLink then
        GameTooltip:SetOwner(StaticPopup1, "ANCHOR_NONE")
        GameTooltip:SetPoint("TOP", StaticPopup1, "BOTTOM", 0, 5)
        GameTooltip:SetHyperlink(itemLink)
        GameTooltip:Show()
    end
end


------------------------------
-- 이벤트
------------------------------
local initDeleteNow = CreateFrame("Frame")
initDeleteNow:RegisterEvent("DELETE_ITEM_CONFIRM")
initDeleteNow:SetScript("OnEvent", function()
    C_Timer.After(0.1, DeleteNow)
end)

hooksecurefunc("StaticPopup_OnHide", function()
    if GameTooltip then
        GameTooltip:Hide()
    end

    if DeleteNowItemLink then
        DeleteNowItemLink:SetText("")
        DeleteNowItemLink:Hide()
    end
    SetCVar("alwaysCompareItems", 1)
end)