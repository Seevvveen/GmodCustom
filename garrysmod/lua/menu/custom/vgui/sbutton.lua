local PANEL = {}


AccessorFunc(PANEL, "m_bIsToggle", "IsToggle", FORCE_BOOL)
AccessorFunc(PANEL, "m_bToggle", "Toggle", FORCE_BOOL)





function PANEL:Init()
    self:SetCursor("Hand")
    self:SetIsToggle(false)
    self:SetSize(50, 50)
end

function PANEL:Paint(w,h)
    surface.SetDrawColor(255,0,0,255)
    surface.DrawRect(0, 0, w, h)
end

function PANEL:Toggle()
    if !self:GetIsToggle() then return end --guard
    self:SetToggle(!self:GetToggle() ) -- invert state
    self:OnToggled( self:GetToggle() ) -- call hook
end

function PANEL:OnMousePressed(mousecode)
    if !self:IsEnabled() then return end
    self:MouseCapture(true)
    self:OnDepressed()

    if ( mousecode == MOUSE_RIGHT ) then
        self:DoRightClick()
    elseif mousecode == MOUSE_LEFT then
        self:DoClick()
    elseif mousecode == MOUSE_MIDDLE then
        self:DoMiddleClick()
    end


end

function PANEL:OnMouseReleased()
    self:MouseCapture(false)
    if self.Depressed then
        self.Depressed = false
    end
end

function PANEL:OnDepressed()
    self.Depressed = true
end

function PANEL:DoClick()
    print("Clicked")
end

function PANEL:DoRightClick()
    print("Right Clicked")
end

function PANEL:DoMiddleClick()
    print("Middle Clicked")
end


vgui.Register("SButton", PANEL, "SPanel")