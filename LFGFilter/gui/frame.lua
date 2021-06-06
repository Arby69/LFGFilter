LFGFilter_AddonTitle = LFGFilter.AddonTitle
LFGFilter_Announcements = LFGFilter.Locale["Announcements"]
LFGFilter_ShowSuppressed = LFGFilter.Locale["Show suppressed"]
LFGFilter_Configuration = LFGFilter.Locale["Configuration"]
LFGFilter_SelectDungeons = LFGFilter.Locale["Select Dungeons"]
LFGFilter_Options = LFGFilter.Locale["Options"]
LFGFilter_Dungeons = LFGFilter.Locale["Dungeons"]
LFGFilter_About = LFGFilter.Locale["About"]

function LFGFilterCheckButton_OnLoad(self)
	print(self:GetName())
	local test = self:GetParent():GetText()
	self:SetText(text)
end

function LFGFilterFrame_OnLoad()
	LFGFilterFrame:RegisterForDrag("LeftButton")
	LFGFilterFrame.elapsed = 0
	-- center Checkbox in title bar 
	local textwidth = LFGFilterFrameShowHiddenText:GetStringWidth()
	local offset = (250 - textwidth - 16) / 2
	LFGFilterFrameShowHidden:SetPoint("TOPLEFT", 79 + offset, -58)
	--
	LFGFilter_SidebarWindowFrame_Construct(LFGFilterConfigFrame)

	PanelTemplates_SetNumTabs(LFGFilterConfigFrame, #LFGFilter.PanelFrames)
	LFGFilterConfigFrame.selectedTab = LFGFilter.CurrentPanel
	PanelTemplates_UpdateTabs(LFGFilterConfigFrame)
end

function LFGFilterFrame_OnDragStart()
	LFGFilterFrame:StartMoving()
	LFGFilterFrame.isMoving = true
end

function LFGFilterFrame_OnDragStop()
	LFGFilterFrame:StopMovingOrSizing()
	LFGFilterFrame:SetUserPlaced(false)
	LFGFilterFrame.isMoving = false
end

function LFGFilterFrame_OnShow()
	LFGFilterFrame.SetFrameLevel(LFGFilterConfigFrame, LFGFilterFrame:GetFrameLevel() - 1)
	LFGFilter:ShowPanel(1) -- Always switch to the main view when showing the window
	PlaySound(SOUNDKIT.IG_QUEST_LOG_OPEN)
end


function LFGFilterFrame_OnHide()
	PlaySound(SOUNDKIT.IG_QUEST_LOG_CLOSE)
end

function LFGFilterFrame_ToggleConfigButton()
	if LFGFilterConfigFrame:IsVisible() then
		LFGFilterConfigFrame:Hide()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
	else
		LFGFilterConfigFrame:Show()
		PlaySound(SOUNDKIT.IG_MAINMENU_OPEN)
	end
end

LFGFilter.CurrentPanel = 0
LFGFilter.PanelFrames =	{
	"LFGFilterDungeonsFrame",
	"LFGFilterOptionsFrame",
	"LFGFilterAboutFrame",
}

function LFGFilter:ShowPanel(pPanelIndex)
	--self:CancelDialogs() -- Force any dialogs to close if they're open
	
	if self.CurrentPanel > 0 and self.CurrentPanel ~= pPanelIndex then
		self:HidePanel(self.CurrentPanel)
	end
	
	-- NOTE: Don't check for redundant calls since this function
	-- will be called to reset the field values as well as to 
	-- actually show the panel when it's hidden
	
	self.CurrentPanel = pPanelIndex
	
	local vPanelFrame = _G[self.PanelFrames[pPanelIndex]]
	vPanelFrame:Show()

	PanelTemplates_SetTab(LFGFilterConfigFrame, pPanelIndex)
	
	-- Update the control values
	
	if pPanelIndex == 1 then
		-- Main panel
		
	elseif pPanelIndex == 2 then
		-- Options panel
		
	elseif pPanelIndex == 3 then
		-- About panel
		
		if not self.AboutView then
			self.AboutView = self:New(self._AboutView)
		end
	else
		self:ErrorMessage("Unknown index (%d) in ShowPanel()", pPanelIndex)
	end
	
	self:Update(false)
end

function LFGFilter:HidePanel(pPanelIndex)
	if self.CurrentPanel ~= pPanelIndex then
		return
	end
	
	_G[self.PanelFrames[pPanelIndex]]:Hide()
	self.CurrentPanel = 0
end

function LFGFilter:Update() --pOutfitsChanged)
	--	-- Flush the caches
	
	--	--if pOutfitsChanged then
	--	--	wipe(self.OutfitInfoCache)
	--	--end
	
	--	-- Just leave if we're not visible (when does this happen?)
	
	--	if not LFGFilterOptionsFrame:IsVisible() then
	--		return
	--	end
	
	--	--
	
	--	if self.CurrentPanel == 1 then
	--		-- Main panel

	--		if not self.DisplayIsDirty then
	--			return
	--		end

	--		self.DisplayIsDirty = false

	--		-- Sort the outfits

	--		self:SortOutfits()

	--		-- Get the equippable items so outfits can be marked if they're missing anything

	--		local vInventoryCache = self:GetInventoryCache()

	--		-- Update the slot enables if they're shown

	--		if pOutfitsChanged
	--		and OutfitterSlotEnables:IsVisible() then
	--			self:UpdateSlotEnables(self.SelectedOutfit, vInventoryCache)
	--		end

	--		vInventoryCache:CompiledUnusedItemsList()

	--		-- Update the list

	--		OutfitterMainFrameHighlight:Hide()

	--		local vFirstItemIndex = FauxScrollFrame_GetOffset(OutfitterMainFrameScrollFrame)
	--		local vItemIndex = 0

	--		vInventoryCache:ResetIgnoreItemFlags()

	--		for vCategoryIndex, vCategoryID in ipairs(self.cCategoryOrder) do
	--			vItemIndex, vFirstItemIndex = self:AddOutfitsToList(self.Settings.Outfits, vCategoryID, vItemIndex, vFirstItemIndex, vInventoryCache)

	--			if vItemIndex >= self.cMaxDisplayedItems then
	--				break
	--			end
	--		end

	--		if vItemIndex < self.cMaxDisplayedItems
	--		and vInventoryCache.UnusedItems then
	--			vItemIndex, vFirstItemIndex = self:AddOutfitItemsToList(vInventoryCache.UnusedItems, "OddsNEnds", vItemIndex, vFirstItemIndex)
	--		end

	--		-- Add the BoEs
	--		local vBoEItems = vInventoryCache:GetBoEItems()
	--		if vItemIndex < self.cMaxDisplayedItems
	--		and vBoEItems and #vBoEItems > 0 then
	--			vItemIndex, vFirstItemIndex = self:AddOutfitItemsToList(vBoEItems, "BoEs", vItemIndex, vFirstItemIndex)
	--		end

	--		-- Hide any unused items
	--		for vItemIndex2 = vItemIndex, (self.cMaxDisplayedItems - 1) do
	--			local vItemName = "OutfitterItem"..vItemIndex2
	--			local vItem = _G[vItemName]

	--			vItem:Hide()
	--		end

	--		-- Count the total items
	--		local vTotalNumItems = 0

	--		-- Add in the main categories
	--		for vCategoryIndex, vCategoryID in ipairs(self.cCategoryOrder) do
	--			vTotalNumItems = vTotalNumItems + 1

	--			local vOutfits = self.Settings.Outfits[vCategoryID]

	--			if not self.Collapsed[vCategoryID]
	--			and vOutfits then
	--				vTotalNumItems = vTotalNumItems + #vOutfits
	--			end
	--		end

	--		-- Add in the Odd 'n Ends category
	--		if vInventoryCache.UnusedItems then
	--			vTotalNumItems = vTotalNumItems + 1
	--			if not self.Collapsed["OddsNEnds"] then
	--				vTotalNumItems = vTotalNumItems + #vInventoryCache.UnusedItems
	--			end
	--		end

	--		-- Add in the BoEs category
	--		if vBoEItems and #vBoEItems then
	--			vTotalNumItems = vTotalNumItems + 1
	--			if not self.Collapsed["BoEs"] then
	--				vTotalNumItems = vTotalNumItems + #vBoEItems
	--			end
	--		end

	--		FauxScrollFrame_Update(
	--				OutfitterMainFrameScrollFrame,
	--				vTotalNumItems,                 -- numItems
	--				self.cMaxDisplayedItems,        -- numToDisplay
	--				18,                             -- valueStep
	--				nil, nil, nil,                  -- button, smallWidth, bigWidth
	--				nil,                            -- highlightFrame
	--				0, 0)                           -- smallHighlightWidth, bigHighlightWidth
	--	elseif self.CurrentPanel == 2 then -- Options panel
	--		OutfitterAutoSwitch:SetChecked(self.Settings.Options.DisableAutoSwitch)
	--		OutfitterShowMinimapButton:SetChecked(not self.Settings.Options.HideMinimapButton)
	--		OutfitterTooltipInfo:SetChecked(not self.Settings.Options.DisableToolTipInfo)
	--		OutfitterShowHotkeyMessages:SetChecked(not self.Settings.Options.DisableHotkeyMessages)
	--		OutfitterShowOutfitBar:SetChecked(self.Settings.OutfitBar.ShowOutfitBar)
	--		OutfitterItemComparisons:SetChecked(not self.Settings.Options.DisableItemComparisons)
	--	end
end

--LFGFilter._SidebarWindowFrame = {}
----------------------------------------

function LFGFilter_SidebarWindowFrame_Construct(self)
	-- Create the textures
	
	self.TopHeight = 80
	self.LeftWidth = 80
	self.BottomHeight = 183
	self.RightWidth = 94
	
	self.TopMargin = 13
	self.LeftMargin = 0
	self.BottomMargin = 3
	self.RightMargin = 1
	
	self.TextureWidth1 = 256
	self.TextureWidth2 = 128
	self.TextureUsedWidth2 = 94
	
	self.TextureHeight1 = 256
	self.TextureHeight2 = 256
	self.TextureUsedHeight2 = 183
	
	self.MiddleWidth1 = self.TextureWidth1 - self.LeftWidth
	self.MiddleWidth2 = 60
	
	self.TexCoordX1 = self.LeftWidth / self.TextureWidth1
	self.TexCoordX2 = (self.TextureUsedWidth2 - self.RightWidth) / self.TextureWidth2
	self.TexCoordX3 = self.TextureUsedWidth2 / self.TextureWidth2
	
	self.TexCoordY1 = self.TopHeight / self.TextureHeight1
	self.TexCoordY2 = (self.TextureUsedHeight2 - self.BottomHeight) / self.TextureHeight2
	self.TexCoordY3 = self.TextureUsedHeight2 / self.TextureHeight2
	
	self.Background = {}
	
	self.Background.TopRight = self:CreateTexture(nil, "BORDER")
	self.Background.TopRight:SetWidth(self.RightWidth)
	self.Background.TopRight:SetHeight(self.TopHeight)
	self.Background.TopRight:SetPoint("TOPRIGHT", self, "TOPRIGHT", self.RightMargin, self.TopMargin)
	self.Background.TopRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
	self.Background.TopRight:SetTexCoord(self.TexCoordX2, self.TexCoordX3, 0, self.TexCoordY1)
	
	self.Background.TopLeft = self:CreateTexture(nil, "BORDER")
	self.Background.TopLeft:SetHeight(self.TopHeight)
	self.Background.TopLeft:SetPoint("TOPLEFT", self, "TOPLEFT", -self.LeftMargin, self.TopMargin)
	self.Background.TopLeft:SetPoint("TOPRIGHT", self.Background.TopRight, "TOPLEFT")
	self.Background.TopLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.TopLeft:SetTexCoord(self.TexCoordX1, 1, 0, self.TexCoordY1)
	
	self.Background.BottomRight = self:CreateTexture(nil, "BORDER")
	self.Background.BottomRight:SetWidth(self.RightWidth)
	self.Background.BottomRight:SetHeight(self.BottomHeight)
	self.Background.BottomRight:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", self.RightMargin, -self.BottomMargin)
	self.Background.BottomRight:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomRight")
	self.Background.BottomRight:SetTexCoord(self.TexCoordX2, self.TexCoordX3, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.BottomLeft = self:CreateTexture(nil, "BORDER")
	self.Background.BottomLeft:SetHeight(self.BottomHeight)
	self.Background.BottomLeft:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT", -self.LeftMargin, -self.BottomMargin)
	self.Background.BottomLeft:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "BOTTOMLEFT")
	self.Background.BottomLeft:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-BottomLeft")
	self.Background.BottomLeft:SetTexCoord(self.TexCoordX1, 1, self.TexCoordY2, self.TexCoordY3)
	
	self.Background.RightMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.RightMiddle:SetWidth(self.RightWidth)
	self.Background.RightMiddle:SetPoint("TOPRIGHT", self.Background.TopRight, "BOTTOMRIGHT")
	self.Background.RightMiddle:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "TOPRIGHT")
	self.Background.RightMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopRight")
	self.Background.RightMiddle:SetTexCoord(self.TexCoordX2, self.TexCoordX3, self.TexCoordY1, 1)
	
	self.Background.LeftMiddle = self:CreateTexture(nil, "BORDER")
	self.Background.LeftMiddle:SetPoint("TOPLEFT", self.Background.TopLeft, "BOTTOMLEFT")
	self.Background.LeftMiddle:SetPoint("BOTTOMLEFT", self.Background.BottomLeft, "TOPLEFT")
	self.Background.LeftMiddle:SetPoint("TOPRIGHT", self.Background.TopRight, "BOTTOMLEFT")
	self.Background.LeftMiddle:SetPoint("BOTTOMRIGHT", self.Background.BottomRight, "TOPLEFT")
	self.Background.LeftMiddle:SetTexture("Interface\\PaperDollInfoFrame\\UI-Character-General-TopLeft")
	self.Background.LeftMiddle:SetTexCoord(self.TexCoordX1, 1, self.TexCoordY1, 1)
	
	self.Background.ShadowFrame = CreateFrame("Frame", nil, self)
	self.Background.ShadowFrame:SetWidth(16)
	self.Background.ShadowFrame:SetPoint("TOPLEFT", self, "TOPLEFT")
	self.Background.ShadowFrame:SetPoint("BOTTOMLEFT", self, "BOTTOMLEFT")
	self.Background.ShadowFrame:SetFrameLevel(self:GetFrameLevel() + 20)
	
	self.Background.Shadow = self.Background.ShadowFrame:CreateTexture(nil, "OVERLAY")
	self.Background.Shadow:SetAllPoints()
	self.Background.Shadow:SetTexture(0, 0, 0, 1)
	self.Background.Shadow:SetGradientAlpha(
		"HORIZONTAL",
		1, 1, 1, 1,
		1, 1, 1, 0)
end
