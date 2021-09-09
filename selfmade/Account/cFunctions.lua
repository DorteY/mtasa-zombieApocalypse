--[[function checkPlayerDownloadState()
    if(not isTransferBoxActive())then
		if(isTimer(CheckDownload))then
			killTimer(CheckDownload)
		end
        triggerServerEvent("Check->Register_Login->Account",localPlayer)
		setElementData(localPlayer,"Language",1)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,function()
    CheckDownload=setTimer(checkPlayerDownloadState,250,0)
end)]]

addEvent("cdn:onClientReady",true)
addEventHandler("cdn:onClientReady",resourceRoot,function()
	 triggerServerEvent("Check->Register_Login->Account",localPlayer)
end)

local function RegisterLoginStuff()
	UI.Image[100]=dgsCreateImage(0,0,GLOBALscreen[1],GLOBALscreen[2],":"..getResourceName(getThisResource()).."/Files/Images/RegisterLogin/BG_"..math.random(1,3)..".png")
	dgsSetEnabled(UI.Image[100],false)
	dgsSetInputMode("no_binds")
	dgsSetInputMode("no_binds_when_editing")
	dgsSetRenderSetting("postGUI",false)
	showChat(false)
	fadeCamera(true)
	setElementFrozen(localPlayer,true)
end


addEvent("Create->Register_Login->UI",true)
addEventHandler("Create->Register_Login->UI",root,function(typ)
	RegisterLoginStuff()
	if(typ=="Login")then
		setUIdatas("set","cursor")
		
		UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,0,500,380,Server.Name.." - Login",false,tocolor(255,255,255),35,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
		dgsMoveTo(UI.Window[1],GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-380/2,false,false,"OutBounce",1500)
		dgsWindowSetSizable(UI.Window[1],false)
		dgsWindowSetMovable(UI.Window[1],false)
		dgsSetProperty(UI.Window[1],"textSize",{1.1,1.1})
		
		UI.Image[1]=dgsCreateImage(295,75,75,75,":"..getResourceName(getThisResource()).."/Files/Images/Language/German.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Image[2]=dgsCreateImage(395,75,75,75,":"..getResourceName(getThisResource()).."/Files/Images/Language/English.png",false,UI.Window[1],tocolor(255,255,255,255))
		
		dgsCreateLabel(85,70,100,20,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Password"),false,UI.Window[1],_,1.3,1.3)
		dgsCreateImage(25,85,45,45,":"..getResourceName(getThisResource()).."/Files/Images/RegisterLogin/Password.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Edit[1]=dgsCreateEdit(80,90,180,45,"",false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
		
		UI.Button[1]=dgsCreateButton(5,300,490,40,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Login"),false,UI.Window[1],_,1.3,1.3,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
		
		addEventHandler("onDgsMouseClick",UI.Image[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					setUIdatas("rem","cursor")
					if(isElement(UI.Image[100]))then
						destroyElement(UI.Image[100])
					end
					setElementData(localPlayer,"Language",1)
					triggerEvent("Create->Register_Login->UI",localPlayer,"Login")
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",UI.Image[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					setUIdatas("rem","cursor")
					if(isElement(UI.Image[100]))then
						destroyElement(UI.Image[100])
					end
					setElementData(localPlayer,"Language",0)
					triggerEvent("Create->Register_Login->UI",localPlayer,"Login")
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",UI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local password=dgsGetText(UI.Edit[1])or ""
					
					if(password:len()>=4)then
						triggerServerEvent("Login->Register_Login->Account",localPlayer,password)
					end
				end
			end,
		false)
		
		dgsEditSetMasked(UI.Edit[1],true)
	elseif(typ=="Register")then
		setUIdatas("set","cursor")
		
		UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,0,500,380,Server.Name.." - Register",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
		dgsMoveTo(UI.Window[1],GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-380/2,false,false,"OutBounce",1500)
		dgsWindowSetSizable(UI.Window[1],false)
		dgsWindowSetMovable(UI.Window[1],false)
		dgsSetProperty(UI.Window[1],"titleHeight",35)
		dgsSetProperty(UI.Window[1],"textSize",{1.1,1.1})
		
		UI.Image[1]=dgsCreateImage(295,35,75,75,":"..getResourceName(getThisResource()).."/Files/Images/Language/German.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Image[2]=dgsCreateImage(395,35,75,75,":"..getResourceName(getThisResource()).."/Files/Images/Language/English.png",false,UI.Window[1],tocolor(255,255,255,255))
		
		dgsCreateLabel(65,30,100,20,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Username"),false,UI.Window[1],_,1.3,1.3)
		dgsCreateImage(5,45,45,45,":"..getResourceName(getThisResource()).."/Files/Images/RegisterLogin/Username.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Edit[1]=dgsCreateEdit(60,50,180,45,"",false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
		
		dgsCreateLabel(65,110,100,20,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Email"),false,UI.Window[1],_,1.3,1.3)
		dgsCreateImage(5,125,45,45,":"..getResourceName(getThisResource()).."/Files/Images/RegisterLogin/Mail.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Edit[2]=dgsCreateEdit(60,130,180,45,"",false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
		
		dgsCreateLabel(65,190,100,20,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Password"),false,UI.Window[1],_,1.3,1.3)
		dgsCreateImage(5,205,45,45,":"..getResourceName(getThisResource()).."/Files/Images/RegisterLogin/Password.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Edit[3]=dgsCreateEdit(60,210,180,45,"",false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
		
		dgsCreateLabel(310,190,100,20,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Password2"),false,UI.Window[1],_,1.3,1.3)
		dgsCreateImage(250,205,45,45,":"..getResourceName(getThisResource()).."/Files/Images/RegisterLogin/Password.png",false,UI.Window[1],tocolor(255,255,255,255))
		UI.Edit[4]=dgsCreateEdit(305,210,180,45,"",false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
		
		UI.Button[1]=dgsCreateButton(5,300,490,40,getLanguageWord(localPlayer,"Client","RegisterLogin","LABEL_Register"),false,UI.Window[1],_,1.3,1.3,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
		
		addEventHandler("onDgsMouseClick",UI.Image[2],
			function(btn,state)
				if(btn=="left" and state=="up")then
					setUIdatas("rem","cursor")
					if(isElement(UI.Image[100]))then
						destroyElement(UI.Image[100])
					end
					setElementData(localPlayer,"Language",1)
					triggerEvent("Create->Register_Login->UI",localPlayer,"Register")
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",UI.Image[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					setUIdatas("rem","cursor")
					if(isElement(UI.Image[100]))then
						destroyElement(UI.Image[100])
					end
					setElementData(localPlayer,"Language",0)
					triggerEvent("Create->Register_Login->UI",localPlayer,"Register")
				end
			end,
		false)
		
		addEventHandler("onDgsMouseClick",UI.Button[1],
			function(btn,state)
				if(btn=="left" and state=="up")then
					local username=dgsGetText(UI.Edit[1])or ""
					local email=dgsGetText(UI.Edit[2])or ""
					local password=dgsGetText(UI.Edit[3])or ""
					local password2=dgsGetText(UI.Edit[4])or ""
					
					if(username:len()>=3 and username:len()<=20)then
						if(password:len()>=4)then
							if(password==password2)then
								if(string.match(email,"^[%w+%.%-_]+@[%w+%.%-_]+%.%a%a+$")==email and email:len()>=7)then
									triggerServerEvent("Create->Register_Login->Account",localPlayer,username,password,email)
								else
									triggerEvent("Draw->Infobox->UI",localPlayer,"Error","Error",getLanguageWord(localPlayer,"Client","RegisterLogin","TEXT_InvalidEmail"))
								end
							else
								triggerEvent("Draw->Infobox->UI",localPlayer,"Error","Error",getLanguageWord(localPlayer,"Client","RegisterLogin","TEXT_PasswordNotMatch"))
							end
						end
					end
				end
			end,
		false)
		
		dgsEditSetMasked(UI.Edit[3],true)
		dgsEditSetMasked(UI.Edit[4],true)
	end
end)


addEvent("Destroy->Register_Login->UI",true)
addEventHandler("Destroy->Register_Login->UI",root,function()
	setUIdatas("rem","cursor")
	if(isElement(UI.Image[100]))then
		destroyElement(UI.Image[100])
	end
	setRadarSettings()
	
	if(GLOBALscreen[1]<=1680 and GLOBALscreen[2]<=1050)then
		outputChatBox("You play on a small resolution, some windows can be displayed incorrectly.",255,255,255)
	end
	
	--//Bindkeys
	bindKey("F1","down",createHelpmenuUI)
	bindKey("F3","down",createToplistUI)
	bindKey("F6","down",createWeapondepotUI)
	bindKey("I","down",openCloseInventory)
	bindKey("U","down",createShopUI)
end)


addEvent("Set->Renderdistance",true)
addEventHandler("Set->Renderdistance",root,function(typ)
	if(typ=="World")then
		setFarClipDistance(tonumber(getData(localPlayer,"RenderdistanceWorld")))
	elseif(typ=="Custom")then
		for i=1,#modsTableFile do
			engineSetModelLODDistance(tonumber(modsTableFile[i].modelid),tonumber(getData(localPlayer,"RenderdistanceCustom")))
		end
	end
end)










