------------------------------
-- 경매장 필터
------------------------------
function checkAuctionFilter(searchBar)
    local bar = searchBar or (AuctionHouseFrame and AuctionHouseFrame.SearchBar)
        if not bar or not bar.FilterButton then return end

    local isChecked = (hodoDB and hodoDB.useAuctionFilter) or false
        bar.FilterButton.filters[Enum.AuctionHouseFilter.CurrentExpansionOnly] = isChecked
        bar:UpdateClearFiltersButton()
end

function checkCraftFilter(filterDropdown)
    local dropdown = filterDropdown or (ProfessionsCustomerOrdersFrame and ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar.FilterDropdown)
        if not dropdown or not dropdown.filters then return end

    local isChecked = (hodoDB and hodoDB.useCraftFilter) or false
        dropdown.filters[Enum.AuctionHouseFilter.CurrentExpansionOnly] = isChecked
        dropdown:ValidateResetState()
end

function AuctionFilter()
    checkAuctionFilter()
    checkCraftFilter()
end

------------------------------
-- 이벤트
------------------------------
local initFilterFrame = CreateFrame("Frame")
initFilterFrame:RegisterEvent("CRAFTINGORDERS_SHOW_CUSTOMER")
initFilterFrame:RegisterEvent("AUCTION_HOUSE_SHOW")

initFilterFrame:SetScript("OnEvent", function(self, event)
    if event == "AUCTION_HOUSE_SHOW" then
        if not AuctionHouseFrame then return end
        if not self.auctionHouseHooked then
            AuctionHouseFrame.SearchBar:HookScript("OnShow", function()
                C_Timer.After(0, function() AuctionFilter() end) 
            end)
            self.auctionHouseHooked = true
        end
        AuctionFilter()

    elseif event == "CRAFTINGORDERS_SHOW_CUSTOMER" then
        if not ProfessionsCustomerOrdersFrame then return end
        if not self.craftOrdersHooked then
            local SearchBar = ProfessionsCustomerOrdersFrame.BrowseOrders.SearchBar
            if SearchBar and SearchBar.FilterDropdown then
                SearchBar.FilterDropdown:HookScript("OnShow", function()
                    C_Timer.After(0, function() AuctionFilter() end)
                end)
            end
            self.craftOrdersHooked = true
        end
        AuctionFilter()
    end
end)