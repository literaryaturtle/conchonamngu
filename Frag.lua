if not LPH_OBFUSCATED then 

            LPH_ENCSTR = LPH_ENCSTR or function(...) return ... end 
            LPH_NO_VIRTUALIZE = LPH_NO_VIRTUALIZE or function(...) return ... end 
        end 
        LPH_NO_VIRTUALIZE(function()
    

        getgenv().modechange = getgenv().modechange or {
            ['CDK'] = true,
            ['Pull Lever'] = true,
            ['MM'] = true,
            ['Force Race'] = {'Skypiea', "Mink", "Human"}, -- Skypiea, Shark, Mink, Human
            ['Auto Roll Race'] = true,
            ['Key'] = '55zNvhxztqLY',
            ['Boost FPS'] = true,
            ['Black Screen'] = true,
            ['FPS'] = 60
        }
        PirateRaidSenque = -1
        ForcedWeapon = 'Melee' -- dont touch

        function CheckKick(v)
            if v.Name == "ErrorPrompt" then
                task.wait(5)
                warn(v.TitleFrame.ErrorTitle.Text)
                warn(v.MessageArea.ErrorFrame.ErrorMessage.Text)
                if v.TitleFrame.ErrorTitle.Text == "Teleport Failed" then
                    if string.find(v.MessageArea.ErrorFrame.ErrorMessage.Text, "Unable to join game") then
                        while true do
                        end
                    end
                else
                    print("Checkkick rejoin")
                    while task.wait() do 
                        game:GetService("TeleportService"):Teleport(game.PlaceId)
                    end
                end
            end
        end

        game:GetService('CoreGui').RobloxPromptGui.promptOverlay.ChildAdded:Connect(CheckKick)
        Notify = function(text) 
            pcall(function() 
                require(game.ReplicatedStorage:WaitForChild('Notification')).new(text):Display()
            end)
        end 

        function IfTableHaveIndex(j) 
            for _ in j do 
                return true 
            end 
        end 
        print(1)
        function GetServers() 
            if LastServersDataPulled then 
                if os.time() - LastServersDataPulled < 600 then 
                    print("Use Old Servers...")
                    return CachedServers 
                end 
            end 
            print("Pulling new servers...")
            for i = 1, 100, 1 do 
                local data = game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer(i) 
                if IfTableHaveIndex(data) then 
                    LastServersDataPulled = os.time()
                    CachedServers = data 
                    print("Server datas found")
                    return data 
                end 
            end


        end

        spawn(function()
            GetServers()
            while task.wait(180) do
                GetServers()
            end
        end)

        function Hop(Reason, MaxPlayers, ForcedRegion)
            task.spawn(function()
                task.wait(20)
                Notify("Hop Timed Out")
                game:GetService("TeleportService"):Teleport(game.PlaceId)
            end)
            local Servers = GetServers() 
            local ArrayServers = {}

            for i, v in Servers do 
                table.insert(ArrayServers, {
                    JobId = i, 
                    Players = v.Count,
                    LastUpdate = v.__LastUpdate, 
                    Region = v.Region
                })
            end 
            print(#ArrayServers, 'servers received')

            for i = 1, #ArrayServers do 
                while task.wait() do
                    local Index = math.random(1, #ArrayServers) 
                    ServerData = ArrayServers[Index] 
                    if ServerData then 
                        if not MaxPlayers or ServerData.Players < MaxPlayers then
                            if not ForcedRegion or ServerData.Regoin == ForcedRegion then
                                print("Found Server:", ServerData.JobId, 'Player Count:', ServerData.Players, "Region:", ServerData.Region)
                                break
                            end
                        end
                    else
                        Notify("No Servers")
                        break
                    end
                end

                Notify('Hopping to', ServerData.JobId, '...')
                game:GetService("ReplicatedStorage"):WaitForChild("__ServerBrowser"):InvokeServer('teleport', ServerData.JobId)
            end
        end

        placeId = game.PlaceId
        if placeId == 2753915549 then
            Sea = 'Main'
            SeaIndex = 1
        elseif placeId == 4442272183 then
            Sea = 'Dressrosa'
            SeaIndex = 2
        elseif placeId == 7449423635 then
            Sea = 'Zou'
            SeaIndex = 3
        end


        
        local Modules = game.ReplicatedStorage.Modules
        local Net = Modules.Net
        local Register_Hit, Register_Attack = Net:WaitForChild('RE/RegisterHit'), Net:WaitForChild('RE/RegisterAttack')
        local Funcs = {}
        function GetAllBladeHits()
            bladehits = {}
            for _, v in pairs(workspace.Enemies:GetChildren()) do
                if v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 
                and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
                    table.insert(bladehits, v)
                end
            end
            return bladehits
        end
        function Getplayerhit()
            bladehits = {}
            for _, v in pairs(workspace.Characters:GetChildren()) do
                if v.Name ~= game.Players.LocalPlayer.Name and v:FindFirstChild('Humanoid') and v:FindFirstChild('HumanoidRootPart') and v.Humanoid.Health > 0 
                and (v.HumanoidRootPart.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude <= 65 then
                    table.insert(bladehits, v)
                end
            end
            return bladehits
        end

        local Net = game.ReplicatedStorage.Modules.Net

        local RegisterAttack = require(Net):RemoteEvent('RegisterAttack', true)
        local RegisterHit = require(Net):RemoteEvent('RegisterHit', true)

        function Funcs:Attack()
            
            
            local bladehits = {}
            for r,v in pairs(GetAllBladeHits()) do
                table.insert(bladehits, v)
        
            end
            for r,v in pairs(Getplayerhit()) do
                table.insert(bladehits, v)
            end
            
            if #bladehits == 0 then
                
                return
            end
            
            local args = {
                [1] = nil;
                [2] = {},
                [4] = '078da341'
            }
            for r, v in pairs(bladehits) do
                
                
                RegisterAttack:FireServer(0)
                if not args[1] then
                    args[1] = v.Head
                end
                table.insert(args[2], {
                    [1] = v,
                    [2] = v.HumanoidRootPart
                })
                table.insert(args[2], v)
            end
            
            
            RegisterHit:FireServer(unpack(args))
        end

        task.spawn(function() 
            while task.wait(.05) do 
                if _G.FastAttack == os.time() then 
                    pcall(function() 
                        Funcs:Attack() 
                    end)
                end 
            end
        end)

        getgenv().Attack = function(MonResult) 
            pcall(function() 
                _G.FastAttack = os.time()
            end)
        end 

        if not modechange then return end 
        if modechange.Key ~= ('55zNvhxztqLY') then return end 

        repeat wait() until game:IsLoaded() and game.Players.LocalPlayer:FindFirstChild('DataLoaded')

        
        repeat wait()
            game.ReplicatedStorage.Remotes.CommF_:InvokeServer('SetTeam', 'Pirates')
        until game.Players.LocalPlayer.Character
        LastIdleCheck = os.time()
        
        Notify("Load r do fen")
        spawn(function()
            if true then return end
            game:GetService("Players").LocalPlayer.PlayerScripts:WaitForChild('NewIslandLOD', 9999):Destroy() 
            game:GetService("Players")LocalPlayer.PlayerScripts:WaitForChild('IslandLOD', 9999):Destroy() 
        end)

        Players = game.Players
        LocalPlayer = Players.LocalPlayer
        Character = LocalPlayer.Character

        Humanoid = Character:WaitForChild('Humanoid')
        HumanoidRootPart = Character:WaitForChild('HumanoidRootPart')

        PlayerGui = LocalPlayer:WaitForChild('PlayerGui', 10)
        Lighting = game:GetService('Lighting')


        ConChoChisiti36 = {
            PlayerData = {}, 
            Enemies = {}, 
            NPCs = {}, 
            Tools = {}
        } 

        Services = {}

        setmetatable(Services, {
            __index = function(_, Index)
                return game:GetService(Index)
            end
        });

        setmetatable(ConChoChisiti36.Enemies, {
            __index = function(_, Index)
                return Services.Workspace.Enemies:FindFirstChild(Index) or Services.ReplicatedStorage:FindFirstChild(Index)
            end
        })

        setmetatable(ConChoChisiti36.Tools, {
            __index = function(Self, Index)
                return LocalPlayer.Character:FindFirstChild(Index) or LocalPlayer.Backpack:FindFirstChild(Index)
            end
        })

        setmetatable(ConChoChisiti36.NPCs, {
            __index = function(_, Index)
                return workspace.NPCs:FindFirstChild(Index) or game.ReplicatedStorage.NPCs:FindFirstChild(Index)
            end
        })


        Remotes = {}
        setmetatable(Remotes, {
            __index = function(Self, Key)
                if Key ~= 'CommF_' then
                    warn('captured unregistered signal', key)
                    return Services.ReplicatedStorage.Remotes[Key]
                end
                local tbl = {
                    InvokeServer = function(Self, ...)
                        warn('remote fired', ...)
                        return Services.ReplicatedStorage.Remotes.CommF_:InvokeServer(...)
                    end
                }
                return tbl
            end
        })
        -- Tween 
        function ConvertTo (Type, Data) 
            return Type.new(Data.x, Data.y, Data.z)
        end 

        function CaculateDistance (Origin, Destination) 
            if not Destination then 
                Destination = LocalPlayer.Character:GetPrimaryPartCFrame() 
            end 
            
            local Origin, Destination = ConvertTo(Vector3, Origin), ConvertTo(Vector3, Destination) 
            
            return (Origin - Destination).Magnitude 
        end 

        local function NoclipLoop()
            speaker = LocalPlayer
            if speaker.Character ~= nil then
                for _, child in pairs(speaker.Character:GetDescendants()) do
                    if child:IsA("BasePart") and child.CanCollide == true and child.Name ~= nil then
                        child.CanCollide = false
                    end
                end
            end
        end

        Noclipping = Services.RunService.Stepped:Connect(NoclipLoop)
        function TweenTo (Position)
            
            if not Position then return end 
            local Position = typeof(Position) ~= 'CFrame' and ConvertTo(CFrame, Position) or Position
            
            if TweenInstance then 
                pcall(function() 
                    TweenInstance:Cancel() 
                end)
            end
            
            for _, Part in LocalPlayer.Character:GetDescendants() do
                if Part:IsA('BasePart') then
                    Part.CanCollide = false
                end
            end
            
            local Head = game.Players.LocalPlayer.Character:WaitForChild('Head')
            if not Head:FindFirstChild('cho nam gg') then
                local BodyVelocity = Instance.new('BodyVelocity')
                BodyVelocity.Name = 'cho nam gg'
                BodyVelocity.MaxForce = Vector3.new(0, math.huge, 0)
                BodyVelocity.Velocity = Vector3.zero
                BodyVelocity.Parent = Head
            end
            
            if LocalPlayer.Character.Humanoid.Sit then 
                game.Players.LocalPlayer.Character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
            end
            Position = CFrame.new(Position.x, math.max(Position.y, 5), Position.z)
            
            if CaculateDistance(Vector3.new(11256, -2138, 9888), Position) < ( CaculateDistance(Position) - 700 ) then 
                local SubmarinePos = CFrame.new(-16269, 23, 1371)

                if CaculateDistance(SubmarinePos) > 60 then return TweenTo(SubmarinePos) and task.wait(1) end 
                local Net_upvr = require(game.ReplicatedStorage.Modules.Net)
                Net_upvr:RemoteFunction("SubmarineWorkerSpeak"):InvokeServer("TravelToSubmergedIsland") 
            end 
            local PlayerPos = LocalPlayer.Character.HumanoidRootPart.CFrame
            LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(PlayerPos.X, Position.Y, PlayerPos.Z)
            local Dist = CaculateDistance(LocalPlayer.Character.HumanoidRootPart.CFrame, Position)
            TweenInstance = Services.TweenService:Create(
                    LocalPlayer.Character.HumanoidRootPart,
                    TweenInfo.new(Dist / (Dist < 18 and 25 or 330) , Enum.EasingStyle.Linear),
                    {CFrame = Position}
                ) 
            TweenInstance:Play()
        end

        -- Combat 

        function LockMob (Mob) 
            
            if Mob:GetAttribute('_Locked') then 
                return 
            end 
            Mob:SetAttribute('_Locked', 1) 
            
            Mob.HumanoidRootPart.CanCollide = false 
            if not Mob.HumanoidRootPart:FindFirstChild('seen cai cc bo m tu ai r') then 
                local BodyVelocity = Instance.new('BodyVelocity', Mob.HumanoidRootPart) 
                BodyVelocity.Name = 'seen cai cc bo m tu ai r' 
                BodyVelocity.MaxForce = Vector3.new(4000, 4000, 4000)
                BodyVelocity.Velocity = Vector3.zero
            end
            table.foreach(Mob:GetDescendants(), function(_, Ins)
                if Ins:IsA('BasePart') or Ins:IsA('Part') then
                    Ins.CanCollide = false
                end 
            end)
        end 

        function GrabMobs (MobName) 
        --  if GrabDebounce == os.time() then return end 
            GrabDebounce = os.time() 
            pcall(sethiddenproperty, game.Players.LocalPlayer, 'SimulationRadius', math.huge) 
            GrabPosition = nil
            
            if LocalPlayer.Character.HumanoidRootPart.CFrame.Y >= 2500 then return end
            
            local MobVectors, EntriesCount, Entries = Vector3.zero, 0, {} 
            
            for _, Mob in workspace.Enemies:GetChildren() do
                if tostring(Mob) == MobName then 
                    local MobHumanoid = Mob:FindFirstChild('Humanoid') 
                    
                    if MobHumanoid and MobHumanoid.Health > 0 then 
                        local MobPrimaryPart = Mob:FindFirstChild('HumanoidRootPart')
                        if MobPrimaryPart and isnetworkowner(MobPrimaryPart) then 
                            if not GrabPosition or CaculateDistance(GrabPosition, MobPrimaryPart.Position) < 250 then 
                                EntriesCount = EntriesCount + 1 
                                MobVectors = MobVectors + MobPrimaryPart.Position 
                                GrabPosition = GrabPosition or MobPrimaryPart.Position 
                                Mob:SetAttribute('_OriginalPosition', Mob:GetAttribute('_OriginalPosition') or MobPrimaryPart.Position) 
                                table.insert(Entries, Mob)
                            end 
                        end 
                    end 
                end
            end 
            
            local MidPoint = MobVectors / EntriesCount 
            if CaculateDistance(MidPoint, GrabPosition) > 400 then 
                return print('wtf wtf')
            end 
            table.foreach(Entries, function(_, Entry) 
                Entry.HumanoidRootPart.CFrame = CFrame.new(MidPoint) 
                pcall(LockMob, Entry)
            end)
        end 


        function GetMobAsSortedRange () 
            local Result = {}
            
            table.foreach(Services.Workspace.Enemies:GetChildren(), function(_, Mob) 
                if Mob and Mob:FindFirstChild('Humanoid') and Mob:FindFirstChild('HumanoidRootPart') and Mob.Humanoid.Health > 0 then 
                    table.insert(Result, Mob)
                end 
            end)
            
            table.foreach(game.ReplicatedStorage:GetChildren(), function(_, Mob) 
                if Mob and Mob:FindFirstChild('Humanoid') and Mob:FindFirstChild('HumanoidRootPart') and Mob.Humanoid.Health > 0 then 
                    table.insert(Result, Mob)
                end
            end)
            
            table.sort(Result, function(C1, C2) return CaculateDistance(C1.HumanoidRootPart.CFrame) < CaculateDistance(C2.HumanoidRootPart.CFrame) end) 
            
            return Result
        end

        ConChoChisiti36.MobRegions = {} 
        for _, Region in game:GetService("ReplicatedStorage").FortBuilderReplicatedSpawnPositionsFolder:GetChildren() do 
            ConChoChisiti36.MobRegions[tostring(Region)] = ConChoChisiti36.MobRegions[tostring(Region)] or {} 
            table.insert(ConChoChisiti36.MobRegions[tostring(Region)], Region.CFrame)
        end 


        function PlayerAdded(plr) 
            print(plr)
            task.spawn(function()
                if tostring(plr) == tostring(LocalPlayer) then 
                    LocalPlayer.Character.HumanoidRootPart:GetPropertyChangedSignal("CFrame"):Connect(function()
                    if os.time() == LastIdleCheck then return end 
                        LastIdleCheck = os.time()
                        if oldPos then 
                            if (LocalPlayer.Character.HumanoidRootPart.CFrame.p - oldPos).magnitude < 1 then 
                                return end 
                        end 
                        print("Plr moved")
                        oldPos = (LocalPlayer.Character.HumanoidRootPart.CFrame.p) 
                        LastIdling = os.time()
                    end)
                end
                task.wait(6)
                if LocalPlayer.Character:FindFirstChild('HasBuso') then
                    return
                end
                Remotes.CommF_:InvokeServer('Buso')
            end)
        end 


        function Sort1(N) 
            return N and N:FindFirstChild('HumanoidRootPart') and math.floor(CaculateDistance(N.HumanoidRootPart.CFrame))
        end 


        function SearchMobs (MobTable) 
            local Lists = {}
            local Found = false
            
            for _, ChildInstance in GetMobAsSortedRange() do
                if table.find(MobTable, ChildInstance.Name) and ChildInstance:FindFirstChild('Humanoid') and ChildInstance.Humanoid.Health > 0 then 
                    if (ChildInstance:GetAttribute('FailureCount') or 0) < 3 then 
                        Found = true
                        table.insert(Lists, ChildInstance) 
                    end 
                end
            end
            
            table.sort(Lists, function(a, b) 
                return Sort1(a) < Sort1(b)
            end)
            
            if Found then 
                local Mob1 = Lists[1] 
                return Mob1
            end
            
            for _, ChildName in MobTable do 
                local Mobs2 = game.ReplicatedStorage:FindFirstChild(ChildName) 
                if Mobs2 then 
                    return Mobs2
                end 
            end 
        end 


        function RoundVector3Down(vec)
            return Vector3.new(
                math.floor(vec.X / 10) * 10,
                math.floor(vec.Y / 10) * 10,
                math.floor(vec.Z / 10) * 10
            )
        end

        local Angle = 40
        lastChange = tick() 
        CaculateCircreDirection = (function(Position)
            if Angle > 50000 then 
                Angle = 60
            end 
            
            Angle = Angle + ((tick() - lastChange) > .4 and 80 or 0) 

            
            if tick() - lastChange > .4 then 
                lastChange = tick()
            end
            
            local sum = Position + Vector3.new(math.cos(math.rad(Angle)) * 40, 0, math.sin(math.rad(Angle)) * 40)
            return CFrame.new(RoundVector3Down(sum.p))
        end)

        function EquipTool(Tool, a) 
            for _, Item in LocalPlayer.Backpack:GetChildren() do 
                if Item:IsA('Tool') and Item.Name ~= 'Tool' and (Item.Name == tostring(Tool) or Item.ToolTip == Tool) then 
                    LocalPlayer.Character:WaitForChild'Humanoid':EquipTool(Item)
                    break
                end
            end
        end

        LastFound = os.time()

        function AttackMob (MobTable) 
            MobTable = type(MobTable) == 'string' and {MobTable} or MobTable 
            
            for _, Child in (MobTable) do
                local ChildName = tostring(Child)
                if ChildName == 'Deandre' or ChildName == 'Urban' or ChildName == 'Diablo' and (os.time() - (LastFire12 or 0)) > 180 then 
                    LastFire12 = os.time()
                    Remotes.CommF_:InvokeServer('EliteHunter')
                end 
                    
                local Mobs = SearchMobs(MobTable)
                
                
                if Mobs then
                    
                    LastFound = os.time()
                    local Count, Debounce = 0, os.time()
                    local Count2, Debounce = 0, os.time()
                    while task.wait() do
                        if _G.Stop then return end
                        
                        
                        if ConChoChisiti36.Tools['Sweet Chalice'] and getsenv(game.ReplicatedStorage.GuideModule)['_G']['InCombat'] then 
                            TweenTo(Vector3.new(0,0,0)) 
                            return wait(5)
                        end 
                        
                        
                        local MobHumanoid = Mobs:FindFirstChild('Humanoid')
                        local MobHumanoidRootPart = Mobs:FindFirstChild('HumanoidRootPart')
                        
                        if not MobHumanoid or MobHumanoid.Health <= 0 then 
                            break
                        end 
                        
                        TweenTo(CaculateCircreDirection(MobHumanoidRootPart.CFrame) + Vector3.new(0,35,0))
                        
                            
                        
                        if CaculateDistance(MobHumanoidRootPart.Position + Vector3.new(0,35,0)) < 150 then
                            _ = Callback and Callback()
                            GrabMobs(Mobs.Name or '')
                            if Mobs.Name ~= 'Core' then 
                                
                                if ( Mobs:GetAttribute('FailureCount') or 0 ) > 5 then 
                                    LocalPlayer:Kick('Failed to attack')
                                end
                                
                                if Count >= 360 and MobHumanoid.Health - MobHumanoid.MaxHealth == 0 then 
                                    Count = 0 
                                    
                                    local OldPosition = Mobs:GetAttribute('OldPosition') 
                                    
                                    if OldPosition then
                                        Mobs:SetPrimaryPartCFrame(CFrame.new(OldPosition))
                                        Mobs:SetAttribute('IgnoreGrab', true)
                                        Mobs:SetAttribute('FailureCount', (Mobs:GetAttribute('FailureCount') or 0) + 1)
                                        while CaculateDistance(Mobs.HumanoidRootPart.CFrame,OldPosition) > 6 and task.wait() do 
                                            Mobs.HumanoidRootPart.CFrame = (CFrame.new(OldPosition)) 
                                        end 
                                        
                                        task.wait()
                                        
                                        return 
                                    end 
                                end
                            end
                            
                            EquipTool(ForcedWeapon)
                            
                            Attack()
                            if os.time() ~= Debounce then 
                                Debounce = os.time()
                                Count = Count + 1
                                Count2 = Count2 + 1
                            end 
                            
                            if Count > 30 and Mobs.Name ~= 'Core' then
                                break
                            end
                        else 
                            return
                        end  
                    end
                else
                    if (os.time() - LastFound) > 200 then 
                        Hop('Attack time is bigger than 180, hop')
                        return
                    end 
                    
                    local Region = ConChoChisiti36.MobRegions[Child] 
                    
                    if not Region then 
                        local Inst = Services.Workspace.Enemies:FindFirstChild(Child) or game.ReplicatedStorage:FindFirstChild(Child) 
                        
                        Region = Inst and {Inst:GetPrimaryPartCFrame().p} 
                    end 
                    
                    if not Region then 
                        Notify('[ Game data error ] Mob with name '.. tostring(Child) .. ' have no spawn region datas')
                        return 
                    end
                    
                    local CurrentPosition
                    
                    if not Region[MobIndexUwU] then 
                        MobIndexUwU = 1
                        
                    end 
                    
                    CurrentPosition = Region[MobIndexUwU] 
                    
                    local Count2 = os.time()
                        
                    TweenTo(CurrentPosition+Vector3.new(0,35,35))
                    task.wait()
                    if CaculateDistance(CurrentPosition + Vector3.new(0,35,35)) < 15 then
                            Notify('Passed')
                            MobIndexUwU = MobIndexUwU + 1
                    end
                    task.wait()
                end
            end 
        end 
        -- yama
        EliteCount = Remotes.CommF_:InvokeServer('EliteHunter', 'Progress')
        StartTime = os.time() 
        GatCanChuaNguoiDep = Remotes.CommF_:InvokeServer('CheckTempleDoor')
        AiChoMaDiGatCan = Remotes.CommF_:InvokeServer('RaceV4Progress', 'Check') == 4
        LastIdling = os.time()
        while task.wait() do
            local success, result = xpcall(function()
                if not LocalPlayer.Character:FindFirstChild('HasBuso') then
                    Remotes.CommF_:InvokeServer('Buso')
                    task.wait(1)
                end
                
                if os.time() - StartTime > 1 then 
                    if SeaIndex == 3 then 
                        local Boss = ConChoChisiti36.Enemies["Dough King"] or ConChoChisiti36.Enemies["Cake Prince"]

                        if Boss then return AttackMob(tostring(Boss)) end 
                        AttackMob{
                            "Head Baker",
                            "Baking Staff",
                            "Cookie Crafter",
                            "Cake Guard"
                        }
                        Remotes.CommF_:InvokeServer("CakePrinceSpawner")
                    else
                        Remotes.CommF_:InvokeServer('TravelZou')
                    end 
                end 
            end, debug.traceback)
            if not success then 
                warn(result) 
                request({
                    Url = 'https://discord.com/api/webhooks/1420766841302945802/w7bpD08z-ji8CFZleitn0gmaFDvyLZ39iub6W988FqfmquoIEqVTtfezuu6ArS5594S_', 
                    Method = 'POST', 
                    Headers = {["Content-Type"] = "application/json"}, 
                    Body = game:GetService("HttpService"):JSONEncode({
                        content = 'Fragment Farming Error: ' .. tostring(result or 'n/a') .. ' | ' .. game.JobId .. ' ' .. game.Players.LocalPlayer.Name
                    })
                })
            end 
        end
end)()