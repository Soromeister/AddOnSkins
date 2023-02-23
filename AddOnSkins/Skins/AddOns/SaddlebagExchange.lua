local AS, L, S, R = unpack(AddOnSkins)

if not AS:CheckAddOn('Saddlebag') then return end

function AS:Saddlebag()
	local Saddlebag = LibStub("AceAddon-3.0"):GetAddon("Saddlebag")
	hooksecurefunc(Saddlebag, 'auctionButton', function()
		if not SaddlebagFrame.isSkinned then
			S:HandleFrame(SaddlebagFrame)
			S:HandleButton(SaddlebagFrameButton)
			S:HandleScrollBar(SaddlebagScrollFrameScrollBar)
			SaddlebagFrame.isSkinned = true
		end
	end)
end

AS:RegisterSkin('Saddlebag', AS.Saddlebag)
