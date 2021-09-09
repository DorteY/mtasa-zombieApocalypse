--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local Settings={
	lastTick=getTickCount(),
	FPS=0,
	framesRendered=0,
	DisabledHudComponents={
		"ammo",
		"armour",
		"clock",
		"health",
		"money",
		"weapon",
		"wanted",
		"area_name",
		"vehicle_name",
		"breath",
		"clock",
		"ammo",
		"radar",
	},
}

addEventHandler("onClientRender",root,function()
	for i=1,#Settings.DisabledHudComponents do
		setPlayerHudComponentVisible(Settings.DisabledHudComponents[i],false)
	end
	toggleControl("radar",false)
	if(not isLoggedin())then
		return
	end
	if(isPedDead(localPlayer))then
		return
	end
	if(isMainMenuActive()==true)then
		return
	end
	
	local currentTick=getTickCount()
	local elapsedTime=currentTick-Settings.lastTick
	if(elapsedTime>=1000)then
		Settings.FPS=Settings.framesRendered
		Settings.lastTick=currentTick
		Settings.framesRendered=2
	else
		Settings.framesRendered=Settings.framesRendered+1
	end
	if(Settings.FPS>100)then
		Settings.FPS=100
	end
	
	local ping=getPlayerPing(localPlayer)or 0
	local weaponID=getPedWeapon(localPlayer)or 0
	local armor=math.floor(getPedArmor(localPlayer))or 0
	local armor2=math.floor(getPedArmor(localPlayer))or 0
	local health=math.floor(getElementHealth(localPlayer))or 0
	local health2=math.floor(getElementHealth(localPlayer))or 0
	local hunger=tonumber(getData(localPlayer,"Hunger"))or 0
	local hunger2=tonumber(getData(localPlayer,"Hunger"))or 0
	local thirst=tonumber(getData(localPlayer,"Thirst"))or 0
	local thirst2=tonumber(getData(localPlayer,"Thirst"))or 0
	local coins=tonumber(getData(localPlayer,"Coins"))or 0
	local level=tonumber(getData(localPlayer,"Level"))or 0
	local expp=tonumber(getData(localPlayer,"EXP"))or 0
	local expp2=tonumber(getData(localPlayer,"EXP"))or 0
	
	local armor=210/100*armor
	local health=210/100*health
	local hunger=210/100*hunger
	local thirst=210/100*thirst
	local expp=210/Server.LevelEXP[tonumber(level)]*expp
	
	local pingRGB=getPingColor(ping)
	
	dxDrawRectangle(1610*Gsx,10*Gsy,300*Gsx,280*Gsy,tocolor(25,25,25,230),false)
	
	dxDrawRectangle(1680*Gsx,30*Gsy,210*Gsx,30*Gsy,tocolor(0,140,140,255),false)
	dxDrawRectangle(1680*Gsx,30*Gsy,armor*Gsx,30*Gsy,tocolor(0,200,200,255),false)
	dxDrawImage(1630*Gsx,30*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Armor.png",0,0,0,tocolor(255,255,255,255),false)
	
	dxDrawRectangle(1680*Gsx,70*Gsy,210*Gsx,30*Gsy,tocolor(140,0,0,255),false)
	dxDrawRectangle(1680*Gsx,70*Gsy,health*Gsx,30*Gsy,tocolor(200,0,0,255),false)
	dxDrawImage(1630*Gsx,70*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Health.png",0,0,0,tocolor(255,255,255,255),false)
	
	dxDrawRectangle(1680*Gsx,110*Gsy,210*Gsx,30*Gsy,tocolor(0,140,0,255),false)
	dxDrawRectangle(1680*Gsx,110*Gsy,hunger*Gsx,30*Gsy,tocolor(0,200,0,255),false)
	dxDrawImage(1630*Gsx,110*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Hunger.png",0,0,0,tocolor(255,255,255,255),false)
	
	dxDrawRectangle(1680*Gsx,150*Gsy,210*Gsx,30*Gsy,tocolor(140,140,0,255),false)
	dxDrawRectangle(1680*Gsx,150*Gsy,thirst*Gsx,30*Gsy,tocolor(200,200,0,255),false)
	dxDrawImage(1630*Gsx,150*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Thirst.png",0,0,0,tocolor(255,255,255,255),false)
	
	dxDrawRectangle(1680*Gsx,190*Gsy,210*Gsx,30*Gsy,tocolor(140,140,140,255),false)
	dxDrawRectangle(1680*Gsx,190*Gsy,expp*Gsx,30*Gsy,tocolor(200,200,200,255),false)
	dxDrawImage(1630*Gsx,190*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Circle.png",0,0,0,tocolor(255,255,255,255),false)
	dxDrawText(level,3255*Gsx,195*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20,"default","center",_,_,_,false,_,_)
	dxDrawText(expp2.." / "..Server.LevelEXP[level],3540*Gsx,195*Gsy,30*Gsx,30*Gsy,tocolor(0,0,0,255),1.20,"default","center",_,_,_,false,_,_)
	
	dxDrawImage(1630*Gsx,250*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Coins.png",0,0,0,tocolor(255,255,255,255),false)
	dxDrawText(coins,1675*Gsx,250*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.40,"default","left",_,_,_,false,_,_)
	
	dxDrawRectangle(1610*Gsx,310*Gsy,300*Gsx,50*Gsy,tocolor(25,25,25,230),false)--
	
	dxDrawImage(1630*Gsx,320*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/FPS.png",0,0,0,tocolor(255,255,255,255),false)
	dxDrawText(Settings.FPS,1675*Gsx,325*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.40,"default","left",_,_,_,false,_,_)
	
	dxDrawImage(1730*Gsx,320*Gsy,30*Gsx,30*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Ping.png",0,0,0,tocolor(255,255,255,255),false)
	dxDrawText(ping,1770*Gsx,325*Gsy,30*Gsx,30*Gsy,tocolor(pingRGB[1],pingRGB[2],pingRGB[3],255),1.20,"default","left",_,_,_,false,_,_)
	
	dxDrawImage(1500*Gsx,10*Gsy,100*Gsx,100*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Weapons/"..weaponID..".png",0,0,0,tocolor(255,255,255,200),false)
	if(weaponID==0)then
		dxDrawText("Melee",3060*Gsx,125*Gsy,30*Gsx,30*Gsy,tocolor(255,255,225,255),1.00,"sans","center",_,_,_,false,_,_)
	else
		dxDrawText(getPedAmmoInClip(localPlayer).." | "..getPedTotalAmmo(localPlayer)-getPedAmmoInClip(localPlayer),3060*Gsx,125*Gsy,30*Gsx,30*Gsy,tocolor(255,255,225,255),1.00,"sans","center",_,_,_,false,_,_)
	end
	
	if(getData(localPlayer,"BoosttimeMoney20")>=1)then
		dxDrawImage(10*Gsx,650*Gsy,65*Gsx,65*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Boost/Boost_Money_20.png",0,0,0,tocolor(255,255,255,255),false)
	end
	--if(getData(localPlayer,"BoosttimeMoney50")>=1)then
	--	dxDrawImage(10*Gsx,540*Gsy,65*Gsx,65*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Boost/Boost_Money_50.png",0,0,0,tocolor(255,255,255,255),false)
	--end
	--
	--if(getData(localPlayer,"BoosttimeEXP20")>=1)then
	--	dxDrawImage(10*Gsx,630*Gsy,65*Gsx,65*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Boost/Boost_EXP_20.png",0,0,0,tocolor(255,255,255,255),false)
	--end
	--
	--if(getData(localPlayer,"BoosttimeEXP50")>=1)then
	--	dxDrawImage(10*Gsx,740*Gsy,65*Gsx,65*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Boost/Boost_EXP_50.png",0,0,0,tocolor(255,255,255,255),false)
	--end
	
	
	
	--if(getData(localPlayer,"BoosttimeMoney20")>=1)then
	--	dxDrawText("Coin Boost 20% - "..getData(localPlayer,"BoosttimeMoney20").." minutes",270*Gsx,600*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.40,"default","center",_,_,_,false,_,_)
	--end
	--if(getData(localPlayer,"BoosttimeMoney50")>=1)then
	--	dxDrawText("Coin Boost 50% - "..getData(localPlayer,"BoosttimeMoney50").." minutes",270*Gsx,620*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.40,"default","center",_,_,_,false,_,_)
	--end
	--if(getData(localPlayer,"BoosttimeEXP20")>=1)then
	--	dxDrawText("EXP Boost 20% - "..getData(localPlayer,"BoosttimeEXP20").." minutes",270*Gsx,640*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.40,"default","center",_,_,_,false,_,_)
	--end
	--if(getData(localPlayer,"BoosttimeEXP50")>=1)then
	--	dxDrawText("EXP Boost 50% - "..getData(localPlayer,"BoosttimeEXP50").." minutes",270*Gsx,660*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255),1.40,"default","center",_,_,_,false,_,_)
	--end
end)

function drawSpeedo()
	local veh=getPedOccupiedVehicle(localPlayer)
	if(veh and isElement(veh))then
		local vehspeed=getElementSpeed(veh,"km/h")or 0
		
		dxDrawImage(1600*Gsx,780*Gsy,300*Gsx,300*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Speedo/Background.png",0,0,0,tocolor(255,255,255,255),false)
		dxDrawImage(1600*Gsx,780*Gsy,300*Gsx,300*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Speedo/BackgroundNumbers.png",0,0,0,tocolor(255,255,255,255),false)
		dxDrawImage(1600*Gsx,780*Gsy,300*Gsx,300*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Speedo/Needle.png",-130+vehspeed*0.7,0,0,tocolor(255,255,255,255),false)
		
		dxDrawText(math.floor(vehspeed).."\nkm/h",3200*Gsx,1010*Gsy,300*Gsx,300*Gsy,tocolor(255,255,255,255),0.90,"pricedown","center",_,_,_,false,_,_)
		
		
		local maxliter=getVehicleFuelSizeUsage(veh)
		currentLiter=(100/maxliter)*tonumber(getElementData(veh,"veh:fuel"))or 0
		
		dxDrawImage(1450*Gsx,950*Gsy,120*Gsx,120*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Speedo/BackgroundFuel.png",0,0,0,tocolor(255,255,255,255),false)
		dxDrawImage(1450*Gsx,950*Gsy,120*Gsx,120*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Speedo/FuelNumbers.png",0,0,0,tocolor(255,255,255,255),false)
		dxDrawImage(1450*Gsx,950*Gsy,120*Gsx,120*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Hud/Speedo/NeedleFuel.png",-90+1.8*currentLiter-1.8,0,0,tocolor(255,255,255,255),false)
	else
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end

addEventHandler("onClientVehicleEnter",root,function(player)
	if(player==localPlayer)then
		removeEventHandler("onClientRender",root,drawSpeedo)
		addEventHandler("onClientRender",root,drawSpeedo)
	end
end)
addEventHandler("onClientPlayerWasted",root,function(player)
	if(player==localPlayer)then
		removeEventHandler("onClientRender",root,drawSpeedo)
	end
end)



--//Draw Kills
local killDrawTimer=nil

addEvent("Draw->Kill->UI",true)
addEventHandler("Draw->Kill->UI",root,function(typ)
	local TimerInfoStart=2
	
	if(isTimer(killDrawTimer))then
		killTimer(killDrawTimer)
		killDrawTimer=nil
		removeEventHandler("onClientRender",root,drawKillDisplay)
	end
	removeEventHandler("onClientRender",root,drawKillDisplay)
	addEventHandler("onClientRender",root,drawKillDisplay)
	
	if(typ=="Zombie")then
		killDrawText="Zombie"
	else
		killDrawText="Player"
	end
	
	killDrawTimer=setTimer(function()
		TimerInfoStart=TimerInfoStart-1
		if(TimerInfoStart==0)then
			removeEventHandler("onClientRender",root,drawKillDisplay)
			if(isTimer(killDrawTimer))then
				killTimer(killDrawTimer)
				killDrawTimer=nil
				removeEventHandler("onClientRender",root,drawKillDisplay)
			end
		end
	end,1000,TimerInfoStart)
end)


function drawKillDisplay()
	dxDrawText("+1 "..killDrawText.." Kill",500*Gsx,400*Gsy,100*Gsx,20*Gsy,tocolor(255,0,0,255),2*Gsx,"default-bold","center",_,_,_,false,_,_)
end