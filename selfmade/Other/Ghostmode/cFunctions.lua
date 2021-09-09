--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

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