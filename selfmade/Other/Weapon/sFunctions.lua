--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

addEventHandler("onResourceStart",resourceRoot,function()
	--((Colt))
	setWeaponProperty("colt 45","poor","maximum_clip_ammo",10)
    setWeaponProperty("colt 45","std","maximum_clip_ammo",10)
    setWeaponProperty("colt 45","pro","maximum_clip_ammo",10)
	setWeaponProperty("colt 45","poor","weapon_range",35)
    setWeaponProperty("colt 45","std","weapon_range",35)
    setWeaponProperty("colt 45","pro","weapon_range",35)
	--((Silenced))
	setWeaponProperty("silenced","poor","maximum_clip_ammo",10)
    setWeaponProperty("silenced","std","maximum_clip_ammo",10)
    setWeaponProperty("silenced","pro","maximum_clip_ammo",10)
	setWeaponProperty("silenced","poor","weapon_range",40)
    setWeaponProperty("silenced","std","weapon_range",40)
    setWeaponProperty("silenced","pro","weapon_range",40)
	--((Deagle))
	setWeaponProperty("deagle","poor","maximum_clip_ammo",10)
    setWeaponProperty("deagle","std","maximum_clip_ammo",10)
    setWeaponProperty("deagle","pro","maximum_clip_ammo",10)
	setWeaponProperty("deagle","poor","weapon_range",50)
    setWeaponProperty("deagle","std","weapon_range",50)
    setWeaponProperty("deagle","pro","weapon_range",50)
	--((Shotgun))
	setWeaponProperty("shotgun","poor","weapon_range",35)
    setWeaponProperty("shotgun","std","weapon_range",35)
    setWeaponProperty("shotgun","pro","weapon_range",35)
	--((Sawed-off))
	setWeaponProperty("sawed-off","poor","weapon_range",20)
    setWeaponProperty("sawed-off","std","weapon_range",20)
    setWeaponProperty("sawed-off","pro","weapon_range",20)
	--((Combat Shotgun))
	setWeaponProperty("combat shotgun","poor","maximum_clip_ammo",9)
    setWeaponProperty("combat shotgun","std","maximum_clip_ammo",9)
    setWeaponProperty("combat shotgun","pro","maximum_clip_ammo",9)
	setWeaponProperty("combat shotgun","poor","weapon_range",27)
    setWeaponProperty("combat shotgun","std","weapon_range",27)
    setWeaponProperty("combat shotgun","pro","weapon_range",27)
	--((UZI))
	setWeaponProperty("uzi","poor","maximum_clip_ammo",35)
    setWeaponProperty("uzi","std","maximum_clip_ammo",35)
    setWeaponProperty("uzi","pro","maximum_clip_ammo",35)
	setWeaponProperty("uzi","poor","weapon_range",35)
    setWeaponProperty("uzi","std","weapon_range",35)
    setWeaponProperty("uzi","pro","weapon_range",35)
	--((MP5))
	setWeaponProperty("mp5","poor","maximum_clip_ammo",35)
    setWeaponProperty("mp5","std","maximum_clip_ammo",35)
    setWeaponProperty("mp5","pro","maximum_clip_ammo",35)
	setWeaponProperty("mp5","poor","weapon_range",65)
    setWeaponProperty("mp5","std","weapon_range",65)
    setWeaponProperty("mp5","pro","weapon_range",65)
	--((TEC9))
	setWeaponProperty("tec-9","poor","maximum_clip_ammo",100)
    setWeaponProperty("tec-9","std","maximum_clip_ammo",100)
    setWeaponProperty("tec-9","pro","maximum_clip_ammo",100)
	setWeaponProperty("tec-9","poor","weapon_range",57)
    setWeaponProperty("tec-9","std","weapon_range",57)
    setWeaponProperty("tec-9","pro","weapon_range",57)
	--((AK))
	setWeaponProperty("ak-47","poor","maximum_clip_ammo",35)
    setWeaponProperty("ak-47","std","maximum_clip_ammo",35)
    setWeaponProperty("ak-47","pro","maximum_clip_ammo",35)
	setWeaponProperty("ak-47","poor","weapon_range",200)
    setWeaponProperty("ak-47","std","weapon_range",200)
    setWeaponProperty("ak-47","pro","weapon_range",200)
	--((M4))
	setWeaponProperty("m4","poor","maximum_clip_ammo",55)
    setWeaponProperty("m4","std","maximum_clip_ammo",55)
    setWeaponProperty("m4","pro","maximum_clip_ammo",55)
	setWeaponProperty("m4","poor","weapon_range",235)
    setWeaponProperty("m4","std","weapon_range",235)
    setWeaponProperty("m4","pro","weapon_range",235)
	--((Rifle))
	setWeaponProperty("rifle","poor","maximum_clip_ammo",5)
    setWeaponProperty("rifle","std","maximum_clip_ammo",5)
    setWeaponProperty("rifle","pro","maximum_clip_ammo",5)
	setWeaponProperty("rifle","poor","weapon_range",420)
    setWeaponProperty("rifle","std","weapon_range",420)
    setWeaponProperty("rifle","pro","weapon_range",420)
	--((Sniper))
	setWeaponProperty("sniper","poor","maximum_clip_ammo",8)
    setWeaponProperty("sniper","std","maximum_clip_ammo",8)
    setWeaponProperty("sniper","pro","maximum_clip_ammo",8)
	setWeaponProperty("sniper","poor","weapon_range",450)
    setWeaponProperty("sniper","std","weapon_range",450)
    setWeaponProperty("sniper","pro","weapon_range",450)
end)

addEvent("Reload->Rifles",true)
addEventHandler("Reload->Rifles",root,function()
	if(isPedDucked(source))then
		setPedAnimation(source,"RIFLE","RIFLE_crouchload",-1,false,false,false,false)
	else
		setPedAnimation(source,"RIFLE","RIFLE_load",-1,false,false,false,false)
	end
end)

--//Depot
local Weapondepot={
	[22]={"Colt 45",2},
	[23]={"Silenced",2},
	[24]={"Desert Eagle",2},
	[25]={"Shotgun",3},
	[26]={"Sawed-off",3},
	[27]={"Combat Shotgun",3},
	[28]={"Uzi",4},
	[29]={"Mp5",4},
	[32]={"Tec-9",4},
	[30]={"AK-47",5},
	[31]={"M4",5},
	[33]={"Country Rifle",6},
	[34]={"Sniper",6},
	[35]={"Rocket Launcher",7},
	[36]={"Rocket Launcher HS",7},
	[37]={"Flamethrower",7},
	[38]={"Minigun",7},
	[16]={"Grenade",8},
	[18]={"Molotov",8},
	[39]={"Satchel",8},
}

addEvent("Get->Weapondepot->Weapons",true)
addEventHandler("Get->Weapondepot->Weapons",root,function()
	WeapondepotHandWeapons={}
	WeapondepotDepotWeapons={}
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","weapondepots","Username",getPlayerName(client)),-1)
	if(result and result[1])then
		for _,v in pairs(result)do
			table.insert(WeapondepotDepotWeapons,{v["ID"],Weapondepot[v["WeaponID"]][1],v["WeaponAmmo"]})
		end
	end
	
	for i=1,11 do
		if(i~=10)then
			local weapon=getPedWeapon(client,i)
			local ammo=getPedTotalAmmo(client,i)
			if(weapon and ammo)then
				if(weapon>=1 and ammo>=1)then
					table.insert(WeapondepotHandWeapons,{Weapondepot[weapon][1],ammo})
				end
			end
		end
	end
	triggerClientEvent(client,"Refresh->Weapondepot->UI",client,WeapondepotHandWeapons,WeapondepotDepotWeapons)
end)


addEvent("Put->In->Weapondepot->Weapon",true)
addEventHandler("Put->In->Weapondepot->Weapon",root,function(id)
	local pname=getPlayerName(client)
	if(getPlayerValue(client,"Weapondepot")==1)then
		if(not(isPremium(client)))then
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","weapondepots","Username",pname),-1)
			if(#result<=6)then
				local weapon=getPedWeapon(client,Weapondepot[id][2])
				local ammo=getPedTotalAmmo(client,Weapondepot[id][2])
				dbExec(DB.HANDLER,"INSERT INTO weapondepots (Username,WeaponID,WeaponAmmo) VALUES ('"..pname.."','"..id.."','"..ammo.."')")
				takeWeapon(client,weapon)
			end
		else
			local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","weapondepots","Username",pname),-1)
			if(#result<=12)then
				local weapon=getPedWeapon(client,Weapondepot[id][2])
				local ammo=getPedTotalAmmo(client,Weapondepot[id][2])
				dbExec(DB.HANDLER,"INSERT INTO weapondepots (Username,WeaponID,WeaponAmmo) VALUES ('"..pname.."','"..id.."','"..ammo.."')")
				takeWeapon(client,weapon)
			end
		end
	end
end)

addEvent("Put->Out->Weapondepot->Weapon",true)
addEventHandler("Put->Out->Weapondepot->Weapon",root,function(id)
	if(getData(client,"Weapondepot")==1)then
		local weapon=getMySQLData("weapondepots","ID",id,"WeaponID")
		local ammo=getMySQLData("weapondepots","ID",id,"WeaponAmmo")
		giveWeapon(client,weapon,ammo,true)
		dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","weapondepots","ID",id)
	end
end)

--//Shop
local WeaponshopTable={
	-- Name, Price, Weapon-ID, Ammo, Level, Slot
	["Colt 45"]={75,22,68,1,2},
	["Silenced"]={100,23,68,1,2},
	["Desert Eagle"]={250,24,42,1,2},
	["Shotgun"]={500,25,30,3,3},
	["Sawed-off"]={750,26,18,3,3},
	["Combat Shotgun"]={1250,27,35,4,3},
	["Uzi"]={1500,28,200,6,4},
	["Mp5"]={1800,29,120,6,4},
	["Tec-9"]={2000,32,200,7,4},
	["AK-47"]={2200,30,250,10,5},
	["M4"]={2500,31,300,12,5},
	["Rifle"]={3000,33,50,13,6},
	["Sniper"]={6000,34,25,19,6},
	["Rocket Launcher"]={10000,35,5,25,7},
	["Rocket Launcher HS"]={12500,36,5,25,7},
	["Flamethrower"]={20000,37,250,30,7},
	["Minigun"]={35000,38,1000,46,7},
	["Grenade"]={40000,16,25,50,8},
	["Molotov"]={40000,18,25,50,8},
	["Satchel"]={50000,39,30,75,8},
}

addEvent("Buy->Weapon",true)
addEventHandler("Buy->Weapon",root,function(weapon)
	if(tonumber(getData(client,"Level"))>=WeaponshopTable[weapon][4])then
		if(tonumber(getData(client,"Coins"))>=WeaponshopTable[weapon][1])then
			local handWeapon=getPedWeapon(client,WeaponshopTable[weapon][5])
			if(handWeapon and handWeapon~=WeaponshopTable[weapon][2])then
				takeWeapon(client,handWeapon)
			end
			takePlayerValue(client,"Coins",WeaponshopTable[weapon][1])
			giveWeapon(client,WeaponshopTable[weapon][2],WeaponshopTable[weapon][3],true)
			--triggerClientEvent(client,"draw:infobox",root,"info","You bought the weapon.")
			--triggerClientEvent(client,"refresh:weaponshop",client)
		else
			--triggerClientEvent(client,"draw:infobox",root,"error","You don't have enough coins! (x"..WeaponshopTable[weapon][1]..")")
		end
	else
		--triggerClientEvent(client,"draw:infobox",root,"error","You have to be at least level "..WeaponshopTable[weapon][4].." to buy this weapon!")
	end
end)











