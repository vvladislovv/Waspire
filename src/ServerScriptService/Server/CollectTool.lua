-- надо дописать хрень которая отвечает за вывод цифр на экран
local TablePlayerFlower = {}

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TW = game:GetService("TweenService")
local FieldGame = require(game.ServerScriptService.Server.FieldGenerator)
local DataSave = require(game.ServerScriptService.Server.Data)
local Item = require(ReplicatedStorage.Module.ItemsGame)
local Remote = ReplicatedStorage:WaitForChild('Remote')

local StampsWorksSpawn = workspace.StampsWorksSpawn
--print(TablePlayerFlower)
--PData = game.ReplicatedStorage.Remotes.GetDataSave:InvokeServer()

local moduleFlower = {}

game.Players.PlayerRemoving:Connect(function(plr)
    TablePlayerFlower[plr.Name] = nil
end)

game.Players.PlayerAdded:Connect(function(plr)
    TablePlayerFlower[plr.Name] = {White = 0, Blue = 0, Coin = 0,  Pupler = 0}
end)

Remote.CollectField.OnServerEvent:Connect(function(Player, PData, Flower, Position, StatsMOD, Stamp)
    if Flower and PData and (Flower.Position.Y - FieldGame.Flowers[Flower.FlowerID.Value].MinP) > 0.2 then
        local CanScoop = true

        if PData.BaseSettings.Pollen <= PData.BaseSettings.Capacity and CanScoop == true then
            local Type = PData.Equipment.Tool
            local Crit = false
            local FColor = FieldGame.Flowers[Flower.FlowerID.Value].Color
            local FSize = FieldGame.Flowers[Flower.FlowerID.Value].Stat.Value
            local SS, DecAm, FoodAm

            local Percent = math.round(PData.Boost.PlayerBoost[FColor.." Instant"] + PData.Boost.PlayerBoost["Instant"])
            if Percent > 100 then
                Percent = 100
            end
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
                print(StatsMOD["Color"])
                if StatsMOD["Color"] == "Pupler" then

                    if FColor == "Pupler" then
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
                    elseif FColor == "Pupler" then
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
                    elseif FColor == "Pupler" then
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

            if FoodAm ~= nil and Percent ~= nil then -- Percent ~= nil
                local Convert = math.round(FoodAm * (Percent / 100)) -- 
                local PollenAdd = math.round(FoodAm - Convert)

                local CritRandom = math.random(1,100)
					if CritRandom <= PData.Boost.PlayerBoost["Critical Chance"] then
						--Crit = true
						PollenAdd = math.round(PollenAdd * (PData.Boost.PlayerBoost["Critical Power"] / 100))
					end

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
                        for i,v in pairs(TablePlayerFlower[Player.Name]) do
                                if v > 0 then
                                    print(TablePlayerFlower)
                                   Remote.VisualNumber:FireClient(Player, {Pos = Stamp, Amt = v, Color = i, Crit = Crit})
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

                --PData.TotalItems["Total"..FColor] += math.round(PollenAdd) 
                --task.wait(0.1)
                --PData:Update('BaseSettings', PData.BaseSettings)
            end
        else
            PData.BaseSettings.Pollen = PData.BaseSettings.Capacity
            --PData:Update('BaseSettings', PData.BaseSettings)
        end
    end
end)

return moduleFlower