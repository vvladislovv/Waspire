-- где то тут ошибка, надо разобраться
local TablePlayerFlower = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TW = game:GetService("TweenService")

local FieldGame = require(game.ServerScriptService.Server.FieldGenerator)
local DataSave = require(game.ServerScriptService.Server.Data)
local Item = require(ReplicatedStorage.Module.ItemsGame)
local Remote = ReplicatedStorage:WaitForChild('Remote')

local StampsWorksSpawn = workspace.StampsWorksSpawn
local VEP  = Remote:WaitForChild("VisualEventPollen")
--print(TablePlayerFlower)
--PData = game.ReplicatedStorage.Remotes.GetDataSave:InvokeServer()

local moduleFlower = {}

	game.Players.PlayerRemoving:Connect(function(plr)
		TablePlayerFlower[plr.Name] = nil
	end)

    game.Players.PlayerAdded:Connect(function(plr)
        TablePlayerFlower[plr.Name] = {White = 0, Blue = 0,  Pupler = 0}
    end)
    Remote.CollectField.OnServerEvent:Connect(function(Player, PData, Flower, Position, StatsMOD, Stamp)
        print('fff')
    if Flower and PData and (Flower.Position.Y - FieldGame.Flowers[Flower.FlowerID.Value].MinP) > 0.2 then
        local CanScoop = true

        if PData.BaseSettings.Pollen < PData.BaseSettings.Capacity and CanScoop == true then
            local Type = PData.Equipment.Tool
            local Crit = false
            local FColor = FieldGame.Flowers[Flower.FlowerID.Value].Color
            local FSize = FieldGame.Flowers[Flower.FlowerID.Value].Stat.Value
            local SS, DecAm, FoodAm
            --[[
            local Percent = math.round(PData.Boost.PlayerBoost[FColor.." Instant"] + PData.Boost.PlayerBoost["Instant"])
            if Percent > 100 then
                Percent = 100
            end]]
            if not StatsMOD then
                DecAm = Item.Equipment.Tool[Type].PowerTools
                SS = Item.Equipment.Tool[Type].Collecting

                DecAm /= tonumber(FSize)
                SS /= math.round(SS * tonumber(FSize))
                
                if Item.Equipment.Tool[Type].Color == FColor then -- Color * in Tools Сбор умножение 
                    DecAm *= Item.Equipment.Tool[Type].BlockFieldCoper
                    SS *= Item.Equipment.Tool[Type].BlockFieldCoper
                end
                FoodAm = math.round(SS * ((PData.Boost.PlayerBoost["Pollen"] / 100) * (PData.Boost.PlayerBoost[FColor.." Pollen"] / 100) * (PData.Boost.PlayerBoost["Pollen From Collectors"] / 100)))
            else
                
                if StatsMOD["Color"] == "Red" then

                    if FColor == "Red" then
                        DecAm *= 1.5
                        SS *= 1.5
                    elseif FColor == "Blue" then
                        DecAm /= 1.5
                        SS /= 1.5
                    elseif FColor == "White" then
                        DecAm /= 1.5
                        SS /= 1.5
                    end
                    
                elseif StatsMOD["Color"] == "Blue" then

                    if FColor == "Blue" then
                        DecAm *= 1.5
                        SS *= 1.5
                    elseif FColor == "Red" then
                        DecAm /= 1.5
                        SS /= 1.5
                    elseif FColor == "White" then
                        DecAm /= 1.5
                        SS /= 1.5
                    end
                
                elseif StatsMOD["Color"] == "White" then

                    if FColor == "White" then
                        DecAm *= 1.5
                        SS *= 1.5
                    elseif FColor == "Red" then
                        DecAm /= 1.5
                        SS /= 1.5
                    elseif FColor == "Blue" then
                        DecAm /= 1.5
                        SS /= 1.5
                    end
                end
            end

            Remote.FlowerDown:FireAllClients(Flower,DecAm)
            
            local CoinAdd = 0

            if FoodAm ~= nil then -- Percent ~= nil
                local Convert = math.round(FoodAm) -- (Percent / 100)
                local PollenAdd = math.round(FoodAm - Convert)
                
                if PollenAdd < 0 then
                    PollenAdd = 0
                elseif Convert < 0 then
                    Convert = 0
                end

                CoinAdd += Convert

                if TablePlayerFlower[Player.Name] ~= nil then
                    TablePlayerFlower[Player.Name][FColor] += PollenAdd
                    TablePlayerFlower[Player.Name].Coin += CoinAdd
                end

                task.spawn(function()
                    task.wait()
                    if TablePlayerFlower[Player.Name] ~= nil then
                        for i,v in pairs(ReplicatedStorage(TablePlayerFlower[Player.Name])) do
                                if v > 0 then
                                    --VEP:FireClient(Player, {Pos = Stamp, Amt = v, Color = i, Crit = Crit})
                                end
                            end

                            TablePlayerFlower[Player.Name].Coin = 0
                            TablePlayerFlower[Player.Name].Blue = 0
                            TablePlayerFlower[Player.Name].Red = 0
                            TablePlayerFlower[Player.Name].White = 0
                    end
                end)

                PData.BaseSettings.Pollen += math.round(PollenAdd)
                PData.BaseSettings.Coin += math.round(CoinAdd)
                PData.TotalItems.CoinTotal += math.round(CoinAdd)
                PData.TotalItems.PollenTotal += math.round(PollenAdd)

                --PData.TotalItems["Total"..FColor] += math.round(PollenAdd) -- ! Дописать надо

                PData:Update('BaseSettings', PData.BaseSettings)
            end
        else
            PData.BaseSettings.Pollen = PData.BaseSettings.Capacity
            --PData:Update('BaseSettings', PData.BaseSettings)
        end
    end
end)

function moduleFlower:RegenUp(Field : Instance)
    local InfoFieldGame = FieldGame[Field.Name]
    for _, Pollen in pairs(Field:GetChildren()) do
        if Pollen:IsA("BasePart") then
            InfoFieldGame = FieldGame.Flowers[Pollen.FlowerID.Value]
            Pollen.Changed:Connect(function()
                print(Pollen)
                Remote.PollenEffect:FireAllClients(Pollen)
            end)
        end
    end

    if InfoFieldGame then
        task.spawn(function()
            while Field do task.wait(5)
                for i, Pollen in pairs(Field:GetChildren()) do
                    if Pollen:IsA("BasePart") then
                    InfoFieldGame = FieldGame.Flowers[Pollen.FlowerID.Value]
                        --[[
                        if Pollen.Position.Y <= InfoFieldGame.MinP then
                            --moduleFlower.DownFlower()
                                Pollen.Position = Vector3.new(Pollen.Position.X, InfoFieldGame.MinP, Pollen.Position.Z)
                        end]]

                        if Pollen.Position.Y < InfoFieldGame.MaxP then
                            local ToMaxFlower = tonumber(InfoFieldGame.MaxP - Pollen.Position.Y)
                            local FlowerPos = Pollen.Position + Vector3.new(0, ToMaxFlower, 0)
                            local FlowerPosTime = Pollen.Position + Vector3.new(0,InfoFieldGame.RegenFlower,0)

                            if ToMaxFlower <= InfoFieldGame.RegenFlower then
                                Remote.RegenPollen:FireAllClients(Pollen,FlowerPos)
                                --TW:Create(Pollen, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = FlowerPos}):Play()
                            else
                                Remote.RegenPollen2:FireAllClients(Pollen,FlowerPosTime)
                               --TW:Create(Pollen, TweenInfo.new(5, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out), {Position = FlowerPosTime}):Play()
                            end
                        end
                    end 
                end
            end
        end)
    end

end


task.wait(0.1)
for i, v in pairs(workspace.FieldsGame:GetChildren()) do
    moduleFlower:RegenUp(v)
end



return moduleFlower