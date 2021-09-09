--//-----------------------------------------------\\
--||   Project      : Lakeside Roleplay - MTA:SA
--||   Author       : Lorenzo(DorteY), Bonus & iLimix
--\\-----------------------------------------------//


local data={}

function setData(element,key,value,sendToElement)
	if(isElement(element)and type(key)=="string" and value~=nil)then
		if(not data[element])then
			data[element]={}
		end
		data[element][key]=value
		if(type(sendToElement)~="table" and type(sendToElement)~="userdata")then
			sendToElement=root
		end
		triggerClientEvent(sendToElement,"sync:data",element,key,value)
	else
		outputDebugString("setData wurde falsch benutzt! "..(isElement(player)and getElementType(player)=="player" and getPlayerName(player)or tostring(player)).."|"..tostring(key).."|"..tostring(value).."|"..tostring(debug.getinfo(2,"n").name))
		return false
	end
end

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

function removeData(element,key)
	if(isElement(element))then
		if(data[element] and data[element][key])then
			data[element][key]=nil
		end
		return true
	end
	return false
end

local function removeAllData(element)
	if(data[element])then
		data[element]=nil
	end
end

addEventHandler("onElementDestroy",root,function()
	removeAllData(source)
end)

addEventHandler("onPlayerQuit",root,function()
	setTimer(removeAllData,1*1200,1,source)
end)