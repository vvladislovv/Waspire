local ItemsShop = {}

ItemsShop.StartShop = {
    ['Product1'] = {
        Name = "Scissors",
        Cost = 0,
        ShopType = "ShopMiniButton",
        Type = "Tool",
        Description = "///",
        OrderShop = 1
        
    },
    ['Product2'] = {
        Name = "Saber",
        Cost = 1200,
        ShopType = "ShopMiniButton",
        Type = "Tool",
        Description = "///",
        OrderShop = 2
        
    },
    ['Product3'] = {
        Name = "Villas",
        Cost = 5000,
        ShopType = "ShopMiniButton",
        Type = "Tool",
        Description = "///",
        OrderShop = 3,
        Ingredients = {}
      
    },
    ['Product4'] = {
        Name = "Hook",
        Cost = 10000,
        ShopType = "ShopMiniButton",
        Type = "Tool",
        Description = "///",
        OrderShop = 4,
        Ingredients = {}
    },

    ['Product5'] = {
        Name = "Basic Hat",
        Cost = 25000,
        ShopType = "ShopMiniButton",
        Type = "Hat",
        Description = "///",
        OrderShop = 5,
        Ingredients = {}
    },

    ['Product6'] = {
        Name = "Basic Boots",
        Cost = 15000,
        ShopType = "ShopMiniButton",
        Type = "Boot",
        Description = "///",
        OrderShop = 6,
        Ingredients = {}
    },   
    
    ['Product7'] = {
        Name = "Basic Belt",
        Cost = 17500,
        ShopType = "ShopMiniButton",
        Type = "Belt",
        Description = "///",
        OrderShop = 7,
        Ingredients = {}
    },  
    ['Product8'] = {
        Name = "Testtube",
        Cost = 4500,
        Capacity = 2500,
        ShopType = "ShopMiniButton",
        Type = "Bag",
        Description = "///",
        OrderShop = 9,
        Ingredients = {}
    },
    ['Product9'] = {
        Name = "Hiking Backpack",
        Cost = 12000,
        Capacity = 5000,
        ShopType = "ShopMiniButton",
        Type = "Bag",
        Description = "///",
        OrderShop = 8,
        Ingredients = {}
    },
    ['Product10'] = {
        Name = "Bag",
        Cost = 1500,
        Capacity = 1000,
        ShopType = "ShopMiniButton",
        Type = "Bag",
        Description = "///",
        OrderShop = 10
    },
    ['Product11'] = {
        Name = "Backpack",
        Cost = 0,
        Capacity = 150,
        ShopType = "ShopMiniButton",
        Type = "Bag",
        Description = "///",
        OrderShop = 11
    },

}


ItemsShop.EggShop = {
    ['Product1'] = {
        Name = "Wasp Cocoon",
        Cost = 550,
        ShopType = "ShopСocoon",
        Type = "Inventory",
        Description = "///",
        OrderShop = 1
        
    },
}


return ItemsShop