--//Level
function uLevel(player,typ)
	if(isLoggedin(player))then
		if(tonumber(getData(player,"Level"))<=44)then
			if(tonumber(getData(player,"EXP"))>=Server.LevelEXP[tonumber(getData(player,"Level"))])then
				setData(player,"Level",tonumber(getData(player,"Level"))+1)
				setData(player,"EXP",tonumber(0))
				outputChatBox("Congratulations, you have reached level "..tonumber(getData(player,"Level")).."!",player,255,255,255)
			end
		end
	end
end

--//Premium
local PremiumInfo={}

function checkPremiumStatus(player)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Time","premiumtime","Username",getPlayerName(player)),-1)
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["Time"]~=0 and result[i]["Time"]-getSecTime(0)<=0)then
				setData(player,"Premium",0)
				outputChatBox(getLanguageWord(player,"Server","Premium","TEXT_PremiumExpired"),player,200,0,0)
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","premiumtime","Username",getPlayerName(player))
			else
				if(PremiumInfo[player]~=true)then
					PremiumInfo[player]=true
					setData(player,"Premium",1)
					local var=math.floor(((result[i]["Time"]-getSecTime(0))/60)*100)/100
					if(var>=0)then
						outputChatBox(getLanguageWord(player,"Server","Premium","TEXT_Premiumstate").." '"..math.floor(var).."' "..getLanguageWord(player,"Server","General","TEXT_Hours"),player,0,200,0)
					end
				end
			end
		end
	end
end

function buyPremium(player,typ)
	if(not(isPremium(player)))then
		if(typ=="7days")then
			if(tonumber(getData(player,"Coins"))>=7500)then
				dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Time) VALUES ('"..getPlayerName(player).."','"..getSecTime(168).."')","premiumtime")
				setData(player,"Premium",1)
				triggerClientEvent(player,"Draw->Infobox->UI",root,"Success","Information","You bought 'Premium for 7 days'.")
				checkPremiumStatus(player)
				takePlayerValue(player,"Coins",7500)
			else
				triggerClientEvent(player,"Draw->Infobox->UI",root,"Error","Error",getLanguageWord(player,"Server","General","TEXT_NotEnoughCoins".." (x7500)"))
			end
		elseif(typ=="14days")then
			if(tonumber(getData(player,"Coins"))>=13500)then
				dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Time) VALUES ('"..getPlayerName(player).."','"..getSecTime(336).."')","premiumtime")
				setData(player,"Premium",1)
				triggerClientEvent(player,"Draw->Infobox->UI",root,"Success","Information","You bought 'Premium for 14 days'.")
				checkPremiumStatus(player)
				takePlayerValue(player,"Coins",13500)
			else
				triggerClientEvent(player,"Draw->Infobox->UI",root,"Error","Error",getLanguageWord(player,"Server","General","TEXT_NotEnoughCoins".." (x13500)"))
			end
		end
	else
		triggerClientEvent(player,"Draw->Infobox->UI",root,"Warning","Information",getLanguageWord(player,"Server","Premium","TEXT_AlreadyPremium"))
	end
end

--//Click funcs
addEventHandler("onPlayerClick",root,function(btn,state,elem)
	if(not isLoggedin(source))then
		return
	end
	if(isPedDead(source))then
		return
	end
	if(state=="down" and btn=="left")then
		if(elem and isElement(elem))then
			if(isClickedState(source)==false)then
				local x,y,z=getElementPosition(source)
				local ox,oy,oz=getElementPosition(elem)
				local model=getElementModel(elem)
				if(getElementDimension(source)==getElementDimension(elem))then
					if(getElementType(elem)=="object")then
						if(model==2969 and getElementData(elem,"Element->Type->Lootbox")==true)then
							outputChatBox("Debug: #1",source)
							if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=4)then
							outputChatBox("Debug: #2",source)
								setElementData(source,"Element->Clicked->Type",tonumber(getElementData(elem,"Loot->ID")))
								loadLootItems(source)
							end
						elseif(model==1271 and getElementData(elem,"Element->Type->Itemdepot")==true)then
							outputChatBox("Debug: #1",source)
							if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=4)then
							outputChatBox("Debug: #2",source)
								setElementData(source,"Element->Clicked->Type",tonumber(getElementData(elem,"Itemdepot->ID")))
								loadItemdepotItems(source)
							end
						end
					elseif(getElementType(elem)=="ped")then
						if(getDistanceBetweenPoints3D(ox,oy,oz,x,y,z)<=3.5)then
							if(getElementData(elem,"Ped->Shop->Weapon")==true)then
								triggerClientEvent(source,"Create->Weaponshop->UI",source)
							end
						end
					end
				end
			end
		end
	end
end)


--//Savezone
local Savezones={
	{1137.9,-1396,55,104},--LS Hospital
	{-2745.3,573.4,213,130},--SF Hospital
	{-2001.1,78.3,85,140},--SF BHF
}

function createSavezones()
	for _,v in pairs(Savezones)do
		local savezoneArea=createColRectangle(v[1],v[2],v[3],v[4])
		createRadarArea(v[1],v[2],v[3],v[4],0,255,0,100,root)
		
		addEventHandler("onColShapeHit",savezoneArea,function(hitElement)
			setData(hitElement,"Savezone",1)
			triggerClientEvent(hitElement,"Create->Savezone->UI",hitElement)
			if(getElementData(hitElement,"zombie")and getElementData(hitElement,"zombie")==true)then
				killPed(hitElement)
			end
		end)
		
		addEventHandler("onColShapeLeave",savezoneArea,function(hitElement)
			setData(hitElement,"Savezone",0)
			triggerClientEvent(hitElement,"Destroy->Savezone->UI",hitElement)
		end)
	end
end
addEventHandler("onResourceStart",resourceRoot,createSavezones)

local Warningzones={
	{81.1,1774.2,320,320},--Area
	{-1127.5,-759.5,160,180},--SF Fabrik
}

function createWarningZones()
	for _,v in pairs(Warningzones)do
		createRadarArea(v[1],v[2],v[3],v[4],255,0,0,100,root)
	end
end
addEventHandler("onResourceStart",resourceRoot,createWarningZones)

--//Other funcs
addCommandHandler("language",function(player,cmd,typ)
	if(isLoggedin(player))then
		if(typ)then
			if(typ=="German")then
				setElementData(player,"language",tonumber(0))
				triggerClientEvent(player,"Draw->Infobox->UI",player,"Info","Information","Sprache: Deutsch!")
			elseif(typ=="English")then
				setElementData(player,"language",tonumber(1))
				triggerClientEvent(player,"Draw->Infobox->UI",player,"Info","Information","Language: English!")
			end
		end
	end
end)


addEvent("Change->Settings",true)
addEventHandler("Change->Settings",root,function(typ,amount)
	if(typ=="RenderWorld")then
		setData(client,"RenderdistanceWorld",tonumber(amount))
		outputChatBox("Your World Renderdistance now: "..amount,client)
	elseif(typ=="RenderCustom")then
		setData(client,"RenderdistanceCustom",tonumber(amount))
		outputChatBox("Your Custom Object Renderdistance now: "..amount,client)
	elseif(typ=="Hitglocke")then
		setData(client,"Hitglocke",tonumber(amount))
		if(tonumber(getData(client,"Hitglocke"))~=4)then
			outputChatBox("Your Hitbell now: "..amount,client)
		else
			outputChatBox("Your Hitbell now: Off",client)
		end
	end
end)

addCommandHandler("afk",function(player,cmd,number)
	if(getData(player,"AFK")==true)then
		if(AFKPlayerTable[player])then
			if(number)then
				if(tonumber(number)==AFKPlayerTable[player])then
					setData(player,"AFK",false)
					setElementFrozen(player,false)
					triggerClientEvent(player,"Draw->Infobox->UI",root,"Info","Information",getLanguageWord(player,"Server","General","TEXT_AFKLeft"))
					if(isPedInVehicle(player))then
						setElementFrozen(getPedOccupiedVehicle(player),false)
					end
					AFKPlayerTable[player]=nil
				end
			end
		end
	end
end)







