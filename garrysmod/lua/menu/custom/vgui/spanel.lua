local PANEL = {}


function PANEL:Init()
    self:SetPaintBackgroundEnabled( false ) --Disable Engine Painting
    self:SetSize(100, 100)
    self:Center()
end

function PANEL:Paint(w,h)
    surface.SetDrawColor(184,130,215,255)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("SPanel", PANEL, "Panel")