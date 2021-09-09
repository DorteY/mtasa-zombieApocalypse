--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local gunsPickup={}
local LootRespawnTime=1

local weaponPickupIDS={
	[22]=346,
	[23]=347,
	[24]=348,
	[25]=349,
	[27]=351,
	[28]=352,
	[29]=353,
	[30]=355,
	[31]=356,
	[33]=357,
	[34]=358,
	[35]=359,
	[36]=360,
}

local bodybarts={
	[3]="Torso",
	[4]="Ass",
	[5]="Left Arm",
	[6]="Right Arm",
	[7]="Left Leg",
	[8]="Right Leg",
	[9]="Head",
}

function wastedPlayer(ammo,attacker,weapon,bodypart)
	local x,y,z=getElementPosition(source)
	local weapon=getPedWeapon(source)
	local ammo=getPedTotalAmmo(source)
	
	if(weaponPickupIDS[weapon])then
		if(isElement(gunsPickup[source]))then
			destroyElement(gunsPickup[source])
		end
		gunsPickup[source]=createPickup(x,y,z,3,weaponPickupIDS[weapon],50)
		setElementData(gunsPickup[source],"weapon",weapon)
		setElementData(gunsPickup[source],"ammo",ammo)
		
		addEventHandler("onPickupHit",gunsPickup[source],function(player)
			if(isPedDead(player))then
				return
			end
			if(isPedInVehicle(player))then
				return
			end
			local waffe=getElementData(source,"weapon")
			local munition=getElementData(source,"ammo")
			giveWeapon(player,waffe,munition,true)
			destroyElement(source)
			triggerClientEvent(player,"Draw->Infobox->UI",root,"Info","Information","You have picked up a gun!")
		end)
	end
	
	if(isLoggedin(attacker))then
		local rdmEXP=math.random(30,80)
		if(attacker and attacker~=source and getElementType(attacker)=="player")then
			addPlayerValue(attacker,"Kills",1)
			triggerClientEvent(attacker,"Draw->Kill->UI",attacker,"Player")
			addPlayerAchievment(attacker,"FirstPlayerKill","First Player Kill!",300)
		end
	end
	addPlayerValue(source,"Deaths",1)
	
	if(tonumber(getData(source,"Hospitaltime"))==0)then
		if(tonumber(getData(source,"AdminLevel"))>=1)then
			triggerClientEvent(source,"Create->Hospital->UI",source,15)
			setData(source,"Hospitaltime",15)
		elseif(isPremium(source))then
			triggerClientEvent(source,"Create->Hospital->UI",source,25)
			setData(source,"Hospitaltime",25)
		else
			triggerClientEvent(source,"Create->Hospital->UI",source,60)
			setData(source,"Hospitaltime",60)
		end
	end
end
addEventHandler("onPlayerWasted",root,wastedPlayer)


addEvent("Trigger->Damage",true)
addEventHandler("Trigger->Damage",root,function(attacker,weapon,bodypart,loss,player)
	if(attacker and weapon and bodypart and loss)then
		if(weapon==34 and bodypart==9)then
			if(tonumber(getData(player,"Savezone"))==1)then
				return false
			end
			if(tonumber(getData(attacker,"Savezone"))==1)then
				return false
			end
			if(getData(player,"Duty->Admin")and getData(player,"Duty->Admin")==true)then
				return false
			end
			if(getData(attacker,"Duty->Admin")and getData(attacker,"Duty->Admin")==true)then
				return false
			end
			
			setPedHeadless(player,true)
			killPed(player,attacker,weapon,bodypart)
			outputLog("[KILL]: "..getPlayerName(attacker).." hat "..getPlayerName(player).." mit der Sniper ein Headshot gegeben!","Damage")
		else
			if(tonumber(getData(player,"Savezone"))==1)then
				return false
			end
			if(tonumber(getData(attacker,"Savezone"))==1)then
				return false
			end
			if(getData(player,"Duty->Admin")and getData(player,"Duty->Admin")==true)then
				return false
			end
			if(getData(attacker,"Duty->Admin")and getData(attacker,"Duty->Admin")==true)then
				return false
			end
			
			local basicDMG=(Server.Weapon.Damage[weapon] and Server.Weapon.Damage[weapon][bodypart]or 1)
			if(bodypart==9)then
				multiply=1.3
			else
				multiply=1
			end
			
			if(Server.Weapon.Damage[weapon][bodypart])then
				damagePlayer(player,basicDMG*multiply,attacker,weapon)
				addPlayerValue(attacker,"Damage",basicDMG*multiply)
				outputLog("[DAMAGE]: "..getPlayerName(attacker).." hat "..getPlayerName(player).." mit Waffe "..weapon.." an Part "..bodybarts[bodypart].." getroffen, Schaden: "..basicDMG*multiply.."!","Damage")
			else
				damagePlayer(player,loss,attacker,weapon)
			end
		end
	end
end)

addEvent("Spawn->Hospital",true)
addEventHandler("Spawn->Hospital",root,function()
	setCameraTarget(client,client)
	
	spawnPlayer(client,1-2655.2,638.7,14.5,180,tonumber(getData(client,"SkinID")),0,0)
	
	setPedHeadless(client,false)
	setElementHealth(client,50)
	toggleGhostMode(client,true,7000)
end)


local pickupDestroyTimer={}
addEventHandler("onPedWasted",root,function(ammo,attacker,weapon,bodypart)
	if(getElementData(source,"zombie")and getElementData(source,"zombie")==true)then
		if(attacker and getData(attacker,"ZombieKills"))then
			local x,y,z=getElementPosition(source)
			local zombCoinsPerKill=math.random(9,20)
			local zombCoinsPerKillPremium=math.random(12,25)
			local zombExpPerKill=math.random(9,20)
			local zombExpPerKillPremium=math.random(15,29)
			local MoneyBoost=0;
			local EXPBoost=0;
			
			if(getData(attacker,"BoosttimeMoney50")>=1)then
				MoneyBoost=1.5;
			elseif(getData(attacker,"BoosttimeMoney20")>=1)then
				MoneyBoost=1.2;
			else
				MoneyBoost=0;
			end
			
			if(getData(attacker,"BoosttimeEXP50")>=1)then
				EXPBoost=1.5;
			elseif(getData(attacker,"BoosttimeEXP20")>=1)then
				EXPBoost=1.2;
			else
				EXPBoost=0;
			end
			
			if(isPremium(attacker))then
				addPlayerValue(attacker,"Coins",zombCoinsPerKillPremium*EXPBoost)
				addPlayerValue(attacker,"EXP",zombExpPerKillPremium*EXPBoost)
			else
				addPlayerValue(attacker,"Coins",zombCoinsPerKill*EXPBoost)
				addPlayerValue(attacker,"EXP",zombExpPerKill*EXPBoost)
			end
			addPlayerValue(attacker,"ZombieKills",1)
			triggerClientEvent(attacker,"Draw->Kill->UI",attacker,"Zombie")
			uLevel(attacker)
			
			addPlayerAchievment(attacker,"FirstZombieKill","First Zombie kill!",500)
			if(tonumber(getData(attacker,"ZombieKills"))>=1000)then
				addPlayerAchievment(attacker,"1000ZombieKills","Over 1000 Zombie kills!",5000)
			end
			if(tonumber(getData(attacker,"ZombieKills"))>=10000)then
				addPlayerAchievment(attacker,"10000ZombieKills","Over 10000 Zombie kills!",15000)
			end
			
			
			if(getPedSkin(source)==277)then
				createExplosion(x,y,z,3)
				addPlayerValue(attacker,"Coins",11)
				addPlayerValue(attacker,"EXP",zombExpPerKill*2)
				uLevel(attacker)
			end
			
			if(getPedSkin(source)==70)then
				local rdm=math.random(1,3)
				if(rdm==2)then
					local pickup=createPickup(x,y,z,3,1240,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							addPlayerValue(attacker,"FirstAidKit",1)
							destroyElement(source)
							triggerClientEvent(player,"Draw->Infobox->UI",root,"Info","Information","You have picked up a First Aid Kit!")
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
			if(getPedSkin(source)==195)then
				local rdm=math.random(1,8)
				if(rdm==2)then
					local pickup=createPickup(x,y,z,3,1279,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local rdmItem=math.random(1,500)
							if(rdmItem>=1 and rdmItem<=130)then
								addPlayerValue(attacker,"Pastacan",1)
							elseif(rdmItem>=131 and rdmItem<=180)then
								addPlayerValue(attacker,"Pepsi",1)
							elseif(rdmItem>=181 and rdmItem<=500)then
							end
							destroyElement(source)
							triggerClientEvent(player,"Draw->Infobox->UI",root,"Info","Information","You have picked up a Item!")
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
			if(getPedSkin(source)==155)then
				local rdm=math.random(1,3)
				if(rdm==2)then
					local pickup=createPickup(x,y,z,3,1279,50)
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local rdmItem=math.random(1,500)
							if(rdmItem>=1 and rdmItem<=130)then
								addPlayerValue(attacker,"Pastacan",1)
							elseif(rdmItem>=131 and rdmItem<=180)then
								addPlayerValue(attacker,"Pepsi",1)
							elseif(rdmItem>=181 and rdmItem<=300)then
								addPlayerValue(attacker,"Repairkit",1)
							end
							destroyElement(source)
							triggerClientEvent(player,"Draw->Infobox->UI",root,"Info","Information","You have picked up a Item!")
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
			if(getPedSkin(source)==287)then
				local rdm=math.random(1,3)
				if(rdm==2)then
					addPlayerValue(attacker,"Coins",2)
					local number=math.random(1,999)
					if(number>=1 and number<=400)then--M4
						local rdmAmmo=math.random(200,320)
						weaponID=31
						weaponAmmo=rdmAmmo
						weaponPickupID=356
					elseif(number>=401 and number<=650)then--Rocket
						local rdmAmmo=math.random(8,16)
						weaponID=35
						weaponAmmo=rdmAmmo
						weaponPickupID=359
					elseif(number>=561 and number<=700)then--Minigun
						local rdmAmmo=math.random(40,190)
						weaponID=38
						weaponAmmo=rdmAmmo
						weaponPickupID=362
					elseif(number>=701 and number<=800)then--Deagle
						local rdmAmmo=math.random(40,120)
						weaponID=24
						weaponAmmo=rdmAmmo
						weaponPickupID=348
					elseif(number>=801 and number<=999)then--Colt45
						local rdmAmmo=math.random(70,170)
						weaponID=22
						weaponAmmo=rdmAmmo
						weaponPickupID=346
					end
					
					local pickup=createPickup(x,y,z,3,weaponPickupID,50)
					setElementData(pickup,"weaponID",weaponID)
					setElementData(pickup,"weaponAmmo",weaponAmmo)
					
					addEventHandler("onPickupHit",pickup,function(player)
						if(not(isPedInVehicle(player)))then
							local weapon=getElementData(source,"weaponID")
							local ammo=getElementData(source,"weaponAmmo")
							giveWeapon(player,weapon,ammo,true)
							triggerClientEvent(player,"Draw->Infobox->UI",root,"Info","Information","You have picked up a gun\nwith x"..ammo.." Ammo!")
							destroyElement(source)
						end
					end)
					
					pickupDestroyTimer[pickup]=setTimer(function()
						if(isElement(pickup))then
							destroyElement(pickup)
						end
					end,LootRespawnTime*60*1000,1)
				end
			end
			
		end
	end
end)

addEvent("Update->Hospital->Time",true)
addEventHandler("Update->Hospital->Time",root,function()
	setData(client,"Hospitaltime",tonumber(getData(client,"Hospitaltime"))-1)
	if(tonumber(getData(client,"Hospitaltime"))<1)then
		setData(client,"Hospitaltime",0)
	end
end)

addEvent("Kick->Player->Highping",true)
addEventHandler("Kick->Player->Highping",root,function(ping)
	kickPlayer(client,"Highping kick! (x"..ping..")")
end)











local activated={}
local normalagaintimer={}
local crouching={}


local function normalAgain ( player )
	if isElement ( player ) then
		setControlState ( player, "crouch", crouching[player] or false )
		toggleControl ( player, "crouch", true )
	end
end


local function crouch ( player, _, state )
	if activated[player] then
		crouching[player] = state == "down"
	end
end


addEventHandler("onPlayerWeaponFire", root, function ( weapon )
	if activated[source] then
		if weapon == 24 then	
			setControlState ( source, "crouch", false )
			toggleControl ( source, "crouch", false )
			if isTimer ( normalagaintimer[source] ) then
				killTimer ( normalagaintimer[source] )
			end
			normalagaintimer[source] = setTimer ( normalAgain, 722, 1, source )
		end
	end
end)

function toggleAntiFastshot(player, activate )
	activated[player]=activate
	if activate and not isKeyBound(player,"crouch","both",crouch)then
		bindKey(player,"crouch","both",crouch)
	end
end