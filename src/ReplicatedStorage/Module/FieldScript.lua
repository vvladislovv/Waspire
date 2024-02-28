local Remote = game.ReplicatedStorage:WaitForChild('Remote')
local FieldFolder =  game.Workspace:WaitForChild('FieldFolder')


local View
function constructor(view)
    View = view
end

function FlowerSpawnField() --* Спавн Цветка в поле
    
end

function UpdateFieldFlower() -- * Обновление цветка в размере
    
end

function GenerationFied() -- * Генерациия цветка 
    
end


return {
    constructor = constructor,
    FlowerSpawnField = FlowerSpawnField
}