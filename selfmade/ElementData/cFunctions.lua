--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702 & Bonus             ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //


local data={}

addEvent("sync:data",true)
addEventHandler("sync:data",root,function(key,value)
	if(not data[source])then
		data[source]={}
	end
	data[source][key]=value
end)

function getData(element,key)
	if(isElement(element)and type(key)=="string")then
		if(data[element] and data[element][key])then
			return data[element][key]
		end
	else
		outputDebugString("getData wurde falsch benutzt! "..(isElement(player)and getElementType(player)=="player" and getPlayerName(player)or tostring(player)).."|"..tostring(key).."|"..tostring(debug.getinfo(2,"n").name))
	end
	return false
end