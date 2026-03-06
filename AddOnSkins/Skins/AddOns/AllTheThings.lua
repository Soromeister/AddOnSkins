local AS, L, S, R = unpack(AddOnSkins)

local windowsToSkin = { Prime = true, CurrentInstance = true, WorldQuests = true }

local function SkinATTWindow(Window)
	if not Window or Window.ATT_Skinned then return end
	Window.ATT_Skinned = true

	S:SetTemplate(Window)

	if Window.CloseButton then S:HandleCloseButton(Window.CloseButton) end
	if Window.ScrollBar then
		S:HandleScrollBar(Window.ScrollBar)
		if Window.Container then
			Window.Container:SetPoint("RIGHT", Window.ScrollBar, "LEFT", -3, 0)
		end
	end
end

function R:AllTheThings()
	if not AllTheThings or not AllTheThings.GetWindow then return end

	-- Wrap GetWindow so we skin windows lazily when ATT initializes them,
	-- rather than calling GetWindow ourselves and creating bare frames prematurely.
	local origGetWindow = AllTheThings.GetWindow
	AllTheThings.GetWindow = function(addon, name)
		local win = origGetWindow(addon, name)
		if windowsToSkin[name] and win then
			SkinATTWindow(win)
		end
		return win
	end
end

AS:RegisterSkin('AllTheThings')
