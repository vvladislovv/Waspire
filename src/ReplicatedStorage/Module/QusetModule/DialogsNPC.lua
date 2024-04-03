local DialogsNPC = {}

DialogsNPC.QuesetDialog = {
    ["Bread"] = {
        Name = 'Bread',
        Icon = "rbxassetid://16312164831",
        NoQuset = {
            "Hello, My quest Stop",
            "Hello, My quest Stop2",
            "Hello, My quest Stop3",
            "Hello, My quest Stop4",
            "Hello, My quest Stop5"
        }, --! Если не стоят квесты или нет квестов 
        QusetTable = {
            [1] = {
                Icon = "rbxassetid://16312164831",
                NameQuset = "BreadOneQuest", -- ! название квеста
                QuestNameTask = "",
                Dialogs = { -- ! Тектс для диологов 
                    NewQuset = { -- ! Новый квест и новый диолог
                        QusetNPCDiologs1 = {
                            "Hello bro!",
                            "Hello bro1!",
                            "Hello bro2!",
                            "Hello bro13!",
                        },
                        PlayerDiologs = {
                            "Player Hello NPC",
                            "Player Hello NPC2",
                            "Player Hello NPC3",
                        },
                        QusetNPCDiologs2 = {
                            "Hello bro!2",
                            "Hello bro1!2",
                            "Hello bro2!2",
                            "Hello bro13!2",
                        },
                    },

                    OldQuset = { --! Старый квест и квест не выполнился 
                        QusetNPCDiologs1 = {
                            "TEsetr!",
                            "TEsetr2!",
                            "TEsetr3!",
                            "HTEsetr13!",
                        },
                        PlayerDiologs = {
                            "asdfasdfasdf",
                            "sdfgsdfhsdfh",
                            "sdfgsdfgsdfgsdfg",
                        },
                        QusetNPCDiologs2 = {
                            "sdfscvxcvbxcvbxcv",
                            "vvvvvvvvv",
                            "ccccccc",
                            "xxxxxxxxx",
                        },
                    },

                    Completed = { -- ! квесть выполнили
                        QusetNPCDiologs1 = {
                            "Completed!",
                            "Completed2!",
                            "Completed3!",
                            "Completed13!",
                        },
                        PlayerDiologs = {
                            "Completed",
                            "Completedf",
                            "Completedfff",
                        },
                        QusetNPCDiologs2 = {
                            "fddddddd",
                            "ssssss",
                            "aaaaaaaaaa",
                            "cccsssss",
                        },
                    }

                },

                Task = { -- ! Задание 
                    {
                        Type = "PollenColor",
                        NColor = "Red",
                        StartAmt = 0,
                        NeedAmt = 100,
                    },

                    {
                        Type = "FieldPollen", 
                        Field = "Daisy",
                        StartAmt = 0,
                        NeedAmt = 100,
                    },

                    {
                        Type = "TypeTokens",
						Item = "Caramel",
                        StartAmt = 0,
                        NeedAmt = 100,
                    },

                    {
                        Type = "TypeMobsKill",
						Item = "???",
                        StartAmt = 0,
                        NeedAmt = 100,
                    },

                    {
                        Type = "UseItem",
						Item = "Caramel",
                        StartAmt = 0,
                        NeedAmt = 100,
                    },

                    {
                        Type = "AnyTokens", 
                        StartAmt = 0,
                        NeedAmt = 100,
                    },
                    {
                        Type = "AnyPollen", 
                        StartAmt = 0,
                        NeedAmt = 100,
                    },

                    {
                        Type = "TypeTokens",
                        Token = "Strawberry",
                        StartAmt = 0,
                        NeedAmt = 100,
                    },
                },

                Rewards = { --! Награда за квесты 
                    {
                        Rewar = "BaseSettings",
                        Type = "Sneliki",
                        Amount = 1000
                    }
                }
            }
        }
    } 
}

return DialogsNPC