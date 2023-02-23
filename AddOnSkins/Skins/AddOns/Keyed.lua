local AS, L, S, R = unpack(AddOnSkins)

if not AS:CheckAddOn('Keyed') then return end

function AS:Keyed()
	S:HandleFrame(KeyedFrame)
	S:HandleFrame(KeyedFrameInset)
	S:HandleCheckBox(KeyedFrameShowMinimapButton)
	S:HandleCloseButton(KeyedFrameCloseButton)
	S:StripTextures(KeystoneListScrollFrame, true)
	S:HandleScrollBar(KeystoneListScrollFrameScrollBar)

	for i = 1, 3 do
		S:HandleButton(_G["KeyedFrameColumnHeader"..i], true)
	end

	KeyedFrameColumnHeader1:SetPoint("TOPLEFT", 4, -57)
	KeyedFrameColumnHeader3:SetWidth(48)
end

AS:RegisterSkin('Keyed', AS.Keyed)
