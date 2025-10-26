repeat
    wait()
until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")
repeat
    wait()
until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
repeat wait() until game:GetService("ReplicatedStorage"):FindFirstChild("PrivateServerOwnerId") and game:GetService("ReplicatedStorage").PrivateServerOwnerId.Value == 0 
local requests = http_request or request
local HttpService = game:GetService("HttpService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local Plr = Players.LocalPlayer

local function invokeServer(...)
    return ReplicatedStorage.Remotes.CommF_:InvokeServer(...)
end

local args =
    {'Death Step', 'Sharkman Karate', 'Electric Claw', 'Dragon Talon', 'Superhuman', 'Godhuman', 'Sanguine Art'}
local concac = {"Last Resort", "Agility", "Water Body", "Heavenly Blood", "Heightened Senses", "Energy Core",
                "Primordial Reign"}

_print = function()
    
end
_print("LOGGING")
repeat
    wait()
until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild("DataLoaded")

local plr = game.Players.LocalPlayer

local l_Remotes_0 = game.ReplicatedStorage:WaitForChild("Remotes");
if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)") then
    repeat
        wait()
    until not game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("Main (minimal)")
end
function scriptojoin()
    return
        'game:GetService("TeleportService"):TeleportToPlaceInstance(' .. game.PlaceId .. ',"' .. game.JobId .. '",' ..
            'game.Players.LocalPlayer)'
end

function getfm()
    if game:GetService("Lighting"):GetAttribute("MoonPhase") == 5 and
        (math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5) then
        return "Full Moon"
    elseif game:GetService("Lighting"):GetAttribute("MoonPhase") == 4 then
        return "Next Night"
    else
        return "Bad Moon"
    end
end

function getmirage()
    if game:GetService("Workspace").Map:FindFirstChild("MysticIsland") then
        return true
    else
        return false
    end
end

function checkgatcan()
    local a = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer(
        "CheckTempleDoor")
    if a then
        return "Pulled"
    else
        return "No"
    end
end

function data()
    return math.floor(game.Lighting.ClockTime) .. " | " .. game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers ..
               getfm() .. getmirage() .. checkgatcan()
end

function isrealmoon()
    return (math.floor(game.Lighting.ClockTime) >= 12 or math.floor(game.Lighting.ClockTime) < 5)
end

function isnight()
    return (math.floor(game.Lighting.ClockTime) >= 18 or math.floor(game.Lighting.ClockTime) < 5)
end

function HavePrehistoricIsland()
    return workspace.Map:FindFirstChild("PrehistoricIsland")
end

function HaveRareBoss(name)
    for i, v in game:GetService("ReplicatedStorage"):GetChildren() do
        if string.find(v.Name, name) then
            return true
        end
    end
    for i, v in workspace.Enemies:GetChildren() do
        if string.find(v.Name, name) then
            return true
        end
    end
    for i, v in workspace._WorldOrigin.EnemySpawns:GetChildren() do
        if string.find(v.Name, name) then
            return true
        end
    end
end

local rareboss = {"rip_indra True Form", "Darkbeard", "Dough King", "Cursed Captain", 'Soul Reaper'}
local save = {}
function havelegnpc()
    if not workspace.NPCs:FindFirstChild("Legendary Sword Dealer ") then
        if game:GetService("ReplicatedStorage").NPCs["Legendary Sword Dealer "].HumanoidRootPart.CFrame.Position.X ~= 0 then
            return true
        end
    else
        if (workspace.NPCs:FindFirstChild("Legendary Sword Dealer ").HumanoidRootPart.CFrame.X) ~= 0 then
            return true
        end
    end
end

function anat(_type, extra)
    request({
        Url = 'https://discord.com/api/webhooks/1418817893864575132/AcVbolJUUa7NBolEbKgPUQ5NU1XlOcAOfAMcAeD3E7ZBWyMgU1dmOpXMGXB_4x_UaTBI', 
        Method = 'POST', 
        Headers = {["Content-Type"] = "application/json"}, 
        Body = game:GetService("HttpService"):JSONEncode({
            content = _type .. ' ' .. extra .. ' | ' .. game.JobId .. ' ' .. game.Players.LocalPlayer.Name
        })
    })
end

anat("Filter", "Loaded")

local v245 = nil
local v246 = nil

function notifications()
    for i, v in game:GetService("Players").LocalPlayer.PlayerGui.Notifications:GetChildren() do
        if v:IsA("TextLabel") then
            if (v:FindFirstChild("TranslateMe") and string.find(tostring(v.TranslateMe.Text), "spotted")) or
                string.find(tostring(v.Text), "spotted") then
                if game.Players.NumPlayers < game.Players.MaxPlayers then
                    local payloadmoon = {
                        ["JobId"] = tostring(game.JobId),
                        ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                        ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                        ["MoonPhase"] = getfm(),
                        ["IsNight"] = isnight(),
                        ["Script To Join"] = scriptojoin(),
                        ["Type"] = "Castle"
                    }
                    local DataCallBack = request({
                        Url = "http://157.66.27.219:1503/data-private",
                        Method = 'POST',
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = game:GetService("HttpService"):JSONEncode(payloadmoon)
                    })
                    task.wait(15)
                    break
                end

            end
        end
    end
end

game:GetService("Players").LocalPlayer.PlayerGui.Notifications.ChildAdded:Connect(notifications)

function getelite()
    local boss = { "Deandre", "Diablo", "Urban" }
    repeat wait() until workspace._WorldOrigin:FindFirstChild("EnemySpawns")
    for i, v in workspace._WorldOrigin.EnemySpawns:GetChildren() do
        if table.find(boss, v.Name) then
            return v
        end
    end
    for i, v in workspace.Enemies:GetChildren() do
        if table.find(boss, v.Name) then
            return v
        end
    end
    for i, v in game:GetService("ReplicatedStorage"):GetChildren() do
        if table.find(boss, v.Name) then
            return v
        end
    end
    return false
end

spawn(function()
    while wait(15) do
        for i, v in rareboss do
            if getelite() then
                local payloadelite = {
                    ["JobId"] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ["Elite"] = getelite().Name,
                    ["IsNight"] = isnight(),
                    ["Script To Join"] = scriptojoin(),
                    ["Type"] = "Elite"
                }
                local DataCallBack = request({
                    Url = "http://157.66.27.219:1503/data-private",
                    Method = 'POST',
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode(payloadelite)
                })
                repeat wait() until not getelite()
            end
        end
    end
end)

spawn(function()
    while wait() do
        local a, b  = xpcall(function()
            while wait() do
                _print("HIT")
                v245, v246 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("ColorsDealer", "1")
                if v246 and v246 >= 3 then 
                if v245 and v245 ~= OldHaki then
                    OldHaki = v245
                    local payloadleghaki = {
                        ["JobId"] = tostring(game.JobId),
                        ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                        ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                        ["Haki"] = v245,
                        ["IsNight"] = isnight(),
                        ["Script To Join"] = scriptojoin(),
                        ["Type"] = "Legendary Haki"
                    }
                    _print("Send Haki Data")
                    anat("Haki", v245, game.JobId)
                                    if game.Players.NumPlayers < game.Players.MaxPlayers then 

                    local DataCallBack = request({
                        Url = "https://api-bf.yummydata.click/data-private",
                        Method = 'POST',
                        Headers = {
                            ["Content-Type"] = "application/json"
                        },
                        Body = game:GetService("HttpService"):JSONEncode(payloadleghaki)

                    })
                end
                end
            end
                _print(10)
                if game.PlaceId == 4442272183 then
                    if havelegnpc() then
                        local v242 = game.ReplicatedStorage.Remotes.CommF_:InvokeServer("LegendarySwordDealer", "1");
                        if OldSword == v242 then return end 
                        _print("Send Sword Data", v242)
                        OldSword = v242
                        anat("Sword", v242, game.JobId)
                        local payloadleg = {
                            ["JobId"] = tostring(game.JobId),
                            ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                            ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                            ["Sword"] = v242,
                            ["IsNight"] = isnight(),
                            ["Script To Join"] = scriptojoin(),
                            ["Type"] = "Legendary Sword"
                        }
                                        if game.Players.NumPlayers < game.Players.MaxPlayers then 

                        local DataCallBack = request({
                            Url = "https://api-bf.yummydata.click/data-private",
                            Method = 'POST',
                            Headers = {
                                ["Content-Type"] = "application/json"
                            },
                            Body = game:GetService("HttpService"):JSONEncode(payloadleg)
                        })
                    end
                end
                        end
                for i, v in rareboss do
                        if HaveRareBoss(v) and not table.find(save, v) then
                            table.insert(save, v)
                            _print("SENT BOSS", v)
                            anat("boss", v, game.JobId)
                            local payloadRareBoss = {
                                ["JobId"] = tostring(game.JobId),
                                ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                                ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                                ["Rare Boss"] = v,
                                ["IsNight"] = isnight(),
                                ["Script To Join"] = scriptojoin(),
                                ["Type"] = "Rare Boss"
                            }
                                            if game.Players.NumPlayers < game.Players.MaxPlayers then 

                            local DataCallBack = request({
                                Url = "https://api-bf.yummydata.click/data-private",
                                Method = 'POST',
                                Headers = {
                                    ["Content-Type"] = "application/json"
                                },
                                Body = game:GetService("HttpService"):JSONEncode(payloadRareBoss)
                            })
                            --  repeat wait() until not HavePrehistoricIsland()
                        end
                        if not HaveRareBoss(v) and table.find(save, v) then
                            save[i] = nil
                        end
                end
            end
                _print(20)
                if HavePrehistoricIsland() and not toibingu then
                    toibingu = 1
                    _print("SENT PREHISTORIC ISLAND")
                    anat("prehistoric", 'island', game.JobId)
                local payloadPrehistocricIsland = {
                    ["JobId"] = tostring(game.JobId),
                    ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                    ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                    ["Prehistoric Island"] = HavePrehistoricIsland(),
                    ["IsNight"] = isnight(),
                    ["Script To Join"] = scriptojoin(),
                    ["Type"] = "Prehistoric Island"
                }
                local DataCallBack = request({
                    Url = "https://api-bf.yummydata.click/data-private",
                    Method = 'POST',
                    Headers = {
                        ["Content-Type"] = "application/json"
                    },
                    Body = game:GetService("HttpService"):JSONEncode(payloadPrehistocricIsland)
                })
                end
                _print(3)
                if getmirage() and not miragesent then
                    _print("SEND MIRAGE")
                    miragesent = true
                    anat("Mirage", 'island', game.JobId)
                        local payloadmirage = {
                            ["JobId"] = tostring(game.JobId),
                            ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                            ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                            ["Mirage"] = getmirage(),
                            ["IsNight"] = isnight(),
                            ["Script To Join"] = scriptojoin(),
                            ["Type"] = "Mirage"
                        }
                        local DataCallBack = request({
                            Url = "https://api-bf.yummydata.click/data-private",
                            Method = 'POST',
                            Headers = {
                                ["Content-Type"] = "application/json"
                            },
                            Body = game:GetService("HttpService"):JSONEncode(payloadmirage)
                        })
                end
                _print(40)
                if isrealmoon() and getfm() == "Full Moon" then
                        if os.time() - ( LAstSend or 0 ) < 1200 then continue end
                        anat("full", "moon", game.JobId)
                        local payloadmoon = {
                            ["JobId"] = tostring(game.JobId),
                            ["Players"] = game.Players.NumPlayers .. "/" .. game.Players.MaxPlayers,
                            ["ClockTime"] = math.floor(game.Lighting.ClockTime),
                            ["MoonPhase"] = getfm(),
                            ["IsNight"] = isnight(),
                            ["Script To Join"] = scriptojoin(),
                            ["Type"] = "Moon"
                        }
                        _print("S#ENT FULL MOON")
                        LAstSend = os.time()
                        local DataCallBack = request({
                            Url = "https://api-bf.yummydata.click/data-private",
                            Method = 'POST',
                            Headers = {
                                ["Content-Type"] = "application/json"
                            },
                            Body = game:GetService("HttpService"):JSONEncode(payloadmoon)
                        })
                end
                
            _print("PASS")
            end
        end, debug.traceback)
        if not a then _print("FAIL", a, b) anat("Finder Crashed\n", b or 'unexcepted error') end 
    end

end)
