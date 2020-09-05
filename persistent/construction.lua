if not Utils:IsInGameState() then
    do return end
end

if not Utils:IsInHeist() then
    do return end
end

if not UT.checkTable(UT.Construction.clipboard) then
    do return end
end

if not alive(UT.Construction.clipboard.unit) then
    do return end
end

if UT.Construction.clipboard.synchronized then
    Application:draw(UT.Construction.clipboard.unit, 0, 1, 0)
else
    Application:draw(UT.Construction.clipboard.unit, 1, 0.5, 0)
end