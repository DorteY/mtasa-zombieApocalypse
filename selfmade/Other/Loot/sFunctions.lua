--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local LootItemTable={}

local ItemList={
	{"Coins"},
	{"Pastacan"},
	{"Ravioli"},
	{"Cola"},
	{"Pepsi"},
	{"Fuelcan"},
}
function refreshLootItems(player)
	LootItemTable={}
	
	for _,v in pairs(ItemList)do
		if(getElementData(Loot[getElementData(player,"Element->Clicked->Type")],"Loot->Item->"..tostring(v[1])))then
			table.insert(LootItemTable,{v[1],getElementData(Loot[getElementData(player,"Element->Clicked->Type")],"Loot->Item->"..tostring(v[1]))})
		end
	end
end

function loadLootItems(player)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","lootpositions","ID",getElementData(player,"Element->Clicked->Type")),-1)
	if(result or result[1])then
		refreshLootItems(player)
		
		triggerClientEvent(player,"Create->Loot->UI",player,LootItemTable)
		triggerClientEvent(player,"Refresh->Loot->UI",player,LootItemTable)
	end
end

addEvent("Take->Loot->Item",true)
addEventHandler("Take->Loot->Item",root,function(typ,amount)
	if(isElement(Loot[getElementData(client,"Element->Clicked->Type")]))then
		if(typ and typ~=nil)then
			if(getElementData(Loot[getElementData(client,"Element->Clicked->Type")],"Loot->Item->"..typ)>=amount)then
				setElementData(Loot[getElementData(client,"Element->Clicked->Type")],"Loot->Item->"..typ,getElementData(Loot[getElementData(client,"Element->Clicked->Type")],"Loot->Item->"..typ)-amount)
				addPlayerValue(typ,amount)
			else
				triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_NotEnoughItems_Lootbox"))
			end
			refreshLootItems(client)
			triggerClientEvent(client,"Refresh->Loot->UI",client,LootItemTable)
		end
	end
end)


--//Itemdepots
local DestroyTimerTable={}

function loadItemdepotItems(player)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","itemdepots","ID",getElementData(player,"Element->Clicked->Type")),-1)
	if(result or result[1])then
		coins=result[1]["Coins"]
		
		triggerClientEvent(player,"Create->Itemdepot->UI",player,coins)
	end
end

addEvent("Take-Putin->Loot->Item",true)
addEventHandler("Take-Putin->Loot->Item",root,function(typ,item,amount)
	local clicked=getElementData(client,"Element->Clicked->Type")
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","itemdepots","ID",clicked),-1)
	if(result or result[1])then
		if(item and item~=nil)then
			if(typ)then
				if(typ=="in")then
					if(item=="Coins")then
						if(tonumber(result[1][item])+amount<=tonumber(2000))then
							if(getPlayerValue(client,item)>=tonumber(amount))then
								takePlayerValue(client,item,amount)
								dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","itemdepots",item,tonumber(result[1][item])+amount,"ID",clicked)
							else
								--triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough "..item.."! (x"..amount.."")
							end
						else
							--triggerClientEvent(client,"draw:infobox",root,"error","There can not be more than x1000 "..item.." in stock!")
						end
					elseif(item~="Coins")then
						if(tonumber(result[1][item])+amount<=tonumber(50))then
							if(getPlayerValue(client,item)>=tonumber(amount))then
								takePlayerValue(client,item,amount)
								dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","itemdepots",item,tonumber(result[1][item])+amount,"ID",clicked)
							else
								--triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough "..item.."! (x"..amount.."")
							end
						else
							--triggerClientEvent(client,"draw:infobox",root,"error","There can not be more than x100 "..item.." in stock!")
						end
					end
				elseif(typ=="out")then
					if(tonumber(result[1][item])>=tonumber(amount))then
						addPlayerValue(client,item,amount)
						dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","itemdepots",item,tonumber(result[1][item])-amount,"ID",clicked)
					else
						--triggerClientEvent(client,"draw:infobox",root,"error","So much "..item.." is not in the depot! (x"..amount..")")
					end
				end
				refreshItemDepotItems(client)
			end
		end
	end
end)

function refreshItemDepotItems(player)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","itemdepots","ID",getElementData(client,"Element->Clicked->Type")),-1)
	if(result or result[1])then
		triggerClientEvent(player,"Refresh->Itemdepot->UI",player,result[1]["Coins"])
	end
end

addEvent("Destroy->Itemdepot",true)
addEventHandler("Destroy->Itemdepot",root,function()
	local clicked=getElementData(client,"Element->Clicked->Type")or nil
	if(clicked and clicked~=nil)then
		if(not isTimer(DestroyTimerTable[client]))then
			if(isElement(client))then
				toggleAllControls(client,false)
				setElementFrozen(client,true)
				setPedAnimation(client,"BOMBER","BOM_Plant_Loop")
				
				DestroyTimerTable[client]=setTimer(function(client)
					if(isElement(Itemdepots[clicked]))then
						setPedAnimation(client)
						setElementFrozen(client,false)
						toggleAllControls(client,true)
						dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","itemdepots","ID",clicked)
						destroyElement(Itemdepots[clicked])
						addPlayerValue(client,"Itemdepot",1)
						killTimer(DestroyTimerTable[client])
						DestroyTimerTable[client]=nil
					else
						setPedAnimation(client)
						setElementFrozen(client,false)
						toggleAllControls(client,true)
						killTimer(DestroyTimerTable[client])
						DestroyTimerTable[client]=nil
					end
				end,60*1000,1,client)
			end
		end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(DestroyTimerTable[source]))then
		killTimer(DestroyTimerTable[source])
		DestroyTimerTable[source]=nil
	end
end)