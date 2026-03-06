local AS, L, S, R = unpack(AddOnSkins)

function R:RareScanner()
	local frame = RARESCANNER_BUTTON
	if not frame then return end

	S:HandleFrame(frame, 'Default')

	if frame.CloseButton then
		S:HandleButton(frame.CloseButton)
		frame.CloseButton:ClearAllPoints()
		frame.CloseButton:SetPoint("TOPRIGHT", -5, -5)
	end

	if frame.FilterEntityButton then
		S:HandleButton(frame.FilterEntityButton)
		frame.FilterEntityButton:SetNormalTexture([[Interface\WorldMap\Dash_64Grey]])
		frame.FilterEntityButton:ClearAllPoints()
		frame.FilterEntityButton:SetPoint("TOPLEFT", 5, -5)
	end

	if frame.FilterEnabledTexture then
		frame.FilterEnabledTexture:SetTexture([[Interface\WorldMap\Skull_64]])
	end

	if frame.UnfilterEnabledButton then
		S:HandleButton(frame.UnfilterEnabledButton)
		frame.UnfilterEnabledButton:ClearAllPoints()
		frame.UnfilterEnabledButton:SetPoint("TOPLEFT", 5, -5)
	end
end

AS:RegisterSkin('RareScanner')
