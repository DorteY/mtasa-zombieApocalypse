addEvent("Create->Loot->UI",true)
addEventHandler("Create->Loot->UI",root,function(tbl)
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
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-500/2,GLOBALscreen[2]/2-400/2,500,400,"Loot",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(467,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	UI.Grid[1]=dgsCreateGridList(10,10,300,300,false,UI.Window[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
	UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
	dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
	dgsSetProperty(UI.Scroll[1],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
	dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
	lootitem=dgsGridListAddColumn(UI.Grid[1],"Item",0.6)
	lootitemamount=dgsGridListAddColumn(UI.Grid[1],"Amount",0.24)
	
	dgsGridListClear(UI.Grid[1])
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(UI.Grid[1])
			dgsGridListSetItemText(UI.Grid[1],row,lootitem,v[1],false,false)
			dgsGridListSetItemText(UI.Grid[1],row,lootitemamount,v[2],false,false)
		end
	end
	
	UI.Edit[1]=dgsCreateEdit(320,270,170,40,0,false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
	UI.Button[1]=dgsCreateButton(10,320,480,35,getLanguageWord(localPlayer,"Client","General","LABEL_TakeItem"),false,UI.Window[1],_,_,_,_,_,_,UI.Color.BTNMain1,UI.Color.BTNMain2,UI.Color.BTNMain3,true)
	
	addEventHandler("onDgsMouseDoubleClick",UI.Grid[1],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local item=dgsGridListGetSelectedItem(UI.Grid[1])
				if(item>0)then
					local item=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
					if(item and item~="")then
						local amount=tonumber(dgsGetText(UI.Edit[1]))
						if(amount and amount~=nil and amount>=1 and amount<=20)then
							if(isOnlyNumbers(amount))then
								triggerServerEvent("Take->Loot->Item",localPlayer,item,amount)
							end
						else
							triggerEvent("Draw->Infobox->UI",lp,"Error","Error","you can only take this item x20 at a time!")
						end
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local item=dgsGridListGetSelectedItem(UI.Grid[1])
				if(item>0)then
					local item=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
					if(item and item~="")then
						local amount=tonumber(dgsGetText(UI.Edit[1]))
						if(amount and amount~=nil and amount>=1 and amount<=20)then
							if(isOnlyNumbers(amount))then
								triggerServerEvent("Take->Loot->Item",localPlayer,item,amount)
							end
						else
							triggerEvent("Draw->Infobox->UI",lp,"Error","Error","you can only take this item x20 at a time!")
						end
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

addEvent("Refresh->Loot->UI",true)
addEventHandler("Refresh->Loot->UI",root,function(tbl)
	dgsGridListClear(UI.Grid[1])
	if(#tbl>=1)then
		for _,v in pairs(tbl)do
			local row=dgsGridListAddRow(UI.Grid[1])
			dgsGridListSetItemText(UI.Grid[1],row,lootitem,v[1],false,false)
			dgsGridListSetItemText(UI.Grid[1],row,lootitemamount,v[2],false,false)
		end
	end
end)


--//Itemdepot
addEvent("Create->Itemdepot->UI",true)
addEventHandler("Create->Itemdepot->UI",root,function(coins)
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
	
	UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-400/2,GLOBALscreen[2]/2-380/2,400,380,"Itemdepot",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
	dgsWindowSetSizable(UI.Window[1],false)
	dgsWindowSetMovable(UI.Window[1],false)
	dgsSetProperty(UI.Window[1],"titleHeight",35)
	dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
	UI.Button["Close"]=dgsCreateButton(367,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	UI.Label[1]=dgsCreateLabel(100,5,200,60,"Coins: x"..coins,false,UI.Window[1],_,_,_,_,_,_,"center",_)
	
	UI.Radio[1]=dgsCreateRadioButton(10,70,11,11,"Coins",false,UI.Window[1])
	
	UI.Edit[1]=dgsCreateEdit(5,210,390,40,0,false,UI.Window[1],tocolor(255,255,255,255),_,_,_,UI.Color.Edit)
	
	UI.Button[1]=dgsCreateButton(5,255,390,40,getLanguageWord(localPlayer,"Client","General","LABEL_Store"),false,UI.Window[1],_,_,_,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
	UI.Button[2]=dgsCreateButton(5,300,390,40,getLanguageWord(localPlayer,"Client","General","LABEL_Outsource"),false,UI.Window[1],_,_,_,_,_,_,UI.Color.BTNRed1,UI.Color.BTNRed2,UI.Color.BTNRed3,true)
	UI.Button[3]=dgsCreateButton(10,-34,80,33,"Destroy",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
	
	addEventHandler("onDgsMouseClick",UI.Button[3],
		function(btn,state)
			if(btn=="left" and state=="up")then
				triggerServerEvent("Destroy->Itemdepot",localPlayer)
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",UI.Button[2],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local amount=dgsGetText(UI.Edit[1])
				
				if(amount and amount~=nil and amount~="" and isOnlyNumbers(amount))then
					if(dgsRadioButtonGetSelected(UI.Radio[1]))then
						triggerServerEvent("Take-Putin->Loot->Item",localPlayer,"out","Coins",tonumber(amount))
					end
				end
			end
		end,
	false)
	addEventHandler("onDgsMouseClick",UI.Button[1],
		function(btn,state)
			if(btn=="left" and state=="down")then
				local amount=dgsGetText(UI.Edit[1])
				
				if(amount and amount~=nil and amount~="" and isOnlyNumbers(amount))then
					if(dgsRadioButtonGetSelected(UI.Radio[1]))then
						triggerServerEvent("Take-Putin->Loot->Item",localPlayer,"in","Coins",tonumber(amount))
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
	
	dgsRadioButtonSetSelected(UI.Radio[1],true)
end)

addEvent("Refresh->Itemdepot->UI",true)
addEventHandler("Refresh->Itemdepot->UI",root,function(coins,pizza,pastacan,ravioli,cola,pepsi,jerrycan,medkit,repairkit)
	if(isElement(UI.Window[1]))then
		dgsSetText(UI.Label[1],"Coins: x"..coins)
	end
end)