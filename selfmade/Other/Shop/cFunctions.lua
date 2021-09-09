local premiumTimeTable={
	{"7days","x7500 Coins"},
	{"14days","x13500 Coins"},
}
local otherItemTable={
	{"Weapondepot","x"..Server.Shop.Price.Weapondepot.." Coins"},
	{"Itemdepot","x"..Server.Shop.Price.Itemdepot.." Coins"},
}
local weaponskillsTable={
	{22,"Colt45",Server.Shop.Price.Skills.Colt45},
	{23,"Silenced",Server.Shop.Price.Skills.Silenced},
	{24,"Deagle",Server.Shop.Price.Skills.Deagle},
	{25,"Shotgun",Server.Shop.Price.Skills.Shotgun},
	{26,"Sawedoff",Server.Shop.Price.Skills.Sawedoff},
	{28,"Uzi",Server.Shop.Price.Skills.Uzi},
	{29,"Mp5",Server.Shop.Price.Skills.Mp5},
	{30,"AK47",Server.Shop.Price.Skills.AK47},
	{31,"M4",Server.Shop.Price.Skills.M4},
	{33,"Rifle",Server.Shop.Price.Skills.Rifle},
	{34,"Sniper",Server.Shop.Price.Skills.Sniper},
}
local skinTable={
	{7,"L4D2 Patient",Server.Shop.Price.Skins.ID7},
	{11,"Victoria Kanayeva",Server.Shop.Price.Skins.ID11},
	{12,"Mai Shiranui",Server.Shop.Price.Skins.ID12},
	{13,"Moira Burton",Server.Shop.Price.Skins.ID13},
	{31,"Tank Girl",Server.Shop.Price.Skins.ID31},
}

function createShopUI()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-400/2,500,400,Server.Name.." - Shop",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(467,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	UI.Tabpanel[1]=dgsCreateTabPanel(10,10,480,350,false,UI.Window[1],25,_,tocolor(0,0,0,255))
	UI.Tab[1]=dgsCreateTab("Premium",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	
	UI.Grid[1]=dgsCreateGridList(5,5,220,315,false,UI.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
	dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[1],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
	dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	local item=dgsGridListAddColumn(UI.Grid[1],"Item",0.55)
	local amount=dgsGridListAddColumn(UI.Grid[1],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.35)
	
	for _,v in pairs(premiumTimeTable)do
		local row=dgsGridListAddRow(UI.Grid[1])
		dgsGridListSetItemText(UI.Grid[1],row,item,v[1],false,false)
		dgsGridListSetItemText(UI.Grid[1],row,amount,v[2],false,false)
	end
	
	dgsCreateLabel(240,10,160,200,"You can buy Premium for a limited time.\n\n\nWith premium you have special functions.\n\n-more playtime coins (x300)\n-more coins at zombiekill\n-16 weapondepot slots",false,UI.Tab[1])
	UI.Button[1]=dgsCreateButton(230,280,245,40,getLanguageWord(localPlayer,"Client","General","LABEL_BuyPremium"),false,UI.Tab[1],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[1])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
					if(clicked~="")then
						triggerServerEvent("Buy->Shop->Item",localPlayer,"Premium",clicked)
					end
				end
			end
		end,
	false)
	--
	UI.Tab[2]=dgsCreateTab("Weaponskills",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	
	UI.Grid[2]=dgsCreateGridList(5,5,220,315,false,UI.Tab[2],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[2]=dgsGridListGetScrollBar(UI.Grid[2])
	dgsSetProperty(UI.Scroll[2],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[2],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
	dgsSetProperty(UI.Grid[2],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	local id=dgsGridListAddColumn(UI.Grid[2],"ID",0.2)
	local name=dgsGridListAddColumn(UI.Grid[2],"Name",0.45)
	local price=dgsGridListAddColumn(UI.Grid[2],"Price",0.3)
	
	for _,v in pairs(weaponskillsTable)do
		local row=dgsGridListAddRow(UI.Grid[2])
		dgsGridListSetItemText(UI.Grid[2],row,id,v[1],false,false)
		dgsGridListSetItemText(UI.Grid[2],row,name,v[2],false,false)
		dgsGridListSetItemText(UI.Grid[2],row,price,v[3],false,false)
	end
	
	UI.Button[2]=dgsCreateButton(230,280,245,40,getLanguageWord(localPlayer,"Client","General","LABEL_BuyItem"),false,UI.Tab[2],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",UI.Button[2],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[2])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[2],dgsGridListGetSelectedItem(UI.Grid[2]),1)
					if(clicked~=nil)then
						triggerServerEvent("Buy->Shop->Item",localPlayer,"Weaponskill",tonumber(clicked))
					end
				end
			end
		end,
	false)
	--
	UI.Tab[3]=dgsCreateTab("Skins",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	
	UI.Grid[3]=dgsCreateGridList(5,5,220,315,false,UI.Tab[3],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[3]=dgsGridListGetScrollBar(UI.Grid[3])
	dgsSetProperty(UI.Scroll[3],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Grid[3],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	local id=dgsGridListAddColumn(UI.Grid[3],"ID",0.2)
	local name=dgsGridListAddColumn(UI.Grid[3],"Name",0.5)
	local amount=dgsGridListAddColumn(UI.Grid[3],"Price",0.25)
	
	for _,v in pairs(skinTable)do
		local row=dgsGridListAddRow(UI.Grid[3])
		dgsGridListSetItemText(UI.Grid[3],row,id,v[1],false,false)
		dgsGridListSetItemText(UI.Grid[3],row,name,v[2],false,false)
		dgsGridListSetItemText(UI.Grid[3],row,amount,v[3],false,false)
	end
	
	UI.Image[1]=dgsCreateImage(340,5,130,270,":"..getResourceName(getThisResource()).."/Files/Images/Skins/0.png",false,UI.Tab[3])
	
	UI.Button[3]=dgsCreateButton(230,280,245,40,getLanguageWord(localPlayer,"Client","General","LABEL_BuyItem"),false,UI.Tab[3],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",UI.Grid[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[3])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[3],dgsGridListGetSelectedItem(UI.Grid[3]),1)
					if(clicked~=nil)then
						dgsImageSetImage(UI.Image[1],":"..getResourceName(getThisResource()).."/Files/Images/Skins/"..tonumber(clicked)..".png")
					end
				else
					dgsImageSetImage(UI.Image[1],":"..getResourceName(getThisResource()).."/Files/Images/Skins/0.png")
				end
			end
		end,
	false)
	
	addEventHandler("onDgsMouseClick",UI.Button[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[3])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[3],dgsGridListGetSelectedItem(UI.Grid[3]),1)
					if(clicked~=nil)then
						triggerServerEvent("Buy->Shop->Item",localPlayer,"Skin",tonumber(clicked))
					end
				end
			end
		end,
	false)
	--
	UI.Tab[4]=dgsCreateTab("Other",UI.Tabpanel[1],1.1,1.1,_,_,tocolor(0,0,0,255),_,_,_,tocolor(0,0,0,255),tocolor(0,0,0,255),tocolor(0,0,0,255))
	
	UI.Grid[4]=dgsCreateGridList(5,5,220,315,false,UI.Tab[4],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[4]=dgsGridListGetScrollBar(UI.Grid[4])
	dgsSetProperty(UI.Scroll[4],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Grid[4],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	local item=dgsGridListAddColumn(UI.Grid[4],"Item",0.55)
	local amount=dgsGridListAddColumn(UI.Grid[4],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.35)
	
	for _,v in pairs(otherItemTable)do
		local row=dgsGridListAddRow(UI.Grid[4])
		dgsGridListSetItemText(UI.Grid[4],row,item,v[1],false,false)
		dgsGridListSetItemText(UI.Grid[4],row,amount,v[2],false,false)
	end
	
	UI.Button[4]=dgsCreateButton(230,280,245,40,getLanguageWord(localPlayer,"Client","General","LABEL_BuyItem"),false,UI.Tab[4],_,_,_,_,_,_,tocolor(50,50,50,255),tocolor(90,90,90,255),tocolor(10,10,10,255),true)
	
	addEventHandler("onDgsMouseClick",UI.Button[4],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[4])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[4],dgsGridListGetSelectedItem(UI.Grid[4]),1)
					if(clicked~="")then
						triggerServerEvent("Buy->Shop->Item",localPlayer,clicked,_)
					end
				end
			end
		end,
	false)
	
	
	dgsSetProperty(UI.Grid[1],"rowHeight",30)
	dgsSetProperty(UI.Grid[2],"rowHeight",30)
	dgsSetProperty(UI.Grid[3],"rowHeight",30)
	dgsSetProperty(UI.Grid[4],"rowHeight",30)
	dgsGridListSetSortEnabled(UI.Grid[1],false)
	dgsGridListSetSortEnabled(UI.Grid[2],false)
	dgsGridListSetSortEnabled(UI.Grid[3],false)
	dgsGridListSetSortEnabled(UI.Grid[4],false)
	
	addEventHandler("onDgsMouseClick",UI.Button["Close"],
		function(btn,state)
			if(btn=="left" and state=="up")then
				setUIdatas("rem","cursor")
			end
		end,
	false)
end