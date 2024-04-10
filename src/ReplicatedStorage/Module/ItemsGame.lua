local ItemsGame = {}

ItemsGame.FoodGame = {
    ['Orange'] = {
        Texture = "",
        Description = "",
        Type = ""
    },

    ['Rock'] = {
        Texture = "",
        Description = "",
        Type = ""
    },

    ['Serk'] = {
        Texture = "",
        Description = "",
        Type = ""
    },
    ['Straberry'] = {
        Texture = "",
        Description = "",
        Type = ""
    },
    ['Send'] = {
        Texture = "",
        Description = "",
        Type = ""
    },
    ['Flower'] = {
        Texture = "",
        Description = "",
        Type = ""
    },

    ['Gold Egg'] = {
        Texture = "",
        Description = "",
        Type = ""
    },
}

ItemsGame.Equipment = {
    Tool = {
        ['Scissors'] = {
            Name = "Scissors",
            SpeedCoper = 0.75,
            Collecting = 3,
            Coouldown = 0.2,
            PowerTools = 1, -- копание размер
            BlockFieldCoper = "2x1",
            Stamp = "ScissModel",
            Color = "None",
            AnimTools = "rbxassetid://522635514"
        },

        ['loler'] = {
            Name = "loler",
            Collecting = 3,
            SpeedCoper = 0.75,
            Coouldown = 0.2,
            PowerTools = 0.3,
            BlockFieldCoper = "2x1",
            Stamps = "lolerModel",
            Color = "None",
            AnimTools = "rbxassetid://522635514"
        },
    },
}

ItemsGame.TokenTables = {
    TokenDrop = {
        ["Coin"] = {
			TKColor = Color3.fromRGB(240, 208, 92),
			Image = "http://www.roblox.com/asset/?id=10315383929",
		},
        ["Basic Egg"] = {
			TKColor = Color3.fromRGB(240, 208, 92),
			Image = "",
		},
        ["Gold Egg"] = {
			TKColor = Color3.fromRGB(240, 208, 92),
			Image = "",
		},
        ["Dimoind Egg"] = {
			TKColor = Color3.fromRGB(240, 208, 92),
			Image = "",
		},
        ["Event Egg"] = {
			TKColor = Color3.fromRGB(240, 208, 92),
			Image = "",
		},
        ["Strawberry"] = {
			TKColor = Color3.fromRGB(197, 197, 197),
			Image = "",
		},
        ["Leaf"] = {
			TKColor = Color3.fromRGB(197, 197, 197),
			Image = "",
		},
        ["Seed"] = {
			TKColor = Color3.fromRGB(197, 197, 197),
			Image = "",
		},
        ["Blueberry"] = {
			TKColor = Color3.fromRGB(197, 197, 197),
			Image = "",
		},
    },
}

ItemsGame.FieldsDrop = {
    ["Daisies"] = {
        ['Coin'] = {Name = "Coin", Rarity = 15, APT = 1}
    },
    ["Blue flowers"] = {
        ['Coin'] = {Name = "Coin", Rarity = 15, APT = 1}
    },
    ["Mushrooms"] = {
        ['Coin'] = {Name = "Coin", Rarity = 15, APT = 1}
    },
    ["Cave2"] = {
        ['Coin'] = {Name = "Coin", Rarity = 15, APT = 1}
    },
    ["Cave1"] = {
        ['Coin'] = {Name = "Coin", Rarity = 15, APT = 1}
    }
}

ItemsGame.Monster = {
    ['BagsBlue'] = {
        Field = "Mushrooms",
        Level = 1,
        HP = 25,
        SettingsMobs = {
            Speed = 15,
            Damage = 15,
            Dist = 50,
            Cooldown = 300
        },

        Reward = {
            ['Coin'] = {
                Amt = 50, -- Умножать
                Chance = 1000,
                Type = "BaseSettings"
            },
            ['Mushrooms'] = {
                Amt = 1,
                Chance = 100,
                Type = "Inventory"
            },
            ['Basic Egg'] = {
                Amt = 1,
                Chance = 1000000,
                Type = "Inventory"
            },
            ['Battle Points'] = {
                Amt = 5, -- Умножать
                Chance = 1000,
                Type = "BaseSettings"
            },

        }
    }
}

return ItemsGame