
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Remote = ReplicatedStorage:WaitForChild("Remote")
local Module = ReplicatedStorage:WaitForChild("Module")
local Utils = require(ReplicatedStorage.Libary.Utils)
local DataSave = require(script.Parent.Data)
local ItemsGame = require(Module.ItemsGame)

local TokenSystems = {}

function TokenSystems.SpawnToken(Info)
    local TokenModule = ItemsGame.TokenTables.TokenDrop[Info.Token.Item]
    local Token = ReplicatedStorage.Assert.Token:Clone()
	Token.Position = Info.Position + Vector3.new(0,2.75,0)
    Token.Type.Value = Info.Token.Type
    Token.Color = TokenModule.TKColor

    if Info.Token.Item ~= "Coin" then
        Token.BackDecal.Texture = ItemsGame.TokenTables.TokenDrop[Info.Token.Item].Image
        Token.FrontDecal.Texture = ItemsGame.TokenTables.TokenDrop[Info.Token.Item].Image
    else
        Token.BackDecal.Texture = ItemsGame.TokenTables.TokenDrop.Coin.Image
        Token.FrontDecal.Texture = ItemsGame.TokenTables.TokenDrop.Coin.Image
    end

    Token.Amount.Value = Info.Token.Amount
    Token.Item.Value = Info.Token.Item
    Token.Res.Value = Info.Resourse
    Token.Parent = workspace.TokenSpawn
   -- game.ReplicatedStorage.Remotes.ServerToken:Fire(Token)
    game.ReplicatedStorage.Remote.Token:FireAllClients(Token)
            
    Token.Touched:Connect(function(Hit)
        if game.Players:FindFirstChild(Hit.Parent.Name) then
            Token.CanTouch = false
                local Client = game.Players:FindFirstChild(Hit.Parent.Name)
                if Client then
                    task.spawn(function()
                        local PData = DataSave:Get(Client)
                        if Token:FindFirstChild("Type").Value == "Drop" then
                            if Token:FindFirstChild("Item").Value ~= "Coin" then
                                PData.Inventory[Token.Item.Value] += Token.Amount.Value
                               --[[ PData:Update('Inventory', PData.Inventory)                                Remote.AlertClient:FireClient(Client, {
                                    Color = "Blue",
                                    Msg = "+"..Utils:CommaNumber(Token.Amount.Value).." "..Token.Item.Value.." (from "..Token.Res.Value..")"
                                })]]
                            else
                                local AmountOfHoney = math.round(((Token.Amount.Value + math.random(100,500)) * PData.Boost.PlayerBoost["Honey From Tokens"] / 100))
                                PData.BaseSettings["Coin"] += AmountOfHoney
                                PData.TotalItems["CoinTotal"] += AmountOfHoney
                                PData.BaseSettings["DailyHoney"] += AmountOfHoney

                                --[[
                                    Remote.AlertClient:FireClient(Client, {
                                    Color = "Blue",
                                    Msg = "+"..Utils:CommaNumber(AmountOfHoney).." Honey",
                                })]]
                            end
                    elseif Token.Type.Value == "Boost" then
                        game.ReplicatedStorage:FindFirstChild("Remotes").Boost:Fire(Client, Token.Name, 1)
                    end
                   -- ServerQuestRoad(Client, PData, Token) -- Quest
                    task.wait(1)
                    Token:Destroy()
                end)
            end
        end
    end)
    task.spawn(function()
        task.wait(Info.Cooldown)
        task.wait(3)
        Token:Destroy()
    end)
end

return TokenSystems