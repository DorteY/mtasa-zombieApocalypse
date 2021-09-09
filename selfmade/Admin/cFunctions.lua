addEvent("Create->Staffmembers->UI",true)
addEventHandler("Create->Staffmembers->UI",root,function()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-370/2,500,370,Server.Name.." - Stafflist",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(467,-34,33,33,"×",false,UI.Window[1],_,1.6,1.6,_,_,_,tocolor(200,50,50,255),tocolor(250,20,20,255),tocolor(150,50,50,255),true)
	
	UI.Grid[1]=dgsCreateGridList(10,10,480,270,false,UI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
	dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	Name=dgsGridListAddColumn(UI.Grid[1],"Name",0.4)
	Rank=dgsGridListAddColumn(UI.Grid[1],"Rank",0.3)
	Status=dgsGridListAddColumn(UI.Grid[1],"Status",0.2)
	
	UI.Button[1]=dgsCreateButton(10,290,480,35,"Refresh",false,UI.Window[1],_,1.3,1.3,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
	
	
	triggerServerEvent("Get->Staff->Members",localPlayer)
	dgsGridListSetSortEnabled(UI.Grid[1],false)
	dgsSetProperty(UI.Grid[1],"rowHeight",30)
	
	
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				triggerServerEvent("Get->Staff->Members",localPlayer)
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
end)

addEvent("Putin->Staffmembers->UI",true)
addEventHandler("Putin->Staffmembers->UI",root,function(tbl)
	dgsGridListClear(UI.Grid[1])
	if(tbl and #tbl>=1)then
		for _,v in ipairs(tbl)do
			local row=dgsGridListAddRow(UI.Grid[1])
			dgsGridListSetItemText(UI.Grid[1],row,Name,v[1],false,false)
			dgsGridListSetItemText(UI.Grid[1],row,Rank,Server.Admin.Level[v[2]],false,false)
			dgsGridListSetItemText(UI.Grid[1],row,Status,v[3],false,false)
			dgsGridListSetItemColor(UI.Grid[1],row,Rank,Server.Admin.Level.Color2[v[2]])
		end
	end
end)