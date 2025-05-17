local PANEL = {}

-- Create an accessor for the draggable flag
AccessorFunc(PANEL, "m_bDraggable", "Draggable", FORCE_BOOL)

function PANEL:Init()
    self:SetDraggable(true)
    self:SetSize(250,125)

    self:Center()

    self.AddonThumbnail = vgui.Create("DImage",self,"AddonThumbnail")

    self.AddonThumbnail:Center()

    --self:Hide()
end

function PANEL:OnMousePressed()
    if self:GetDraggable() then
        self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
        self:MouseCapture(true)
    end
end

function PANEL:Think()
    if self.Dragging then
        local mousex = math.Clamp(gui.MouseX(), 1, ScrW() - 1)
        local mousey = math.Clamp(gui.MouseY(), 1, ScrH() - 1)
        local x = mousex - self.Dragging[1]
        local y = mousey - self.Dragging[2]

        self:SetPos(x, y)

    end
end

function PANEL:OnMouseReleased()
    self.Dragging = nil
    self:MouseCapture(false)
end

function PANEL:Paint(w,h)
    draw.RoundedBox(16, 0, 0, w, h, Color(255,21,21,255))
end


function PANEL:WorkshopStart()
    --self:Show()
end

function PANEL:WorkshopDownloadTotals(numberRemaining, numberTotal)

end

function PANEL:WorkshopDownloadFile(ID, imgID, title, size)
    --self.AddonThumbnail:SetImage( nil )

    print(ID, imgID, title, size)


    steamworks.Download( imgID, false, function( name )
        print(name)
        self.AddonThumbnail:SetMaterial( AddonMaterial(name) )

    end)

end

function PANEL:WorkshopDownloadProgress(ID, imgID, title, downloaded, expected)

end

function PANEL:WorkshopExtractProgress(ID, imgID, title, percentExtracted)
end

function PANEL:WorkshopDownloadedFile(ID, title)
    print("Downlaoded")
end

function PANEL:WorkshopEnd()
    --self:Hide()
end

vgui.Register("downloader", PANEL, "EditablePanel")
