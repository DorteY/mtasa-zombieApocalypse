local playerTable={}
local Settings={
	HudState=true,
	Bindkey="TAB",
	ScrollNumber=0,
	Progress=0,
	DisabledControls={
		"radio_next",
		"radio_previous",
		"aim_weapon",
		"previous_weapon",
		"next_weapon",
		"fire",
	},
}

function refreshTablist()
	if(isLoggedin())then
		playerTable={}
		local i=0
		for i,v in ipairs(getElementsByType("player"))do
			local name=getPlayerName(v)or "none"
			local ping=getPlayerPing(v)or 0
			local afk=getData(v,"AFK")or false
			local premium=tonumber(getData(v,"Premium"))or 0
			local playtime=tonumber(getData(v,"Playtime"))or 0
			local playtimeD=math.floor(playtime/60)..":"..(playtime-math.floor(playtime/60)*60)or 0
			local kills=tonumber(getData(v,"Kills"))or 0
			local deaths=tonumber(getData(v,"Deaths"))or 0
			local zombkills=tonumber(getData(v,"ZombieKills"))or 0
			
			playerTable[i]={}
			playerTable[i].name=name
			playerTable[i].afk=afk
			playerTable[i].ping=ping
			playerTable[i].premium=premium
			playerTable[i].playtimeD=playtimeD
			playerTable[i].kills=kills
			playerTable[i].deaths=deaths
			playerTable[i].zombkills=zombkills
			
			i=i+1
		end
		table.sort(playerTable,function(a,b)
			return a.name<b.name
		end)
	end
end

function drawTablist()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	if(isPlayerMapVisible(localPlayer)==true)then
		return
	end
	if(Settings.HudState==true)then
		if(Settings.Progress<1)then
			Settings.Progress=Settings.Progress+0.02
		end
	elseif(Settings.HudState==false)then
		if(Settings.Progress>0)then
			Settings.Progress=Settings.Progress-0.02
			if(Settings.Progress==3)then
				removeEventHandler("onClientRender",root,drawTablist)
			end
		end
	end
	moveX,moveY,moveZ=interpolateBetween(0,-500,0,0,GLOBALscreen[2]/2-350/2,0,Settings.Progress,"Linear")
	
	di=0
	dxDrawRectangle(GLOBALscreen[1]/2-550/2,moveY,550,350,UI.Color.BG,_)
	dxDrawRectangle(GLOBALscreen[1]/2-550/2,moveY,550,35,UI.Color.Bar,_)
	dxDrawText("Tablist (Scoreboard)",GLOBALscreen[1]/2-550/2+700,moveY+9,550,350,tocolor(255,255,255,255),1.15,"arial","center",_,_,_,false,_,_)
	dxDrawText("Name",GLOBALscreen[1]/2-550/2+20,moveY+45,550,350,tocolor(255,255,255,255),1.15,"arial","left",_,_,_,false,_,_)
	dxDrawText(getLanguageWord(localPlayer,"Client","General","LABEL_Playtime"),GLOBALscreen[1]/2-550/2+160,moveY+45,550,350,tocolor(255,255,255,255),1.15,"arial","left",_,_,_,false,_,_)
	dxDrawText(getLanguageWord(localPlayer,"Client","General","LABEL_Kills"),GLOBALscreen[1]/2-550/2+250,moveY+45,550,350,tocolor(255,255,255,255),1.15,"arial","left",_,_,_,false,_,_)
	dxDrawText(getLanguageWord(localPlayer,"Client","General","LABEL_Deaths"),GLOBALscreen[1]/2-550/2+320,moveY+45,550,350,tocolor(255,255,255,255),1.15,"arial","left",_,_,_,false,_,_)
	dxDrawText("ZombieKills",GLOBALscreen[1]/2-550/2+410,moveY+45,550,350,tocolor(255,255,255,255),1.15,"arial","left",_,_,_,false,_,_)
	dxDrawText("Ping",GLOBALscreen[1]/2-550/2+510,moveY+45,550,350,tocolor(255,255,255,255),1.15,"arial","left",_,_,_,false,_,_)
	
	for i=0+Settings.ScrollNumber,10+Settings.ScrollNumber do
		if(playerTable[i])then
			local Nametag=""
			local pingRGB=getPingColor(playerTable[i].ping)
			
			dxDrawRectangle(GLOBALscreen[1]/2-550/2+5,moveY+80+(di*25),540,25,tocolor(0,0,0,255),_)
			if(playerTable[i].afk and playerTable[i].afk==true)then
				Nametag="[AFK]"
			end
			if(tonumber(playerTable[i].premium)==1)then
				dxDrawText(playerTable[i].name,GLOBALscreen[1]/2-550/2+35,moveY+85+(di*25),550,350,tocolor(255,255,255,255),1.10,"arial","left",_,_,_,false,_,_)
				dxDrawImage(GLOBALscreen[1]/2-550/2+7,moveY+81+(di*25),20,20,":"..getResourceName(getThisResource()).."/Files/Images/VIP.png",0,0,0,tocolor(255,255,255,255),false)
			else
				dxDrawText(Nametag.." "..playerTable[i].name,GLOBALscreen[1]/2-550/2+20,moveY+85+(di*25),550,350,tocolor(255,255,255,255),1.10,"arial","left",_,_,_,false,_,_)
			end
			dxDrawText(playerTable[i].playtimeD,GLOBALscreen[1]/2-550/2+160,moveY+85+(di*25),550,350,tocolor(255,255,255,255),1.10,"arial","left",_,_,_,false,_,_)
			dxDrawText(playerTable[i].kills,GLOBALscreen[1]/2-550/2+250,moveY+85+(di*25),550,350,tocolor(255,255,255,255),1.10,"arial","left",_,_,_,false,_,_)
			dxDrawText(playerTable[i].deaths,GLOBALscreen[1]/2-550/2+320,moveY+85+(di*25),550,350,tocolor(255,255,255,255),1.10,"arial","left",_,_,_,false,_,_)
			dxDrawText(playerTable[i].zombkills,GLOBALscreen[1]/2-550/2+410,moveY+85+(di*25),550,350,tocolor(255,255,255,255),1.10,"arial","left",_,_,_,false,_,_)
			dxDrawText(playerTable[i].ping,GLOBALscreen[1]/2-550/2+510,moveY+85+(di*25),550,350,tocolor(pingRGB[1],pingRGB[2],pingRGB[3],255),1.10,"arial","left",_,_,_,false,_,_)
			
			di=di+1
		end
	end
end

--//Scroll funcs
function scrollDown()
	if(#getElementsByType("player")-Settings.ScrollNumber<2)then
		Settings.ScrollNumber=#getElementsByType("player")
	else
		Settings.ScrollNumber=Settings.ScrollNumber+2
	end
end

function scrollUp()
	if(Settings.ScrollNumber<=2)then
		Settings.ScrollNumber=0
	else
		Settings.ScrollNumber=Settings.ScrollNumber-2
	end
end

--//Open/Close funcs
bindKey(Settings.Bindkey,"down",function()
	removeEventHandler("onClientRender",root,drawTablist)
	addEventHandler("onClientRender",root,drawTablist)
	bindKey("mouse_wheel_down","down",scrollDown)
	bindKey("mouse_wheel_up","down",scrollUp)
	for i,v in pairs(Settings.DisabledControls)do
		toggleControl(v,false)
	end
	if(isTimer(updateTimer))then
		killTimer(updateTimer)
	end
	Settings.HudState=true
	refreshTablist()
	updateTimer=setTimer(refreshTablist,250,0)
end)
bindKey(Settings.Bindkey,"up",function()
	unbindKey("mouse_wheel_down","down",scrollDown)
	unbindKey("mouse_wheel_up","down",scrollUp)
	for i,v in pairs(Settings.DisabledControls)do
		toggleControl(v,true)
	end
	Settings.HudState=false
	di=0
	i=0
end)