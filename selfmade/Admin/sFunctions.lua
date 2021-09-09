--//Give ingame stuff
addCommandHandler("level",function(player,cmd,typ,tplayer,amount)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=3)then
			if(tplayer)then
				local target=getPlayerFromName(tplayer)
				if(isElement(target)and isLoggedin(target))then
					if(typ=="premium")then
						if(amount and tonumber(amount)and tonumber(amount)>=1)then
							local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","premiumtime","Username",getPlayerName(target)),-1)
							if(not result or not result[1])then
								setData(target,"Premium",1)
								dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Time) VALUES ('"..getPlayerName(target).."','"..getSecTime(amount).."')","premiumtime")
								checkPremiumStatus(target)
							else
								triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error","This player has already Premium!")
							end
						end
					elseif(typ=="admin")then
						if(amount and tonumber(amount)and tonumber(amount)>=0 and tonumber(amount)<=4)then
							setData(target,"AdminLevel",tonumber(amount))
						else
							triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error",getLanguageWord(player,"Server","General","TEXT_MaxLevel"))
						end
					end
				else
					triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error",getLanguageWord(player,"Server","General","TEXT_PlayerNotFound"))
				end
			else
				triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error",getLanguageWord(player,"Server","General","TEXT_EnterAtarget"))
			end
		end
	end
end)

addCommandHandler("give",function(player,cmd,typ,tplayer,amount)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=3)then
			if(tplayer)then
				local target=getPlayerFromName(tplayer)
				if(isElement(target)and isLoggedin(target))then
					if(amount and tonumber(amount)and tonumber(amount)>=1)then
						if(typ=="coins")then
							setData(target,"Coins",tonumber(getData(target,"Coins"))+amount)
						end
					end
				else
					triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error",getLanguageWord(player,"Server","General","TEXT_PlayerNotFound"))
				end
			else
				triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error",getLanguageWord(player,"Server","General","TEXT_EnterAtarget"))
			end
		end
	end
end)

--//Chats
addCommandHandler("a",function(player,cmd,...)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=1)then
			for _,v in pairs(getElementsByType("player"))do
				if(isLoggedin(v))then
					if(tonumber(getData(v,"AdminLevel"))>=1)then
						outputChatBox("(ADMIN-Chat) "..getPlayerName(player)..": "..stringTextWithAllParameters(...),v,200,0,0)
					end
				end
			end
			outputLog("(ADMIN-Chat) "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chats")
		end
	end
end)

addCommandHandler("o",function(player,cmd,...)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=1)then
			outputChatBox("(STAFF) "..Server.Admin.Level.Color[tonumber(getData(player,"AdminLevel"))]..getPlayerName(player).."#ffffff: "..stringTextWithAllParameters(...),root,255,255,2555,true)
			outputLog("(O-Chat) "..getPlayerName(player)..": "..stringTextWithAllParameters(...),"Chats")
		end
	end
end)

addCommandHandler("cc",function(player,cmd)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=1)then
			clearChatBox(root)
		end
	end
end)

--//Create Ingame stuff
function createIngameStuff(player,cmd,typ,priority)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=3)then
			if(typ=="lootbox")then
				if(priority)then
					local x,y,z=getElementPosition(player)
					local rx,ry,rz=getElementRotation(player)
					local IDcounter=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE Lootbox=Lootbox","Lootbox","counter"),-1)[1]["Lootbox"]
					dbExec(DB.HANDLER,"UPDATE ?? SET ??=?","counter","Lootbox",IDcounter+1)
					
					Loot[IDcounter]=createObject(2969,x,y,z-0.9,0,0,rz)
					setElementData(Loot[IDcounter],"loot",true)
					setElementData(Loot[IDcounter],"lootID",IDcounter)
					
					dbExec(DB.HANDLER,"INSERT INTO ?? (ID,SpawnX,SpawnY,SpawnZ,RotZ,LootPriority) VALUES (?,?,?,?,?,?)","lootpositions",IDcounter,x,y,z-0.9,rz,priority)
				end
			elseif(typ=="vehicle")then
				if(priority)then
					--if(#priority>=400 and #priority<=611)then
						local x,y,z=getElementPosition(player)
						local rx,ry,rz=getElementRotation(player)
						local IDcounter=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE Vehicles=Vehicles","Vehicles","counter"),-1)[1]["Vehicles"]
						dbExec(DB.HANDLER,"UPDATE ?? SET ??=?","counter","Vehicles",IDcounter+1)
						
						Server.Vehicles[IDcounter]=createVehicle(priority,x,y+3,z+2,rx,ry,rz," ")
						local maxliter=getVehicleFuelSizeUsage(Server.Vehicles[IDcounter])
						setElementData(Server.Vehicles[IDcounter],"veh:id",IDcounter)
						setElementData(Server.Vehicles[IDcounter],"veh:fuel",tonumber(maxliter))
						
						dbExec(DB.HANDLER,"INSERT INTO ?? (ID,VehID,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ,Fuel) VALUES (?,?,?,?,?,?,?,?,?)","vehicles",IDcounter,priority,x,y,z,rx,ry,rz,maxliter)
					--end
				end
			end
		end
	end
end
addCommandHandler("create",createIngameStuff)

function destroyIngameStuff(player,cmd,typ)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=3)then
			if(typ=="vehicle")then
				local veh=getPedOccupiedVehicle(player)
				if(veh and isElement(veh))then
					dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","vehicles","ID",getElementData(veh,"veh:id"))
					destroyElement(veh)
					veh=nil
				end
			end
		end
	end
end
addCommandHandler("destroy",destroyIngameStuff)

--//Adminduty
local LastSkin={}
addCommandHandler("aduty",function(player,cmd)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=1)then
			if(not LastSkin[player])then
				LastSkin[player]=getElementModel(player)
				setElementModel(player,264)
				setData(player,"Duty->Admin",true)
				addEventHandler("onPlayerQuit",player,quitAdminDuty)
			else
				setElementModel(player,LastSkin[player])
				LastSkin[player]=nil
				setData(player,"Duty->Admin",false)
				removeEventHandler("onPlayerQuit",player,quitAdminDuty)
			end
		end
	end
end)

function quitAdminDuty()
	if(LastSkin[source])then
		LastSkin[source]=nil
	end
end
--//Kick/Ban
local function banPlayer(player,cmd,typ,tplayer,reas,time)
	if(isLoggedin(player))then
		if(typ=="perm")then
			if(tonumber(getData(player,"AdminLevel"))and tonumber(getData(player,"AdminLevel"))>=3 and(not client or client==player))then
				local reason=table.concat({reas}," ")
				if(#reason>=3)then
					local target=getPlayerFromName(tplayer)
					if(isElement(target)and isLoggedin(target))then
						local serial=getPlayerSerial(target)
						
						dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","bans","Admin","Target","TargetSerial","Reason","Time",getPlayerName(player),getPlayerName(target),serial,reason,"0")
						kickPlayer(target,player,tostring(reason).." (banned!)")
					else
						local serial=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Serial","accounts","Username",tplayer),-1)[1]["Serial"]
						
						dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","bans","Admin","Target","TargetSerial","Reason","Time",getPlayerName(player),tplayer,serial,tostring(reason),"0")
						outputChatBox("Der Spieler wurde gebannt! (offline)!",player,200,0,0)
					end
				else
					triggerClientEvent(player,"draw:infobox",player,"error","Error","Gebe einen Grund mit mehr als 3 Zeichen an!")
				end
			end
		elseif(typ=="temp")then
			if(tonumber(getData(player,"AdminLevel"))and tonumber(getData(player,"AdminLevel"))>=2 and(not client or client==player))then
				local reason=table.concat({reas}," ")
				if(#reason>=3)then
					if(time and tonumber(time)>=1)then
						local target=getPlayerFromName(tplayer)
						if(target)then
							banPlayerTime(getPlayerName(target),tonumber(time),getPlayerName(player),reason)
						else
							banPlayerTime(tplayer,tonumber(time),getPlayerName(player),reason)
						end
					else
						triggerClientEvent(player,"draw:infobox",player,"error","Error","Gebe eine Zeit an!\n(1=1 Stunden, 2=2 Stunden)")
					end
				else
					triggerClientEvent(player,"draw:infobox",player,"error","Error","Gebe einen Grund mit mehr als 3 Zeichen an!")
				end
			end
		end
	end
end
addCommandHandler("rban",banPlayer)

addCommandHandler("uban",function(player,cmd,tplayer)
	if(isLoggedin(player))then
		if(tonumber(getData(player,"AdminLevel"))and tonumber(getData(player,"AdminLevel"))>=4)then
			local target=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","TargetSerial","bans","Target",tplayer),-1)[1]["TargetSerial"]
			if(isElement(target)and isLoggedin(target))then
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE Target LIKE ?","bans",tplayer)
				outputChatBox("Der Spieler wurde entbannt!",player,0,200,0)
			else
				triggerClientEvent(player,"draw:infobox",player,"error","Error","Der Staatsbürger ist nicht gebannt!")
			end
		end
	end
end)

--//Other funcs
addEvent("Get->Staff->Members",true)
addEventHandler("Get->Staff->Members",root,function()
	local tbl={}
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM accounts WHERE AdminLevel>=1"),-1)
	if(#result>=1)then
		for _,v in pairs(result)do
			if(v["AdminLevel"]>=1)then
				local target=getPlayerFromName(v["Username"])
				if(isElement(target))then
					status="Online"
				else
					status="Offline"
				end
				table.insert(tbl,{v["Username"],v["AdminLevel"],status})
			end
		end
		triggerClientEvent(client,"Putin->Staffmembers->UI",client,tbl)
	end
end)
function createAdminlistUI(player,cmd)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		triggerClientEvent(player,"Create->Staffmembers->UI",player)
	end
end
addCommandHandler("team",createAdminlistUI)
addCommandHandler("admins",createAdminlistUI)

addCommandHandler("xyz",function(player,cmd,x,y,z)
	if(isElement(player)and isLoggedin(player)and(not client or client==player))then
		if(tonumber(getData(player,"AdminLevel"))>=4)then
			setElementPosition(player,x,y,z)
		end
	end
end)







function banPlayerTime(pname,time,admin,reason)
	local player=getPlayerFromName(pname)
	
	if(pname)then
		local sec=getTBanSecTime(time)
		local serial=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Serial","accounts","Username",pname),-1)[1]["Serial"]
		
		dbExec(DB.HANDLER,"INSERT INTO ?? (??,??,??,??,??) VALUES (?,?,?,?,?)","bans","Admin","Target","Reason","TargetSerial","Time",admin,pname,reason,serial,sec)
		outputChatBox("[ADMIN]: Spieler "..pname.." wurde von "..admin.." für "..time.." gebannt! (Grund: "..tostring(reason)..")",root,255,0,0)
		
		if(isElement(player))then
			kickPlayer(player,"Du wurdest für "..time.." Stunden von "..admin.." gebannt! (Grund: "..reason..")")
		end
		return true
	end
	return false
end