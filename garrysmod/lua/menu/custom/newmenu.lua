---@diagnostic disable: undefined-field, inject-field, param-type-mismatch
print("your on the new menu stupid :D")


include "vguiloader.lua"

local topbar = vgui.Create("SPanel", nil, "TopBar")
topbar:SetTall(30)
topbar:Dock(TOP)
topbar:DockMargin(5, 5, 5, 5)

local MainView = vgui.Create("StateMachine", nil, "MainView")
MainView:Dock(FILL)
local StartGamePnl = MainView:AddState("StartGame")
local MultiplayerPnl = MainView:AddState("Multiplayer")
MainView:AddState("Options")


local StartGameButton = vgui.Create("SButton", topbar, "StartGameButton")
StartGameButton:Dock(LEFT)
StartGameButton:DockMargin(5, 5, 5, 5)
function StartGameButton:DoClick()
    MainView:UpdateActivePage("StartGame")
end
function StartGameButton:Paint(w,h)
    surface.SetDrawColor(color_white)
    surface.DrawRect(0, 0, w, h)
end

local MultiplayerButton = vgui.Create("SButton", topbar, "MultiplayerButton")
MultiplayerButton:Dock(LEFT)
MultiplayerButton:DockMargin(5, 5, 5, 5)

local ServerList = vgui.Create("DScrollPanel", MultiplayerPnl, "ServerList")
ServerList:Dock(FILL)
ServerList:DockMargin(5, 5, 5, 5)









function MultiplayerButton:DoClick()
    MainView:UpdateActivePage("Multiplayer")

    local data = {
        Type = "internet",
        GameDir = "garrysmod",
        AppID = 4000,
        Callback = function(ping,name,desc,map,players,maxplayers,botplayers,pass,lastplayed,address,gamemode,workshopid,isanon,version,localization,gmcategory)
            local ServerItem = ServerList:Add( "DButton" )
            ServerItem:Dock(TOP)
            ServerItem:DockMargin(0, 0, 0, 5)
            ServerItem:SetText(name)
            function ServerItem:DoClick()
                JoinServer(address)
            end
        end,
        CallbackFailed = function (address)
            print("callback failed")
        end,
        Finished = function ()
            print("Finished")
        end,
    }

    serverlist.Query(data)
end






local SourceBackupMultiplayerButton = vgui.Create("SButton", MultiplayerPnl, "SourceBackupMultiplayerButton")
SourceBackupMultiplayerButton:Dock(TOP)
SourceBackupMultiplayerButton:SetTall(30)
function SourceBackupMultiplayerButton:DoClick()
    RunConsoleCommand("gamemenucommand", "OpenServerBrowser")
end