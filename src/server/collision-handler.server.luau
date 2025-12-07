local CollectionService = game:GetService("CollectionService")
local PhysicsService = game:GetService("PhysicsService")

function setCollisionGroup(instance: BasePart | Model, collisionGroup: string)
    if instance:IsA("BasePart") then
        instance.CollisionGroup = collisionGroup
    else
        for _, descendant : Instance in instance:GetDescendants() do
            if descendant:IsA("BasePart") then
                descendant.CollisionGroup = collisionGroup
            end
        end
    end
end

function markCollisionGroupByTag(tag: string, collisionGroup: string)
    for _, instance : BasePart | Model in CollectionService:GetTagged(tag) do
        task.spawn(setCollisionGroup, instance, collisionGroup)
    end

    CollectionService:GetInstanceAddedSignal(tag):Connect(function(instance: BasePart | Model) setCollisionGroup(instance, collisionGroup) end)
end

PhysicsService:RegisterCollisionGroup("ConveyorElement")
PhysicsService:RegisterCollisionGroup("Player")

PhysicsService:CollisionGroupSetCollidable("ConveyorElement", "ConveyorElement", false)
PhysicsService:CollisionGroupSetCollidable("Player", "ConveyorElement", false)
PhysicsService:CollisionGroupSetCollidable("Player", "Player", false)

markCollisionGroupByTag("ConveyorElement", "ConveyorElement")
markCollisionGroupByTag("PlayerCharacter", "Player")