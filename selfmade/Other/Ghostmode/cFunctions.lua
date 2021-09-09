local collis={}
local function toggleGhostModeClient(element,bool)
	collis[element]=bool
	local allPlayers=getElementsByType("player",root,false)
	for _,v in pairs(allPlayers)do
		if(type(collis[v])~="boolean" or collis[v]==true or collis[v]==false and bool==false)then
			setElementCollidableWith(element,v,bool)
		end
	end
	
	local allVehicles=getElementsByType("vehicle",root,false)
	for _,v in pairs(allVehicles)do
		if(type(collis[v])~="boolean" or collis[v]==true or collis[v]==false and bool==false)then
			setElementCollidableWith(element,v,bool)
		end
	end
end
addEvent("toggleGhostModeClient",true)
addEventHandler("toggleGhostModeClient",root,toggleGhostModeClient)



--//
--[[
function ambulanceStreamIn ()
    if getElementType(source) == "vehicle" then
        local vehicleModel = {getElementModel(source)};
        local name = getVehicleNameFromModel (unpack(vehicleModel));
        if (name == "Ambulance") then
            outputChatBox("Vehicle streamed in: " .. tostring(name));
            for i,v in pairs(getElementsByType("vehicle")) do
                setElementCollidableWith(v, source, false)
            end
            for i,pl in pairs(getElementsByType("player")) do
                setElementCollidableWith(pl, source, false)
            end
            for i,pe in pairs(getElementsByType("ped")) do
                setElementCollidableWith(pe, source, false)
            end
                setElementAlpha (source, 150)
        end
    end
end
addEventHandler( "onClientElementStreamIn", getRootElement(), ambulanceStreamIn )

]]