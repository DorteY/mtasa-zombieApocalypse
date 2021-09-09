addEventHandler("onClientPlayerWeaponFire",localPlayer,function(weapon,ammo,ammoclip) 
	if(weapon==33 or weapon==34 and ammoclip==0)then 
		triggerServerEvent("Reload->Rifles",localPlayer)
	end 
end)

--//Depot
local Weapondepot={
	["Colt 45"]=22,
	["Silenced"]=23,
	["Desert Eagle"]=24,
	["Shotgun"]=25,
	["Sawed-off"]=26,
	["Combat Shotgun"]=27,
	["Uzi"]=28,
	["Mp5"]=29,
	["Tec-9"]=32,
	["AK-47"]=30,
	["M4"]=31,
	["Country Rifle"]=33,
	["Sniper"]=34,
	["Rocket Launcher"]=35,
	["Rocket Launcher HS"]=36,
	["Flamethrower"]=37,
	["Minigun"]=38,
	["Grenade"]=16,
	["Molotov"]=18,
	["Satchel"]=39
}

function createWeapondepotUI()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	if(tonumber(getData(localPlayer,"Weapondepot"))==0)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-450/2,500,450,Server.Name.." - Weapondepot",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(467,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	
	UI.Grid[1]=dgsCreateGridList(5,25,240,340,false,UI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
	dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[1],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
	dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	itemid=dgsGridListAddColumn(UI.Grid[1],"ID",0.2)
	item=dgsGridListAddColumn(UI.Grid[1],"Item",0.5)
	amount=dgsGridListAddColumn(UI.Grid[1],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.25)
	
	UI.Button[1]=dgsCreateButton(255,370,240,40,getLanguageWord(localPlayer,"Client","General","LABEL_Store"),false,UI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[2])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[2],dgsGridListGetSelectedItem(UI.Grid[2]),1)
					if(clicked~="")then
						local weaponID=Weapondepot[clicked]
						triggerServerEvent("Put->In->Weapondepot->Weapon",localPlayer,weaponID)
						triggerServerEvent("Get->Weapondepot->Weapons",localPlayer)
					end
				end
			end
		end,
	false)
	--
	UI.Grid[2]=dgsCreateGridList(255,25,240,340,false,UI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[2]=dgsGridListGetScrollBar(UI.Grid[2])
	dgsSetProperty(UI.Scroll[2],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[2],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
	dgsSetProperty(UI.Grid[2],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	item2=dgsGridListAddColumn(UI.Grid[2],"Item",0.55)
	amount2=dgsGridListAddColumn(UI.Grid[2],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.35)
	
	UI.Button[2]=dgsCreateButton(5,370,240,40,getLanguageWord(localPlayer,"Client","General","LABEL_Outsource"),false,UI.Window[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",UI.Button[2],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[1])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
					if(clicked~="")then
						triggerServerEvent("Put->Out->Weapondepot->Weapon",localPlayer,clicked)
						triggerServerEvent("Get->Weapondepot->Weapons",localPlayer)
					end
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
	
	
	triggerServerEvent("Get->Weapondepot->Weapons",localPlayer)
	dgsSetProperty(UI.Grid[1],"rowHeight",30)
	dgsSetProperty(UI.Grid[2],"rowHeight",30)
	dgsGridListSetSortEnabled(UI.Grid[1],false)
	dgsGridListSetSortEnabled(UI.Grid[2],false)
end

addEvent("Refresh->Weapondepot->UI",true)
addEventHandler("Refresh->Weapondepot->UI",root,function(tbl,tbl2)
	dgsGridListClear(UI.Grid[1])
	dgsGridListClear(UI.Grid[2])
	
	if(#tbl2>=1)then
		for _,v in pairs(tbl2)do
			local row=dgsGridListAddRow(UI.Grid[1])
			dgsGridListSetItemText(UI.Grid[1],row,itemid,v[1],false,false)
			dgsGridListSetItemText(UI.Grid[1],row,item,v[2],false,false)
			dgsGridListSetItemText(UI.Grid[1],row,amount,v[3],false,false)
		end
	end
	
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(UI.Grid[2])
			dgsGridListSetItemText(UI.Grid[2],row,item2,v[1],false,false)
			dgsGridListSetItemText(UI.Grid[2],row,amount2,v[2],false,false)
		end
	end
end)

--//Shop
local WeaponshopTable={
	-- Name, Preis, Level, Ammo
	{"Colt 45",75,1,68},
	{"Silenced",100,1,68},
	{"Desert Eagle",250,1,42},
	{"Shotgun",500,3,30},
	{"Sawed-off",750,3,18},
	{"Combat Shotgun",1250,4,35},
	{"Uzi",1500,6,200},
	{"Mp5",1800,6,120},
	{"Tec-9",2000,7,200},
	{"AK-47",2200,10,250},
	{"M4",2500,12,300},
	{"Rifle",3000,13,50},
	{"Sniper",6000,19,25},
	{"Rocket Launcher",10000,25,5},
	{"Rocket Launcher HS",12500,25,5},
	{"Flamethrower",20000,30,250},
	{"Minigun",35000,45,1000},
	{"Grenade",40000,50,25},
	{"Molotov",40000,50,25},
	{"Satchel",50000,75,30},
}

addEvent("Create->Weaponshop->UI",true)
addEventHandler("Create->Weaponshop->UI",root,function()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-380/2,500,380,Server.Name.." - Weaponshop",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(467,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	--UI.Label[1]=dgsCreateLabel(5,4,100,20,"Your coins: x"..getClientData("Coins"),false,UI.Window[1])
	
	UI.Grid[1]=dgsCreateGridList(5,20,490,280,false,UI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
	dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[1],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
	dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	local weapon=dgsGridListAddColumn(UI.Grid[1],"Weapon",0.38)
	local price=dgsGridListAddColumn(UI.Grid[1],"Coins",0.16)
	local level=dgsGridListAddColumn(UI.Grid[1],"Level",0.16)
	local ammo=dgsGridListAddColumn(UI.Grid[1],"Ammo",0.16)
	
	for _,v in pairs(WeaponshopTable)do
		local row=dgsGridListAddRow(UI.Grid[1])
		dgsGridListSetItemText(UI.Grid[1],row,weapon,v[1],false,false)
		dgsGridListSetItemText(UI.Grid[1],row,price,v[2],false,false)
		dgsGridListSetItemText(UI.Grid[1],row,level,v[3],false,false)
		dgsGridListSetItemText(UI.Grid[1],row,ammo,v[4],false,false)
	end
	
	UI.Button[1]=dgsCreateButton(5,305,490,35,getLanguageWord(localPlayer,"Client","General","LABEL_BuyItem"),false,UI.Window[1],_,_,_,_,_,_,UI.Color.BTNMain1,UI.Color.BTNMain2,UI.Color.BTNMain3,true)
	
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[1])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
					if(clicked~="")then
						triggerServerEvent("Buy->Weapon",localPlayer,clicked)
					end
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
	
	dgsGridListSetSortEnabled(UI.Grid[1],false)
	dgsSetProperty(UI.Grid[1],"rowHeight",30)
end)






