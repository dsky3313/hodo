------------------------------
-- 슬라이더
------------------------------

------------------------------
-- 백분율 표시 함수
------------------------------
local function PercentFormat(v)
    return ("%d%%"):format(math.floor((v or 0) * 100 + 0.5))
end

-- 설정 카테고리에 슬라이더를 추가하는 공통 함수
function Hodo_AddScaleSlider(category, varName, label, tooltip, default)
    
    -- 1. 데이터 연동 설정 (Proxy)
    local setting = Settings.RegisterProxySetting(category, "HODO_"..varName, Settings.VarType.Number, 
        label, default,
        -- [Getter] 데이터 가져오기
        function() 
            return (hodoDB and hodoDB[varName]) or default 
        end,
        -- [Setter] 데이터 저장 및 실행
        function(v) 
            -- 안전 장치: hodoDB가 없으면 생성
            if not hodoDB then hodoDB = {} end
            
            hodoDB[varName] = v
            
            -- FrameScale.lua에 정의된 적용 함수 호출
            if Hodo_ApplyAllScales then
                Hodo_ApplyAllScales() 
            end
            
            -- [최적화] 설정 변경을 시스템에 알리고 즉시 저장 대기
            Settings.Save()
        end)

    -- 2. 슬라이더 UI 옵션 설정
    local sliderOpts = Settings.CreateSliderOptions(0.5, 1.0, 0.05)
    sliderOpts:SetLabelFormatter(MinimalSliderWithSteppersMixin.Label.Right, PercentFormat)
    
    -- 3. 최종 생성
    Settings.CreateSlider(category, setting, sliderOpts, tooltip)
end