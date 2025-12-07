for _, Descendant : ModuleScript in script:GetDescendants() do
    if Descendant:IsA("ModuleScript") then require(Descendant) end
end