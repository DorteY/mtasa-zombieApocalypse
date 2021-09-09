Toplist={
	{"Kills"},{"Deaths"},{"Damage"},{"ZombieKills"},
}

function createToplistUI()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	setUIdatas("set","cursor",true)
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-420/2,500,420,Server.Name.." - Toplist",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(467,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	
	UI.Grid[1]=dgsCreateGridList(5,5,200,380,false,UI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
	dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[1],"cursorColor",{tocolor(100,100,100,255),tocolor(35,35,35,255),tocolor(10,10,10,255)})
	dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	category=dgsGridListAddColumn(UI.Grid[1],"Category",0.9)
	
	for _,v in pairs(Toplist)do
		local row=dgsGridListAddRow(UI.Grid[1])
		dgsGridListSetItemText(UI.Grid[1],row,category,v,false,false)
	end
	
	UI.Label[1]=dgsCreateLabel(220,10,160,200,"Choose a category.",false,UI.Window[1])
	
	addEventHandler("onDgsMouseClick",UI.Grid[1],
		function(btn,state)
			if(btn=="left" and state=="up")then
				local item=dgsGridListGetSelectedItem(UI.Grid[1])
				if(item>0)then
					local clicked=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
					if(clicked~="")then
						triggerServerEvent("Get->Toplist->Data",localPlayer,clicked)
					end
				else
					dgsSetText(UI.Label[1],"Choose a category.")
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
	
	dgsSetProperty(UI.Grid[1],"rowHeight",30)
	dgsGridListSetSortEnabled(UI.Grid[1],false)
end


addEvent("Refresh->Toplist->UI",true)
addEventHandler("Refresh->Toplist->UI",root,function(tbl)
	if(#tbl>=1)then
		local text=""
		for i=1,#tbl do
			text=text..i..". "..tbl[i][1].." (x"..tbl[i][2]..")\n"
		end
		dgsSetText(UI.Label[1],text)
	end
end)