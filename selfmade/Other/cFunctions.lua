--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local Pfad=getResourceName(getThisResource())
--//Sound system
local SoundTable={}

addEvent("play:stop:sound",true)
addEventHandler("play:stop:sound",root,function(typ,x,y,z,loop,file,volume)
	if(typ=="play")then
		local vehicle=getPedOccupiedVehicle(localPlayer)
		
		if(SoundTable[file]~=nil and isElement(SoundTable[file]))then
			stopSound(SoundTable[file])
			SoundTable[file]=nil
		end
		if(loop==nil)then
			loop=false
		end
		if(volume==nil)then
			volume=0.5
		end
		
		if(x~=nil and y~=nil and z~=nil)then
			SoundTable[file]=playSound3D(":"..Pfad.."/Files/Sounds/"..file,x,y,z,loop)
		else
			SoundTable[file]=playSound(":"..Pfad.."/Files/Sounds/"..file,loop)
		end
		setSoundVolume(SoundTable[file],volume)
		
		if(vehicle)then
			attachElements(SoundTable[file],vehicle)
		end
	elseif(typ=="stop")then
		if(SoundTable[file]~=nil and isElement(SoundTable[file]))then
			stopSound(SoundTable[file])
			SoundTable[file]=nil
		end
	end
end)

--//Helpmenu
function createHelpmenuUI()
	if(not isLoggedin())then
		return
	end
	if(isPedInVehicle(localPlayer))then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-550/2,GLOBALscreen[2]/2-380/2,550,380,Server.Name.." - Helpmenu",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(517,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	UI.Tabpanel[1]=dgsCreateTabPanel(10,10,530,310,false,UI.Window[1],25,_,tocolor(0,0,0,255))
	UI.Tab[1]=dgsCreateTab("Main",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	UI.Label[1]=dgsCreateLabel(10,10,200,20,getLanguageWord(localPlayer,"Client","Helpmenu","LABEL_1"),false,UI.Tab[1],_,1.2,1.2)
	
	UI.Tab[2]=dgsCreateTab("Bindkeys/Commands",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	UI.Label[2]=dgsCreateLabel(10,10,200,20,"Bindkeys:\n\n'F1' - Helpmenu\n'F5' - Movable Interface\n'K' - Start/Stop vehicle engine\n'L' - turn On/Off vehicle lights\n'I' - Inventory\n'U' - Shop\n'BACKSPACE' - Close UI",false,UI.Tab[2],_,1.2,1.2)
	UI.Label[22]=dgsCreateLabel(300,10,200,20,"Commands:\n\n'/settings' - Settings panel\n'/language German/English'",false,UI.Tab[2],_,1.2,1.2)
	
	
	addEventHandler("onDgsMouseClick",UI.Button["Close"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				setUIdatas("rem","cursor")
			end
		end,
	false)
end

function createSettingsUI()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-400/2,GLOBALscreen[2]/2-360/2,400,360,Server.Name.." - Settings",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(367,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	UI.Tabpanel[1]=dgsCreateTabPanel(10,10,380,295,false,UI.Window[1],25,_,UI.Color.TabBG)
	UI.Tab[1]=dgsCreateTab("Render",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	
	dgsCreateLabel(15,25,100,20,"World Render distance (2000-60000)",false,UI.Tab[1],_,1,1)
	UI.Label[1]=dgsCreateLabel(240,25,100,20,getLanguageWord(localPlayer,"Client","General","LABEL_YourDistance")..": "..tonumber(getData(localPlayer,"RenderdistanceWorld")),false,UI.Tab[1],_,1,1)
	UI.Edit[1]=dgsCreateEdit(10,40,360,40,"",false,UI.Tab[1],tocolor(255,255,255,255),_,_,_,UI.Color.TabBG)
	UI.Button[1]=dgsCreateButton(10,85,360,40,"Set distance",false,UI.Tab[1],_,1.1,1.1,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
	
	dgsCreateLabel(15,160,100,20,"Custom Render distance (100-1000)",false,UI.Tab[1],_,1,1)
	UI.Label[1]=dgsCreateLabel(240,160,100,20,getLanguageWord(localPlayer,"Client","General","LABEL_YourDistance")..": "..tonumber(getData(localPlayer,"RenderdistanceCustom")),false,UI.Tab[1],_,1,1)
	UI.Edit[2]=dgsCreateEdit(10,175,360,40,"",false,UI.Tab[1],tocolor(255,255,255,255),_,_,_,UI.Color.TabBG)
	UI.Button[2]=dgsCreateButton(10,220,360,40,"Set distance",false,UI.Tab[1],_,1.1,1.1,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
	
	addEventHandler("onDgsMouseClick",UI.Button[2],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local amount=dgsGetText(UI.Edit[2])
				if(tonumber(amount)>=100 and tonumber(amount)<=1000 and isOnlyNumbers(amount))then
					triggerServerEvent("Change->Settings",localPlayer,"RenderCustom",amount)
					for i=1,#modsTableFile do
						engineSetModelLODDistance(tonumber(modsTableFile[i].modelid),amount)
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local amount=dgsGetText(UI.Edit[1])
				if(tonumber(amount)>=2000 and tonumber(amount)<=60000 and isOnlyNumbers(amount))then
					triggerServerEvent("Change->Settings",localPlayer,"RenderWorld",amount)
					setFarClipDistance(amount)
				end
			end
		end,
	false)
	--
	UI.Tab[2]=dgsCreateTab("Hitbell",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	
	if(tonumber(getData(localPlayer,"Hitglocke"))~=4)then
		UI.Label[1]=dgsCreateLabel(10,25,100,20,"Hitbell: "..tonumber(getData(localPlayer,"Hitglocke")),false,UI.Tab[2],_,1,1)
	else
		UI.Label[1]=dgsCreateLabel(10,25,100,20,"Hitbell: Off",false,UI.Tab[2],_,1,1)
	end
	
	UI.Combo[1]=dgsCreateComboBox(10,45,360,40,"Select "..getLanguageWord(localPlayer,"Client","General","LABEL_Hitbell"),false,UI.Tab[2],20,tocolor(200,200,200,255),_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255))
	dgsComboBoxAddItem(UI.Combo[1],getLanguageWord(localPlayer,"Client","General","LABEL_Hitbell").." 1")
	dgsComboBoxAddItem(UI.Combo[1],getLanguageWord(localPlayer,"Client","General","LABEL_Hitbell").." 2")
	dgsComboBoxAddItem(UI.Combo[1],getLanguageWord(localPlayer,"Client","General","LABEL_Hitbell").." 3")
	dgsComboBoxAddItem(UI.Combo[1],getLanguageWord(localPlayer,"Client","General","LABEL_Hitbell").." Off")
	
	UI.Button[3]=dgsCreateButton(10,220,360,40,"Select "..getLanguageWord(localPlayer,"Client","General","LABEL_Hitbell"),false,UI.Tab[2],_,1.1,1.1,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
	
	addEventHandler("onDgsMouseClick",UI.Button[3],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local amount=dgsComboBoxGetSelectedItem(UI.Combo[1])
				if(tonumber(amount)and isOnlyNumbers(amount))then
					triggerServerEvent("Change->Settings",localPlayer,"Hitglocke",amount)
				end
			end
		end,
	false)
	
	
	
	addEventHandler("onDgsMouseClick",UI.Button["Close"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				setUIdatas("rem","cursor")
			end
		end,
	false)
end
addCommandHandler("settings",createSettingsUI)
addCommandHandler("setting",createSettingsUI)

--//Click funcs
function getCursor()
	if(isLoggedin())then
		if(isClickedState(localPlayer)==false)then
			showCursor(not(isCursorShowing()))
		end
	end
end
bindKey("m","down",getCursor)
bindKey("ralt","down",getCursor)

addEventHandler("onClientRender",root,function()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	if(not isCursorShowing())then
		return
	end
	local x,y,z=getElementPosition(localPlayer)
	local cX,cY,cwX,cwY,cwZ=getCursorPosition()
	local pX,pY,pZ=getCameraMatrix(localPlayer)
	local hit,hX,hY,hZ,hitElement,nX,nY,nZ,material,lightning,piece,worldModelID,worldModelPos,worldModelRot,worldLODModelID=processLineOfSight(pX,pY,pZ,cwX,cwY,cwZ,true,true,true,true,true,false,false,false,nil,true,true)
	local textLeft,textMiddle,textRight,show=".",".",".",false
	if(not hX or not hY or not hZ or getDistanceBetweenPoints3D(x,y,z,hX,hY,hZ)<10)then
		local modelID=0
		local eType=""
		if(hitElement)then
			modelID=getElementModel(hitElement)
			eType=getElementType(hitElement)
		else
			modelID=worldModelID
			eType="object"
			hitElement=nil
		end
		
		if(eType=="object")then
			if(modelID==2969)then
				textLeft="Lootbox"
				show=true
			end
		end
		if(show==true)then
			if(textLeft)then
				dxDrawImage((GLOBALscreen[1]*cX)-50,(GLOBALscreen[2]*cY)-6,32,32,":"..getResourceName(getThisResource()).."/Files/Images/Keys/MouseL.png")
				dxDrawText(textLeft,GLOBALscreen[1]*cX-100+1,GLOBALscreen[2]*cY+25+1,GLOBALscreen[1]*cX+34+1,GLOBALscreen[2]*cY+66+1,tocolor(0,0,0),1,"default-bold","center","top")
				dxDrawText(textLeft,GLOBALscreen[1]*cX-100,GLOBALscreen[2]*cY+25,GLOBALscreen[1]*cX+34,GLOBALscreen[2]*cY+66,tocolor(255,255,255),1,"default-bold","center","top")
			end
		end
	end
end)

setCursorAlpha(0)
addEventHandler("onClientRender",root,function()
	if(not isCursorShowing())then
		return
	end
	if(isConsoleActive()==true)then
		return
	end
	if(isMainMenuActive()==true)then
		return
	end
	if(isChatBoxInputActive()==true)then
		return
	end
	local sX,sY,wX,wY,wZ=getCursorPosition()
	dxDrawImage(sX*GLOBALscreen[1],sY*GLOBALscreen[2],32,32,":"..getResourceName(getThisResource()).."/Files/Images/Cursor.png",0,0,0,tocolor(255,255,255),true)
end)
addEventHandler("onClientResourceStop",getResourceRootElement(getThisResource()),function()
	setCursorAlpha(255)
end)

--//Savezone
local alphac=0
local unrender=false

function openSavezone()
	if(alphac<1 and unrender==false)then
		alphac=alphac+0.01
	elseif(alphac>0 and unrender==true)then
		alphac=alphac-0.01
	elseif(alphac==0 and unrender==true)then
		removeEventHandler("onClientRender",root,openSavezone)
		unrender=false
	end
	if(isPlayerMapVisible(localPlayer)==false)then
		if(not(isPedDead(localPlayer)))then
			dxDrawRectangle(1610*Gsx,380*Gsy,300*Gsx,100*Gsy,tocolor(200,0,0,140*alphac),false)
			dxDrawText("No-Dm-Zone",3490*Gsx,390*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*alphac),1.70,"default","center",_,_,_,false,_,_)
			dxDrawText(getLanguageWord(localPlayer,"Client","General","LABEL_NoDeathmatch"),3490*Gsx,430*Gsy,30*Gsx,30*Gsy,tocolor(255,255,255,255*alphac),1.10*Gsx,"default","center")
		end
	end
end
addEvent("Create->Savezone->UI",true)
addEventHandler("Create->Savezone->UI",root,function()
	if(unrender==true and alphac~=0)then
		unrender=false
	else
		unrender=false
		removeEventHandler("onClientRender",root,openSavezone)
		addEventHandler("onClientRender",root,openSavezone)
	end
end)
addEvent("Destroy->Savezone->UI",true)
addEventHandler("Destroy->Savezone->UI",root,function()
	unrender=true
end)

--//Textures
modsTableFile={
	{txdpfad="Files/Models/fire.txd",dffpfad="Files/Models/fire.dff",colpfad="Files/Models/fire.col",modelid=3900},
	{txdpfad="Files/Models/hangar.txd",dffpfad="Files/Models/hangar.dff",colpfad="Files/Models/hangar.col",modelid=3899},
	{txdpfad="Files/Models/baracke.txd",dffpfad="Files/Models/baracke.dff",colpfad="Files/Models/baracke.col",modelid=3951},
	{txdpfad="Files/Models/fence.txd",dffpfad="Files/Models/fence.dff",colpfad="Files/Models/fence.col",modelid=14566},
	{txdpfad="Files/Models/firetruck.txd",dffpfad="Files/Models/firetruck.dff",colpfad="Files/Models/firetruck.col",modelid=2401},
	{txdpfad="Files/Models/hospital.txd",dffpfad="Files/Models/hospital.dff",colpfad="Files/Models/hospital.col",modelid=2324},
	{txdpfad="Files/Models/policecar.txd",dffpfad="Files/Models/policecar.dff",colpfad="Files/Models/policecar.col",modelid=3947},
	{txdpfad="Files/Models/schoolbus.txd",dffpfad="Files/Models/schoolbus.dff",colpfad="Files/Models/schoolbus.col",modelid=2979},
	{txdpfad="Files/Models/civicar.txd",dffpfad="Files/Models/civicar.dff",colpfad="Files/Models/civicar.col",modelid=3949},
	{txdpfad="Files/Models/busstop.txd",dffpfad="Files/Models/busstop.dff",colpfad="Files/Models/busstop.col",modelid=14622},
	{txdpfad="Files/Models/pinwheel.txd",dffpfad="Files/Models/pinwheel.dff",colpfad="Files/Models/pinwheel.col",modelid=2992},
	{txdpfad="Files/Models/transporter.txd",dffpfad="Files/Models/transporter.dff",colpfad="Files/Models/transporter.col",modelid=2689},
	{txdpfad="Files/Models/tower.txd",dffpfad="Files/Models/tower.dff",colpfad="Files/Models/tower.col",modelid=2754},
	{txdpfad="Files/Models/taxicar.txd",dffpfad="Files/Models/taxicar.dff",colpfad="Files/Models/taxicar.col",modelid=3938},
	{txdpfad="Files/Models/police.txd",dffpfad="Files/Models/police.dff",colpfad="Files/Models/police.col",modelid=2779},
	
	{txdpfad="Files/Models/Skins/Players/7.txd",dffpfad="Files/Models/Skins/Players/7.dff",colpfad=nil,modelid=7},
	{txdpfad="Files/Models/Skins/Players/11.txd",dffpfad="Files/Models/Skins/Players/11.dff",colpfad=nil,modelid=11},
	{txdpfad="Files/Models/Skins/Players/12.txd",dffpfad="Files/Models/Skins/Players/12.dff",colpfad=nil,modelid=12},
	{txdpfad="Files/Models/Skins/Players/13.txd",dffpfad="Files/Models/Skins/Players/13.dff",colpfad=nil,modelid=13},
	{txdpfad="Files/Models/Skins/Players/31.txd",dffpfad="Files/Models/Skins/Players/31.dff",colpfad=nil,modelid=31},
	
	{txdpfad="Files/Models/Vehicles/411.txd",dffpfad="Files/Models/Vehicles/411.dff",colpfad=nil,modelid=411},
	{txdpfad="Files/Models/Vehicles/575.txd",dffpfad="Files/Models/Vehicles/575.dff",colpfad=nil,modelid=575},
	{txdpfad="Files/Models/Vehicles/558.txd",dffpfad="Files/Models/Vehicles/558.dff",colpfad=nil,modelid=558},
	{txdpfad="Files/Models/Vehicles/542.txd",dffpfad="Files/Models/Vehicles/542.dff",colpfad=nil,modelid=542},
	{txdpfad="Files/Models/Vehicles/547.txd",dffpfad="Files/Models/Vehicles/547.dff",colpfad=nil,modelid=547},
	{txdpfad="Files/Models/Vehicles/433.txd",dffpfad="Files/Models/Vehicles/433.dff",colpfad=nil,modelid=433},
	{txdpfad="Files/Models/Vehicles/527.txd",dffpfad="Files/Models/Vehicles/527.dff",colpfad=nil,modelid=527},
	{txdpfad="Files/Models/Vehicles/445.txd",dffpfad="Files/Models/Vehicles/445.dff",colpfad=nil,modelid=445},
	{txdpfad="Files/Models/Vehicles/549.txd",dffpfad="Files/Models/Vehicles/549.dff",colpfad=nil,modelid=549},
	
	{txdpfad="Files/Models/Weapons/AK74.txd",dffpfad="Files/Models/Weapons/AK74.dff",colpfad=nil,modelid=355},
	{txdpfad="Files/Models/Weapons/M4.txd",dffpfad="Files/Models/Weapons/M4.dff",colpfad=nil,modelid=356},
	{txdpfad="Files/Models/Weapons/Colt45.txd",dffpfad="Files/Models/Weapons/Colt45.dff",colpfad=nil,modelid=346},
	{txdpfad="Files/Models/Weapons/Deagle.txd",dffpfad="Files/Models/Weapons/Deagle.dff",colpfad=nil,modelid=348},
	{txdpfad="Files/Models/Weapons/MP5.txd",dffpfad="Files/Models/Weapons/MP5.dff",colpfad=nil,modelid=353},
	{txdpfad="Files/Models/Weapons/Sniper.txd",dffpfad="Files/Models/Weapons/Sniper.dff",colpfad=nil,modelid=358},
	{txdpfad="Files/Models/Weapons/Shotgun.txd",dffpfad="Files/Models/Weapons/Shotgun.dff",colpfad=nil,modelid=349},
	{txdpfad="Files/Models/Weapons/Rifle.txd",dffpfad="Files/Models/Weapons/Rifle.dff",colpfad=nil,modelid=357},
	{txdpfad="Files/Models/Weapons/Satchel.txd",dffpfad="Files/Models/Weapons/Satchel.dff",colpfad=nil,modelid=363},
	{txdpfad="Files/Models/Weapons/Bomb.txd",dffpfad="Files/Models/Weapons/Bomb.dff",colpfad=nil,modelid=364},
	{txdpfad="Files/Models/Weapons/RocketLauncher.txd",dffpfad="Files/Models/Weapons/RocketLauncher.dff",colpfad=nil,modelid=359},
	{txdpfad="Files/Models/Weapons/RocketLauncherHS.txd",dffpfad="Files/Models/Weapons/RocketLauncherHS.dff",colpfad=nil,modelid=360},
	{txdpfad="Files/Models/Weapons/Molotov.txd",dffpfad="Files/Models/Weapons/Molotov.dff",colpfad=nil,modelid=344},
	{txdpfad="Files/Models/Weapons/Grenade.txd",dffpfad="Files/Models/Weapons/Grenade.dff",colpfad=nil,modelid=342},
	{txdpfad="Files/Models/Weapons/Flamethrower.txd",dffpfad="Files/Models/Weapons/Flamethrower.dff",colpfad=nil,modelid=361},
	{txdpfad="Files/Models/Weapons/CombatShotgun.txd",dffpfad="Files/Models/Weapons/CombatShotgun.dff",colpfad=nil,modelid=351},
}

addEvent("cdn:onClientReady",true)
addEventHandler("cdn:onClientReady",resourceRoot,function()
	for i=1,#modsTableFile do
		if(modsTableFile[i].txdpfad~=nil)then
			txd=engineLoadTXD(modsTableFile[i].txdpfad)
			engineImportTXD(txd,tonumber(modsTableFile[i].modelid))
		end
		if(modsTableFile[i].dffpfad~=nil)then
			dff=engineLoadDFF(modsTableFile[i].dffpfad,tonumber(modsTableFile[i].modelid))
			engineReplaceModel(dff,tonumber(modsTableFile[i].modelid))
		end
		if(modsTableFile[i].colpfad~=nil)then
			col=engineLoadCOL(modsTableFile[i].colpfad,tonumber(modsTableFile[i].modelid))
			engineReplaceCOL(col,tonumber(modsTableFile[i].modelid))
		end
	end
end)

--//Other funcs
local Timerrrr=nil

addEvent("Draw->Timer->UI",true)
addEventHandler("Draw->Timer->UI",root,function(time)
	if(isTimer(Timerrrr))then
		killTimer(Timerrrr)
		Timerrrr=nil
		removeEventHandler("onClientRender",root,drawTimerDisplay)
	end
	TimerBarStart=time or 0
	TimerBarEnd=time or 0
	
	removeEventHandler("onClientRender",root,drawTimerDisplay)
	addEventHandler("onClientRender",root,drawTimerDisplay)
	Timerrrr=setTimer(function()
		TimerBarStart=TimerBarStart-1
		if(TimerBarStart==0)then
			removeEventHandler("onClientRender",root,drawTimerDisplay)
			if(isTimer(Timerrrr))then
				killTimer(Timerrrr)
				Timerrrr=nil
			end
		end
	end,1000,TimerBarStart)
end)
function drawTimerDisplay()
	if(isLoggedin())then
		if(not(isPedDead(localPlayer)))then
			dxDrawRectangle(1740*Gsx,550*Gsy,180*Gsx,26*Gsy,tocolor(0,0,0,200),false)
			dxDrawRectangle(1745*Gsx,555*Gsy,(TimerBarEnd-TimerBarStart)/TimerBarEnd*170*Gsx,16*Gsy,tocolor(255,255,255,255),false)
		end
	end
end



local firetoggle=false
local frozen=false
addEventHandler("onClientPlayerNetworkStatus",root,function(status)
	if(status==0)then
		if(not isElementFrozen(localPlayer))then
			setElementFrozen(localPlayer,true)
			frozen=true
		end
		if(isControlEnabled("fire"))then
			toggleControl("fire",false)
			firetoggle=true
		end
	elseif(status==1)then
		if(frozen)then
			setElementFrozen(localPlayer,false)
			frozen=false
		end
		if(firetoggle)then
			toggleControl("fire",true)
			firetoggle=false
		end
	end
end)