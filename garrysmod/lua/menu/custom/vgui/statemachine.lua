

--#region StateMachinePagenation
local PANEL = {}

function PANEL:AddPage(name)
    if self.Pages[name] then ErrorNoHaltWithStack("Page \"",name,"\" Already Exists in State Machine Controls") return end

    self.Pages[name] = vgui.Create("DButton", self, name)

    --Setting text
    --self.Pages[name]:SetText(name or "")
    self.Pages[name]:SetText("")
    self.Pages[name]:Dock(LEFT)
    self.Pages[name]:SetWide(self.Pages[name]:GetTall())

    self.Pages[name].DoClick = function()
        self:GetParent():UpdateActivePage(name)
    end

end


function PANEL:Init()
    self.Pages = {}
    self:Dock(TOP)
end

function PANEL:Paint(w, h)
    surface.SetDrawColor(0, 0, 255, 255)
    surface.DrawRect(0, 0, w, h)
end

vgui.Register("StateMachinePagenation", PANEL, "Panel")
--#endregion




PANEL = {}

function PANEL:AddState(name)
    local newpnl = vgui.Create("DPanel", self, name)
    newpnl:Dock(FILL)
    newpnl:SetVisible(false)
    local index = table.insert(self.States, newpnl)

    if self.Controls then
        self.Controls:AddPage(name)
    end

    return self.States[index]
end

function PANEL:GetState(name)
    return self.States[name]
end
function PANEL:ListStates()
    PrintTable(self.States)
end



function PANEL:Init()
    self.States = {} --Table to hold the root panel to each state created


    --self.Controls = vgui.Create("StateMachinePagenation", self, "ControlsRoots")

    self:Dock(FILL)

end

-- Called from the StateMachinePagenation element when button is clicked
function PANEL:UpdateActivePage(name)
    for _,v in pairs(self.States) do
        if v:GetName() == name then
            v:SetVisible(!v:IsVisible())
        else
            v:SetVisible(false)
        end
    end
end






vgui.Register("StateMachine", PANEL, "Panel")