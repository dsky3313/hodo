local addonName, addonTable = ...

-- ### 설정 영역 (원하는 대로 수정하세요) ###
local config = {
    forCraftOrdersOverwrite = true,    -- 제작 주문 필터 강제 적용 여부
    forCraftOrdersValue = true,       -- true: 현재 확장팩만 보기 체크, false: 체크 해제

    forAuctionHouseOverwrite = true,   -- 경매장 필터 강제 적용 여부
    forAuctionHouseValue = true,      -- true: 현재 확장팩만 보기 체크, false: 체크 해제
}

local function OverwriteCraftOrdersFilter(filterDropdown)
    if config.forCraftOrdersOverwrite then
        filterDropdown.filters[Enum.AuctionHouseFilter.CurrentExpansionOnly] = config.forCraftOrdersValue
        filterDropdown:ValidateResetState()
    end
end

local function OverwriteAuctionHouseFilter(searchBar)
    if config.forAuctionHouseOverwrite then
        searchBar.FilterButton.filters[Enum.AuctionHouseFilter.CurrentExpansionOnly] = config.forAuctionHouseValue
        searchBar:UpdateClearFiltersButton()
    end
end

local frame = CreateFrame("Frame")
frame:RegisterEvent("CRAFTINGORDERS_SHOW_CUSTOMER")
frame:RegisterEvent("AUCTION_HOUSE_SHOW")

frame:SetScript("OnEvent", function(self, event)
    if event == "CRAFTINGORDERS_SHOW_CUSTOMER" then
        local filterDropdownFrame = ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar.FilterDropdown
        
        -- Hook은 한 번만 등록
        if not self.craftOrdersHooked then
            filterDropdownFrame:HookScript("OnShow", function(f)
                C_Timer.After(0, function() OverwriteCraftOrdersFilter(f) end)
            end)
            self.craftOrdersHooked = true
        end
        OverwriteCraftOrdersFilter(filterDropdownFrame)

    elseif event == "AUCTION_HOUSE_SHOW" then
        local searchBarFrame = AuctionHouseFrame.SearchBar

        if not self.auctionHouseHooked then
            searchBarFrame:HookScript("OnShow", function(f)
                C_Timer.After(0, function() OverwriteAuctionHouseFilter(f) end)
            end)
            self.auctionHouseHooked = true
        end
        OverwriteAuctionHouseFilter(searchBarFrame)
    end
end)