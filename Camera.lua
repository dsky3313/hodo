------------------------------
-- 카메라
------------------------------
function Camera()
    if not hodoDB then
        return
    end

    local DefaultDynamicCameraBase = hodoDB.DynamicCameraBase or 0.55
    local DefaultDynamicCameraBaseDown = hodoDB.DynamicCameraDown or 0.55
    local DefaultDynamicCameraBaseFlying = hodoDB.DynamicCameraFlying or 0.55

    if hodoDB.useDynamicCameraBase then
        SetCVar("test_cameraDynamicPitch", 1)
        SetCVar("CameraKeepCharacterCentered", 0)
        SetCVar("test_cameraDynamicPitchBaseFovPad", DefaultDynamicCameraBase)
    else
        SetCVar("test_cameraDynamicPitch", 0) -- 껐다켰다 기능이라 else값 넣어줘야함
        SetCVar("CameraKeepCharacterCentered", 1)
    end

    if hodoDB.useDynamicCameraDown then
        SetCVar("test_cameraDynamicPitchBaseFovPadDownScale", DefaultDynamicCameraBaseDown)
    else
        SetCVar("test_cameraDynamicPitchBaseFovPadDownScale", 0)
    end

    if hodoDB.useDynamicCameraFlying then
        SetCVar("test_cameraDynamicPitchBaseFovPadFlying", DefaultDynamicCameraBaseFlying)
    else
        SetCVar("test_cameraDynamicPitchBaseFovPadFlying", 0)
    end
end


------------------------------
-- 이벤트
------------------------------
local initCamera = CreateFrame("Frame")
initCamera:RegisterEvent("PLAYER_LOGIN")
initCamera:SetScript("OnEvent", function(self, event)
    UIParent:UnregisterEvent("EXPERIMENTAL_CVAR_CONFIRMATION_NEEDED")
    hodoDB = hodoDB or {}
    if Camera then
        Camera()
    end

    if hodoCreateOptions then
        hodoCreateOptions()
    end

    self:UnregisterAllEvents()
end)