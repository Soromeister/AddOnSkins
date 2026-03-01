local AS, L, S, R = unpack(AddOnSkins)

function R:SilverDragon()
	local SD = LibStub("AceAddon-3.0"):GetAddon("SilverDragon", true)
	if not SD then return end

	local module = SD:GetModule("ClickTarget", true)
	if not module then return end

	local origApplyLook = module.ApplyLook
	if type(origApplyLook) ~= 'function' then return end

	module.ApplyLook = function(mod, popup, look)
		origApplyLook(mod, popup, look)
		if not popup then return end

		if not popup.SD_Skinned then
			popup.SD_Skinned = true
			S:SetTemplate(popup)

			if popup.close then
				S:HandleCloseButton(popup.close, true)

				if popup.close.backdrop then
					popup.close.backdrop:SetPoint('TOPLEFT', 7, -8)
					popup.close.backdrop:SetPoint('BOTTOMRIGHT', -8, 8)
				end

				popup.close:ClearAllPoints()
				popup.close:SetFrameLevel(popup:GetFrameLevel() + 2)
				popup.close:SetPoint("TOPRIGHT", popup, 'TOPRIGHT', 4, 4)
				popup.close:SetScale(1)

				popup.close:HookScript("OnEnter", function(btn)
					if btn.Text then btn.Text:SetTextColor(1, .2, .2) end
					if btn.backdrop then btn.backdrop:SetBackdropBorderColor(1, .2, .2) end
				end)

				popup.close:HookScript("OnLeave", function(btn)
					if btn.Text then btn.Text:SetTextColor(1, 1, 1) end
					if btn.backdrop then btn.backdrop:SetBackdropBorderColor(unpack(AS.BorderColor)) end
				end)
			end
		end

		local font = AS.Libs.LSM:Fetch('font', AS:CheckOption('DBMFont'))
		local fontSize = AS:CheckOption('DBMFontSize')
		local fontFlag = AS:CheckOption('DBMFontFlag')
		if popup.title then popup.title:SetFont(font, fontSize, fontFlag) end
		if popup.source then
			popup.source:SetFont(font, fontSize, fontFlag)
			popup.source:SetTextColor(1.0, 1.0, 1.0)
		end
		if popup.status then
			popup.status:SetFont(font, fontSize, fontFlag)
			popup.status:SetTextColor(1.0, 1.0, 1.0)
		end
	end
end

AS:RegisterSkin('SilverDragon')
