--//Bloodscreen
local bloodAlpha=0

function showBloodFlash()
	bloodAlpha=255
end

addEventHandler("onClientRender",root,function()
	if(bloodAlpha>0)then
		dxDrawImage(0,0,GLOBALscreen[1],GLOBALscreen[2],":"..getResourceName(getThisResource()).."/Files/Images/Bloodscreen.png",0,0,0,tocolor(255,255,255,bloodAlpha))
		bloodAlpha=math.max(0,bloodAlpha-3)
	end
end)


addEventHandler("onClientPlayerDamage",root,function(attacker,weapon,bodypart,loss)
	if(source==localPlayer)then
		showBloodFlash()
		local ping=getPlayerPing(localPlayer)
		if(ping>=800)then
			triggerServerEvent("Kick->Player->Highping",localPlayer,ping)
		end
	end
	if(attacker==localPlayer)then
		if(source~=lp)then
			if(tonumber(getData(localPlayer,"Hitglocke")))then
				if(tonumber(getData(localPlayer,"Hitglocke"))~=4)then
					local sound=playSound(":"..getResourceName(getThisResource()).."/Files/Sounds/Hitglocke/"..tonumber(getData(localPlayer,"Hitglocke"))..".mp3",false)
					setSoundVolume(sound,0.5)
				end
			end
		end
		if(attacker and weapon and bodypart and loss)then
			if(Server.Weapon.Damage[weapon])then
				triggerServerEvent("Trigger->Damage",localPlayer,attacker,weapon,bodypart,loss,source)
			end
		end
	elseif(localPlayer==source)then
		if(not isPedDead(localPlayer))then
			showBloodFlash()
		end
		if(attacker and weapon and bodypart and loss)then
			if(Server.Weapon.Damage[weapon])then
				cancelEvent()
			end
		end
	end
end)

--//
addEvent("Create->Hospital->UI",true)
addEventHandler("Create->Hospital->UI",root,function(time)
	local deathsound=playSound(":"..getResourceName(getThisResource()).."/Files/Sounds/Wasted.mp3",false)
	setSoundVolume(deathsound,1)
	local x,y,z=getElementPosition(localPlayer)
	if(isTimer(HospitalStartTimer))then
		killTimer(HospitalStartTimer)
	end
	if(isElement(UI.Window[1]))then
		dgsCloseWindow(UI.Window[1])
	end
	HospitalStartTimer=setTimer(function()
		showChat(false)
		setClickedState(localPlayer,true)
		setCameraMatrix(x,y,z+3,x,y,z)
		UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-480/2,20,480,105,Server.Name.." - Hospital",false,tocolor(255,255,255),35,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
		dgsWindowSetSizable(UI.Window[1],false)
		dgsWindowSetMovable(UI.Window[1],false)
		dgsSetProperty(UI.Window[1],"textSize",{1.1,1.1})
		
		
		UI.Label[1]=dgsCreateLabel(190,25,100,20,getLanguageWord(localPlayer,"Client","General","LABEL_Hospital")..": "..time.." "..getLanguageWord(localPlayer,"Client","General","LABEL_Seconds"),false,UI.Window[1],_,1.2,1.2,_,_,_,"center",_)
		
		--UI.Label[2]=dgsCreateLabel(140,150,100,20,"Did you know already?",false,UI.Window[1],_,_,_,_,_,_,"center",_)
		--dgsSetProperty(UI.Label[2],"textSize",{1.3,1.3})
		--UI.Label[3]=dgsCreateLabel(140,220,100,20,othertables["facts"][math.random(1,#othertables["facts"])],false,UI.Window[1],_,_,_,_,_,_,"center",_)
		--dgsSetProperty(UI.Label[3],"textSize",{1.2,1.2})
		
		--changeTextTimer=setTimer(function()
		--	dgsSetText(UI.Label[3],othertables["facts"][math.random(1,#othertables["facts"])])
		--end,6*1000,0)
		
		HospitalTimer=setTimer(function()
			time=time-1
			triggerServerEvent("Update->Hospital->Time",localPlayer,1)
			dgsSetText(UI.Label[1],getLanguageWord(localPlayer,"Client","General","LABEL_Hospital")..": "..time.." "..getLanguageWord(localPlayer,"Client","General","LABEL_Seconds"))
			if(time==0)then
				dgsCloseWindow(UI.Window[1])
				setUIdatas("rem","cursor")
				showChat(true)
				triggerServerEvent("Spawn->Hospital",localPlayer)
				if(isTimer(HospitalTimer))then
					killTimer(HospitalTimer)
					HospitalTimer=nil
				end
				if(isTimer(HospitalStartTimer))then
					killTimer(HospitalStartTimer)
					HospitalStartTimer=nil
				end
				if(isTimer(changeTextTimer))then
					killTimer(changeTextTimer)
					changeTextTimer=nil
				end
			end
		end,1000,time)
		if(isTimer(HospitalStartTimer))then
			killTimer(HospitalStartTimer)
		end
	end,7200,1)
end)

addEventHandler("onClientPedDamage",root,function()
	if(getData(source,"Savezone")==0)then
		cancelEvent()
	end
end)