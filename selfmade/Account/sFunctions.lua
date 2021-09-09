--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local Table={
	["accounts"]={
		"AdminLevel","Hunger","Thirst","Premium","Hospitaltime","BoosttimeMoney20","BoosttimeMoney50","BoosttimeEXP20","BoosttimeEXP50",
	},
	["inventory"]={
		"Coins","Pastacan","Ravioli","Pepsi","Cola","Fuelcan","Repairkit","FirstAidKit","Weapondepot","Itemdepot","Skin_7","Skin_11","Skin_12","Skin_13","Skin_31","Boost_Money20","Boost_Money50","Boost_EXP20","Boost_EXP50",
	},
	["settings"]={
		"SpawnX","SpawnY","SpawnZ","SpawnROT","SpawnINT","SpawnDIM","SkinID","Hitglocke","RenderdistanceWorld","RenderdistanceCustom",
	},
	["stats"]={
		"Playtime","Kills","Deaths","Damage","ZombieKills","Level","EXP",
	},
	["weaponskills"]={
		"Colt45","Silenced","Deagle","Shotgun","Sawedoff","Uzi","Mp5","AK47","M4","Rifle","Sniper",
	},
	
	--//Player timers
	Playtime={},
	Hunger={},
	Thirst={},
}

addEvent("Create->Register_Login->Account",true)
addEventHandler("Create->Register_Login->Account",root,function(username,password,email)
	local Serial=getPlayerSerial(client)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","accounts","Serial",Serial),-1)
    if(not result or not result[1])then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","accounts","Username",username),-1)
        if(not result or not result[1])then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","accounts","Email",email),-1)
			if(not result or not result[1])then
				for _,v in ipairs(Server.InvalidCharacters)do
					if(username:lower():find(v,1,true))then
						triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","RegisterLogin","TEXT_InvalidCharacters"),10)
						return false
					end
				end
				
				outputLog("Account: "..username.." "..password.." "..email,"Account creation")
				local Hashh=md5(hash("sha512",password))
				setPlayerName(client,username)
				setPlayerName(client,username)
				setPlayerName(client,username)
				
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","achievement","Username",username),-1)
				if(not result or not result[1])then
					dbExec(DB.HANDLER,"INSERT INTO achievement (Username) VALUES (?)",username)
					outputLog(username.." achievement inserted!","Account creation")
				end
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","accounts","Username",username),-1)
				if(not result or not result[1])then
					dbExec(DB.HANDLER,"INSERT INTO accounts (Username,Password,Serial,Email,AdminLevel,Hunger,Thirst,Premium,Hospitaltime,BoosttimeMoney20,BoosttimeMoney50,BoosttimeEXP20,BoosttimeEXP50) VALUES (?,?,?,?,?,?,?,?,?,?,?)",username,Hashh,Serial,email,"0","100","100","0","0","0","0","0","0")
					outputLog(username.." accounts inserted!","Account creation")
				end
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","inventory","Username",username),-1)
				if(not result or not result[1])then
					dbExec(DB.HANDLER,"INSERT INTO inventory (Username,Coins,Pastacan,Ravioli,Pepsi,Cola,Fuelcan,Repairkit,FirstAidKit,Weapondepot,Itemdepot,Skin_7,Skin_11,Skin_12,Skin_13,Skin_31,Boost_Money20,Boost_Money50,Boost_EXP20,Boost_EXP50) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)",username,"650","3","3","5","5","0","0","1","0","0","0","0","0","0","0","0","0","0","0")
					outputLog(username.." inventory inserted!","Account creation")
				end
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","settings","Username",username),-1)
				if(not result or not result[1])then
					dbExec(DB.HANDLER,"INSERT INTO settings (Username,SpawnX,SpawnY,SpawnZ,SpawnROT,SpawnINT,SpawnDIM,SkinID,Hitglocke,RenderdistanceWorld,RenderdistanceCustom) VALUES (?,?,?,?,?,?,?,?,?,?,?)",username,"-1963.2","120.3","28","0","0","0","0","4","2000","100")
					outputLog(username.." settings inserted!","Account creation")
				end
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","stats","Username",username),-1)
				if(not result or not result[1])then
					dbExec(DB.HANDLER,"INSERT INTO stats (Username,Playtime,Kills,Deaths,Damage,ZombieKills,Level,EXP) VALUES (?,?,?,?,?,?,?,?)",username,"0","0","0","0","0","1","0")
					outputLog(username.." stats inserted!","Account creation")
				end
				local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","weaponskills","Username",username),-1)
				if(not result or not result[1])then
					dbExec(DB.HANDLER,"INSERT INTO weaponskills (Username,Colt45,Silenced,Deagle,Shotgun,Sawedoff,Uzi,Mp5,AK47,M4,Rifle,Sniper) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",username,"0","0","0","0","0","0","0","0","0","0","0")
					outputLog(username.." weaponskills inserted!","Account creation")
				end
				
				setDatasAfterRegisterLogin(client)
				triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","RegisterLogin","TEXT_Registered"))
				outputLog("Register: "..getPlayerName(client).." registered successfully!","RegisterLogin")
			end
		end
	end
end)
addEvent("Login->Register_Login->Account",true)
addEventHandler("Login->Register_Login->Account",root,function(password)
	local Hashh=md5(hash("sha512",password))
	local Serial=getPlayerSerial(client)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=? AND ??=?","accounts","Serial",Serial,"Password",Hashh),-1)
	if(result and result[1])then
		setPlayerName(client,getMySQLData("accounts","Serial",Serial,"Username"))
		setPlayerName(client,getMySQLData("accounts","Serial",Serial,"Username"))
		setPlayerName(client,getMySQLData("accounts","Serial",Serial,"Username"))
		
		setDatasAfterRegisterLogin(client)
		triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","RegisterLogin","TEXT_Loggedin"))
		outputLog("Login: "..getPlayerName(client).." loggedin successfully!","RegisterLogin")
	else
		triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","RegisterLogin","TEXT_PasswordWrong"))
	end
end)

function setDatasAfterRegisterLogin(player)
	local pname=getPlayerName(player)
	local rdmHunger=math.random(60,75)
	local rdmThirst=math.random(55,65)
	
	--//Set database datas
	for i=1,#Table["accounts"] do
		setData(player,Table["accounts"][i],getMySQLData("accounts","Username",pname,Table["accounts"][i]))
	end
	for i=1,#Table["inventory"] do
		setData(player,Table["inventory"][i],getMySQLData("inventory","Username",pname,Table["inventory"][i]))
	end
	for i=1,#Table["settings"] do
		setData(player,Table["settings"][i],getMySQLData("settings","Username",pname,Table["settings"][i]))
	end
	for i=1,#Table["stats"] do
		setData(player,Table["stats"][i],getMySQLData("stats","Username",pname,Table["stats"][i]))
	end
	for i=1,#Table["weaponskills"] do
		setData(player,Table["weaponskills"][i],getMySQLData("weaponskills","Username",pname,Table["weaponskills"][i]))
	end
	
	--//Set datas
	setElementData(player,"Loggedin",1)
	setData(player,"AFK",false)
	setData(player,"Duty->Admin",false)
	toggleGhostMode(player,true,10000)
	
	--//Trigger
	triggerClientEvent(player,"Set->Renderdistance",player,"World")
	triggerClientEvent(player,"Set->Renderdistance",player,"Custom")
	
	--//Bindkeys
	
	--//Timers
	Table.Playtime[player]=setTimer(function(player)
		if(isElement(player))then
			if(isLoggedin(player))then
				if(getData(player,"AFK")==false)then
					addPlayerValue(player,"Playtime",1)
					
					if(getData(player,"BoosttimeMoney20")>=1)then
						takePlayerValue(player,"BoosttimeMoney20",1)
					end
					if(getData(player,"BoosttimeMoney50")>=1)then
						takePlayerValue(player,"BoosttimeMoney50",1)
					end
					
					if(getData(player,"BoosttimeEXP20")>=1)then
						takePlayerValue(player,"BoosttimeEXP20",1)
					end
					if(getData(player,"BoosttimeEXP50")>=1)then
						takePlayerValue(player,"BoosttimeEXP50",1)
					end
				end
				--//AFK
				if(getPlayerIdleTime(player)>15*60*1000)then
					if(getData(player,"AFK")==false)then
						AFKPlayerTable[player]=math.random(10000,99999)
						outputChatBox(getLanguageWord(player,"Server","General","TEXT_AFKSet").." '"..AFKPlayerTable[player].."'",player,255,255,255)
						setData(player,"AFK",true)
						
						if(isPedInVehicle(player))then
							local veh=getPedOccupiedVehicle(player)
							setElementFrozen(veh,true)
							
							addEventHandler("onVehicleStartExit",veh,function(player)
								if(getData(player,"AFK")==true)then
									cancelEvent()
									triggerClientEvent(player,"Draw->Infobox->UI",root,"Warning","Information",getLanguageWord(player,"Server","General","TEXT_AFKSet").." '"..AFKPlayerTable[player].."'")
								end
							end)
						else
							setElementFrozen(player,true)
						end
					end
				end
				--\\AFK
				if(math.floor(getData(player,"Playtime")/60)==(tonumber(getData(player,"Playtime"))/60))then
					if(not(isPremium(player)))then
						outputChatBox("Playtime Bonus: x150 Coins",player,0,200,0)
						addPlayerValue(player,"Coins",150)
					else
						outputChatBox("Playtime Bonus: x300 Coins",player,0,200,0)
						addPlayerValue(player,"Coins",300)
					end
				end
				
				checkPremiumStatus(player)
			end
		end
	end,60*1000,0,player)
	
	Table.Hunger[player]=setTimer(function(player)
		if(isElement(player))then
			if(isLoggedin(player))then
				if(getData(player,"AFK")==false)then
					rdmHunger=math.random(60,75)
					takePlayerValue(player,"Hunger",1)
					
					if(tonumber(getData(player,"Hunger"))<=0)then
						killPed(player)
						outputChatBox(getLanguageWord(player,"Server","General","TEXT_DeadMessage_Hunger"),player,200,0,0)
						outputLog("[KILL]: "..getPlayerName(player).." has died of hunger!","Damage")
						setData(player,"Hunger",45)
					end
				end
			end
		end
	end,rdmHunger*1000,0,player)
	Table.Thirst[player]=setTimer(function(player)
		if(isElement(player))then
			if(isLoggedin(player))then
				if(getData(player,"AFK")==false)then
					rdmThirst=math.random(55,65)
					takePlayerValue(player,"Thirst",1)
					
					if(tonumber(getData(player,"Thirst"))<=0)then
						killPed(player)
						outputChatBox(getLanguageWord(player,"Server","General","TEXT_DeadMessage_Thirst"),player,200,0,0)
						outputLog("[KILL]: "..getPlayerName(player).." has died of thirst!","Damage")
						setData(player,"Thirst",45)
					end
				end
			end
		end
	end,rdmThirst*1000,0,player)
	
	--//Set/load other stuff
	checkPremiumStatus(player)
	
	setPedStat(player,69,tonumber(getData(player,"Colt45")))
	setPedStat(player,70,tonumber(getData(player,"Silenced")))
	setPedStat(player,71,tonumber(getData(player,"Deagle")))
	setPedStat(player,72,tonumber(getData(player,"Shotgun")))
	setPedStat(player,73,tonumber(getData(player,"Sawedoff")))
	setPedStat(player,75,tonumber(getData(player,"Uzi")))
	setPedStat(player,76,tonumber(getData(player,"Mp5")))
	setPedStat(player,77,tonumber(getData(player,"AK47")))
	setPedStat(player,78,tonumber(getData(player,"M4")))
	setPedStat(player,79,tonumber(getData(player,"Rifle")))
	setPedStat(player,79,tonumber(getData(player,"Sniper")))
	
	triggerClientEvent(player,"Destroy->Register_Login->UI",player)
	
	if(tonumber(getData(player,"Hospitaltime"))>=1)then
		setCameraTarget(player,player)
		killPed(player)
		triggerClientEvent(player,"Create->Hospital->UI",player,tonumber(getData(player,"Hospitaltime")))
	else
		spawnPlayerAfterRegisterLogin(player)
	end
	
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE ??=?","Weapons","logoutweapons","Username",pname),-1)
	if(result and result[1])then
		dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","logoutweapons","Username",pname)
		for i=1,12 do
			local wstring=gettok(result[1]["Weapons"],i,string.byte("|"))
			if(wstring and #wstring>=1)then
				local weapon=tonumber(gettok(wstring,1,string.byte(",")))
				local ammo=tonumber(gettok(wstring,2,string.byte(",")))
				giveWeapon(player,weapon,ammo)
			end
		end
	end
	
end

function spawnPlayerAfterRegisterLogin(player)
	local pname=getPlayerName(player)
	setCameraTarget(player,player)
	setElementFrozen(player,false)
	
	spawnPlayer(player,getMySQLData("settings","Username",pname,"SpawnX"),getMySQLData("settings","Username",pname,"SpawnY"),getMySQLData("settings","Username",pname,"SpawnZ"),getMySQLData("settings","Username",pname,"SpawnROT"),getMySQLData("settings","Username",pname,"SkinID"),getMySQLData("settings","Username",pname,"SpawnINT"),getMySQLData("settings","Username",pname,"SpawnDIM"))
end
function savePlayerDatas(player)
	if(isLoggedin(player))then
		local pname=getPlayerName(player)
		
		for i=1,#Table["accounts"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","accounts",Table["accounts"][i],getData(player,Table["accounts"][i]),"Username",pname)
		end
		for i=1,#Table["inventory"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","inventory",Table["inventory"][i],getData(player,Table["inventory"][i]),"Username",pname)
		end
		for i=1,#Table["settings"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","settings",Table["settings"][i],getData(player,Table["settings"][i]),"Username",pname)
		end
		for i=1,#Table["stats"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","stats",Table["stats"][i],getData(player,Table["stats"][i]),"Username",pname)
		end
		for i=1,#Table["weaponskills"] do
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","weaponskills",Table["weaponskills"][i],getData(player,Table["weaponskills"][i]),"Username",pname)
		end
		
		--//Save player logout position and more...
		local x,y,z=getElementPosition(player)
		local _,_,rz=getElementRotation(player)
		local int=getElementInterior(player)
		local dim=getElementDimension(player)
		
		if(x and y and z and rz and int and dim)then
			dbExec(DB.HANDLER,"UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?","settings","SpawnX",x,"SpawnY",y,"SpawnZ",z,"SpawnROT",rz,"SpawnINT",int,"SpawnDIM",dim,"Username",pname)
		end
		
		local curWeaponsForSave="|"
		for i=1,11 do
			if(i~=10)then
				local weapon=getPedWeapon(player,i)
				local ammo=getPedTotalAmmo(player,i)
				if(weapon and ammo)then
					if(weapon>=1 and ammo>=1)then
						if(#curWeaponsForSave<=40)then
							curWeaponsForSave=curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		if(#curWeaponsForSave>=5)then
			dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Weapons) VALUES (?,?)","logoutweapons",pname,curWeaponsForSave)
		end
		
	end
end

addEventHandler("onPlayerQuit",root,function()
	local pname=getPlayerName(source)
	if(isLoggedin(source))then
		savePlayerDatas(source)
		local curWeaponsForSave="|"
		for i=1,11 do
			if(i~=10)then
				local weapon=getPedWeapon(source,i)
				local ammo=getPedTotalAmmo(source,i)
				if(weapon and ammo)then
					if(weapon>=1 and ammo>=1)then
						if(#curWeaponsForSave<=40)then
							curWeaponsForSave=curWeaponsForSave..weapon..","..ammo.."|"
						end
					end
				end
			end
		end
		if(#curWeaponsForSave>=5)then
			dbExec(DB.HANDLER,"INSERT INTO ?? (Username,Weapons) VALUES (?,?)","logoutweapons",pname,curWeaponsForSave)
		end
		if(isTimer(Table.Playtime[player]))then
			killTimer(Table.Playtime[player])
			Table.Playtime[player]=nil
		end
		if(isTimer(Table.Hunger[player]))then
			killTimer(Table.Hunger[player])
			Table.Hunger[player]=nil
		end
		if(isTimer(Table.Thirst[player]))then
			killTimer(Table.Thirst[player])
			Table.Thirst[player]=nil
		end
		if(AFKPlayerTable[player])then
			AFKPlayerTable[player]=nil
		end
	end
end)
addEventHandler("onPlayerJoin",root,function()
	local rdm=math.random(100000,999999)
	setPlayerName(source,"LAKEZ-"..rdm)
	
	setElementData(source,"Loggedin",0)
	setElementData(source,"Language",tonumber(1))
	
	setElementPosition(source,0,0,0)
end)


addEvent("Check->Register_Login->Account",true)
addEventHandler("Check->Register_Login->Account",root,function()
	local Serial=getPlayerSerial(client)
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","accounts","Serial",Serial),-1)
	if(#result>=1)then
		triggerClientEvent(client,"Create->Register_Login->UI",client,"Login")
	else
		triggerClientEvent(client,"Create->Register_Login->UI",client,"Register")
	end
end)