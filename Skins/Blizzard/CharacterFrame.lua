if not Tukui then return end
local AS = unpack(AddOnSkins)

local name = 'Blizzard_CharacterFrame'
function AS:Blizzard_CharacterFrame()
	AS:SkinCloseButton(CharacterFrameCloseButton)
	AS:SkinFrame(CharacterFrame)
	AS:SkinFrame(CharacterModelFrame)
	CharacterFramePortrait:Kill()

	local CharacterSlots = {
		CharacterHeadSlot,
		CharacterNeckSlot,
		CharacterShoulderSlot,
		CharacterBackSlot,
		CharacterChestSlot,
		CharacterShirtSlot,
		CharacterTabardSlot,
		CharacterWristSlot,
		CharacterHandsSlot,
		CharacterWaistSlot,
		CharacterLegsSlot,
		CharacterFeetSlot,
		CharacterFinger0Slot,
		CharacterFinger1Slot,
		CharacterTrinket0Slot,
		CharacterTrinket1Slot,
		CharacterMainHandSlot,
		CharacterSecondaryHandSlot,
	}
	
	for _, Slot in pairs(CharacterSlots) do
		_G[Slot:GetName()..'Frame']:Kill()
		AS:SkinTexture(Slot.icon)
		AS:SkinFrame(Slot)
		Slot.icon:SetInside()
		Slot.IconBorder:SetTexture(nil)
		hooksecurefunc(Slot.IconBorder, 'SetVertexColor', function(self, r, g, b, a)
			self:GetParent():SetBackdropBorderColor(r, g, b)
		end)
		hooksecurefunc(Slot.IconBorder, 'Hide', function(self)
			self:GetParent():SetBackdropBorderColor(unpack(AS.BorderColor))
		end)
		Slot:StyleButton(false)
	end

	CharacterFrameInset:StripTextures()
	CharacterFrameInsetRight:StripTextures()
	CharacterStatsPane:StripTextures()

	CharacterFrameExpandButton:Size(CharacterFrameExpandButton:GetWidth() - 5, CharacterFrameExpandButton:GetHeight() - 5)
	AS:SkinNextPrevButton(CharacterFrameExpandButton)
	CharacterFrameExpandButton:SetPoint('BOTTOMRIGHT', CharacterFrameInset, 'BOTTOMRIGHT', -4, 4)

	EquipmentFlyoutFrameHighlight:Kill()

	local function SkinItemFlyouts()
		EquipmentFlyoutFrame.buttonFrame:StripTextures()
		for i = 1, #EquipmentFlyoutFrame.buttons do
			local button = _G["EquipmentFlyoutFrameButton"..i]
			if not button.isStyled then
				button:SetTemplate()
				button:StyleButton(false)
				button.IconBorder:SetTexture(nil)
				button:HookScript('OnUpdate', function(self)
					if button.IconBorder:IsShown() then
						self:SetBackdropBorderColor(self.IconBorder:GetVertexColor())
					end
				end)
				button:HookScript('OnHide', function(self)
					self.IconBorder:Hide() -- Apparently not getting hidden by blizzard?
					self:SetBackdropBorderColor(unpack(AS.BorderColor))
				end)

				AS:SkinTexture(button.icon)
				button:GetNormalTexture():SetTexture(nil)

				button.icon:SetInside()
				button.isStyled = true
			end
		end
	end

	-- Swap item flyout frame (shown when holding alt over a slot)
	EquipmentFlyoutFrame:HookScript("OnShow", SkinItemFlyouts)
	hooksecurefunc("EquipmentFlyout_Show", SkinItemFlyouts)

	local ScrollBars = {
		PaperDollTitlesPaneScrollBar,
		PaperDollEquipmentManagerPaneScrollBar,
		CharacterStatsPaneScrollBar,
		ReputationListScrollFrameScrollBar,
	}

	for _, ScrollBar in pairs(ScrollBars) do
		AS:SkinScrollBar(ScrollBar)
	end

	--Titles
	PaperDollTitlesPane:HookScript("OnShow", function(self)
		for x, object in pairs(PaperDollTitlesPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)
			object.SelectedBar:SetTexture(nil)
			object:SetHighlightTexture(nil)
			object:HookScript('OnEnter', function(self) self.text:SetTextColor(0, 0.44, .87) end)
			object:HookScript('OnLeave', function(self) self.text:SetTextColor(1, .82, 0) end)

			object.text:SetFont(AS.Font, 12)
		end
	end)

	--Equipement Manager
	PaperDollEquipmentManagerPaneEquipSet:SkinButton()
	PaperDollEquipmentManagerPaneSaveSet:SkinButton()
	GearManagerDialogPopupScrollFrameScrollBar:SkinScrollBar()
	PaperDollEquipmentManagerPaneEquipSet:Width(PaperDollEquipmentManagerPaneEquipSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneSaveSet:Width(PaperDollEquipmentManagerPaneSaveSet:GetWidth() - 8)
	PaperDollEquipmentManagerPaneEquipSet:Point("TOPLEFT", PaperDollEquipmentManagerPane, "TOPLEFT", 8, 0)
	PaperDollEquipmentManagerPaneSaveSet:Point("LEFT", PaperDollEquipmentManagerPaneEquipSet, "RIGHT", 4, 0)
	PaperDollEquipmentManagerPaneEquipSet.ButtonBackground:SetTexture(nil)
	PaperDollEquipmentManagerPane:HookScript("OnShow", function(self)
		for x, object in pairs(PaperDollEquipmentManagerPane.buttons) do
			object.BgTop:SetTexture(nil)
			object.BgBottom:SetTexture(nil)
			object.BgMiddle:SetTexture(nil)

			object.icon:SetTexCoord(.08, .92, .08, .92)
			object:SetTemplate("Default")
		end
		GearManagerDialogPopup:StripTextures()
		GearManagerDialogPopup:SetTemplate("Default")
		GearManagerDialogPopup:Point("LEFT", PaperDollFrame, "RIGHT", 4, 0)
		GearManagerDialogPopupScrollFrame:StripTextures()
		GearManagerDialogPopupEditBox:StripTextures()
		GearManagerDialogPopupEditBox:SetTemplate("Default")
		GearManagerDialogPopupOkay:SkinButton()
		GearManagerDialogPopupCancel:SkinButton()
		
		for i = 1, NUM_GEARSET_ICONS_SHOWN do
			local button = _G["GearManagerDialogPopupButton"..i]
			local icon = button.icon
			
			if button then
				button:StripTextures()
				button:StyleButton()
				
				icon:SetTexCoord(.08, .92, .08, .92)
				_G["GearManagerDialogPopupButton"..i.."Icon"]:SetTexture(nil)
				
				icon:ClearAllPoints()
				icon:Point("TOPLEFT", 2, -2)
				icon:Point("BOTTOMRIGHT", -2, 2)	
				button:SetFrameLevel(button:GetFrameLevel() + 2)
				if not button.Backdrop then
					button:CreateBackdrop("Default")
					button.Backdrop:SetAllPoints()			
				end
			end
		end
	end)

	for i = 1, 4 do
		AS:SkinTab(_G["CharacterFrameTab"..i])
	end

	local function FixSidebarTabCoords()
		for i = 1, #PAPERDOLL_SIDEBARS do
			local tab = _G["PaperDollSidebarTab"..i]
			if tab then
				tab.Highlight:SetTexture(1, 1, 1, 0.3)
				tab.Highlight:Point("TOPLEFT", 3, -4)
				tab.Highlight:Point("BOTTOMRIGHT", -1, 0)
				tab.Hider:SetTexture(0.4,0.4,0.4,0.4)
				tab.Hider:Point("TOPLEFT", 3, -4)
				tab.Hider:Point("BOTTOMRIGHT", -1, 0)
				tab.TabBg:Kill()

				if i == 1 then
					for i=1, tab:GetNumRegions() do
						local region = select(i, tab:GetRegions())
						region:SetTexCoord(0.16, 0.86, 0.16, 0.86)
						region.SetTexCoord = AS.Noop
					end
				end
				tab:CreateBackdrop("Default")
				tab.Backdrop:Point("TOPLEFT", 1, -2)
				tab.Backdrop:Point("BOTTOMRIGHT", 1, -2)	
			end
		end
	end
	hooksecurefunc("PaperDollFrame_UpdateSidebarTabs", FixSidebarTabCoords)

	for i = 1, 7 do
		local Frame = _G["CharacterStatsPaneCategory"..i]
		Frame.BgTop:SetTexture(nil)
		Frame.BgBottom:SetTexture(nil)
		Frame.BgMiddle:SetTexture(nil)
		Frame.BgMinimized:SetTexture(nil)
		AS:SkinFrame(Frame, nil, true)
	end

	-- Pet
	PetModelFrame:CreateBackdrop("Default")
	AS:SkinNextPrevButton(PetModelFrameRotateRightButton)
	AS:SkinNextPrevButton(PetModelFrameRotateLeftButton)
	PetModelFrameRotateRightButton:ClearAllPoints()
	PetModelFrameRotateRightButton:Point("LEFT", PetModelFrameRotateLeftButton, "RIGHT", 4, 0)

	PetPaperDollPetInfo:CreateBackdrop("Default")
	PetPaperDollPetInfo:Size(24, 24)
	PetPaperDollPetInfo:GetRegions():SetTexCoord(.12, .63, .15, .55)

	-- Reputation
	for i = 1, 15 do
		AS:SkinStatusBar(_G["ReputationBar"..i.."ReputationBar"])
		_G["ReputationBar"..i.."Background"]:SetTexture(nil)
		_G["ReputationBar"..i.."ReputationBarHighlight1"]:SetTexture(nil)
		_G["ReputationBar"..i.."ReputationBarHighlight2"]:SetTexture(nil)	
		_G["ReputationBar"..i.."ReputationBarAtWarHighlight1"]:SetTexture(nil)
		_G["ReputationBar"..i.."ReputationBarAtWarHighlight2"]:SetTexture(nil)
		_G["ReputationBar"..i.."ReputationBarLeftTexture"]:SetTexture(nil)
		_G["ReputationBar"..i.."ReputationBarRightTexture"]:SetTexture(nil)
	end

	local function UpdateFaction()
		local factionOffset = FauxScrollFrame_GetOffset(ReputationListScrollFrame)
		for i = 1, NUM_FACTIONS_DISPLAYED do
			local Bar = _G["ReputationBar"..i]
			local Button = _G["ReputationBar"..i.."ExpandOrCollapseButton"]
			Button:SetNormalTexture("Interface\\Buttons\\UI-PlusMinus-Buttons")
			Button:GetNormalTexture():SetInside()
			Button:SetHighlightTexture(nil)

			if Bar.isCollapsed then
				Button:GetNormalTexture():SetTexCoord(0, 0.4375, 0, 0.4375)
			else
				Button:GetNormalTexture():SetTexCoord(0.5625, 1, 0, 0.4375)
			end

			local factionIndex = factionOffset + i
			if (factionIndex <= GetNumFactions()) then
				local name, description, standingID, barMin, barMax, barValue, atWarWith, canToggleAtWar, isHeader, isCollapsed, hasRep, isWatched, isChild, factionID, hasBonusRepGain, canBeLFGBonus = GetFactionInfo(factionIndex);

				local FactionName = _G["ReputationBar"..i.."FactionName"]
				FactionName:SetText(name)
				if atWarWith and canToggleAtWar then
					FactionName:SetFormattedText("%s|TInterface\\Buttons\\UI-CheckBox-SwordCheck:16:16:%d:0:32:32:0:16:0:16|t", name, -(16 + FactionName:GetStringWidth()))
				end
			end
		end
	end

	ReputationListScrollFrame:StripTextures()
	AS:SkinFrame(ReputationDetailFrame)
	ReputationDetailFrame:Point("TOPLEFT", ReputationFrame, "TOPRIGHT", 4, -28)
	hooksecurefunc("ReputationFrame_Update", UpdateFaction)
	AS:SkinCloseButton(ReputationDetailCloseButton)
	AS:SkinCheckBox(ReputationDetailAtWarCheckBox)
	ReputationDetailAtWarCheckBox:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-SwordCheck")
	AS:SkinCheckBox(ReputationDetailLFGBonusReputationCheckBox)
	AS:SkinCheckBox(ReputationDetailInactiveCheckBox)
	AS:SkinCheckBox(ReputationDetailMainScreenCheckBox)
	
	--Currency
	AS:SkinFrame(TokenFramePopup)
	TokenFramePopup:Point("TOPLEFT", TokenFrame, "TOPRIGHT", 4, -28)				
	TokenFrame:HookScript("OnShow", function()
		for i=1, GetCurrencyListSize() do
			local button = _G["TokenFrameContainerButton"..i]
			
			if button then
				button.highlight:Kill()
				button.categoryMiddle:Kill()	
				button.categoryLeft:Kill()	
				button.categoryRight:Kill()
				button.LinkButton:Show()
				if button.icon then
					button.icon:SetTexCoord(.08, .92, .08, .92)
				end
			end
		end
	end)
	AS:SkinScrollBar(TokenFrameContainerScrollBar)
	AS:SkinCloseButton(TokenFramePopupCloseButton)
	AS:SkinCheckBox(TokenFramePopupInactiveCheckBox)
	AS:SkinCheckBox(TokenFramePopupBackpackCheckBox)
end

AS:RegisterSkin(name, AS.Blizzard_CharacterFrame)