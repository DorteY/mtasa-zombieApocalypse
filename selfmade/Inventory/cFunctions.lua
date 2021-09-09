local State=false

function openCloseInventory()
	if(not isLoggedin())then
		return
	end
	if(State==false)then
		if(isClickedState(localPlayer)==true)then
			return
		end
		State=true
		setUIdatas("set","cursor")
		
		UI.Window[1]=dgsCreateWindow(GLOBALscreen[1]/2-400/2,GLOBALscreen[2]/2-405/2,400,405,Server.Name.." - Inventory",false,tocolor(255,255,255),nil,nil,UI.Color.Bar,nil,UI.Color.BG,nil,true)
		dgsWindowSetSizable(UI.Window[1],false)
		dgsWindowSetMovable(UI.Window[1],false)
		dgsSetProperty(UI.Window[1],"titleHeight",35)
		dgsSetProperty(UI.Window[1],"textSize",{1.2,1.2})
		UI.Button["Close"]=dgsCreateButton(367,-34,33,33,"×",false,UI.Window[1],_,1.7,1.7,_,_,_,tocolor(200,50,50,0),tocolor(250,20,20,0),tocolor(150,50,50,0),true)
		
		UI.Tabpanel[1]=dgsCreateTabPanel(10,10,380,350,false,UI.Window[1],50,_,tocolor(0,0,0,255))
		--//Tab1
		UI.Tab[1]=dgsCreateTab(" ",UI.Tabpanel[1],3.0,3.0,nil,nil,tocolor(0,0,0,255),":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Food.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Food.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Food.png",tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
		
		UI.Grid[1]=dgsCreateGridList(5,5,370,220,false,UI.Tab[1],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		UI.Scroll[1]=dgsGridListGetScrollBar(UI.Grid[1])
		dgsSetProperty(UI.Scroll[1],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(UI.Scroll[1],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
		dgsSetProperty(UI.Grid[1],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
		item=dgsGridListAddColumn(UI.Grid[1],"Item",0.6)
		amount=dgsGridListAddColumn(UI.Grid[1],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.24)
		
		UI.Button[1]=dgsCreateButton(5,230,370,30,getLanguageWord(localPlayer,"Client","General","LABEL_ItemUse"),false,UI.Tab[1],_,_,_,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
		UI.Button[2]=dgsCreateButton(5,265,370,30,getLanguageWord(localPlayer,"Client","General","LABEL_ItemDrop"),false,UI.Tab[1],_,_,_,_,_,_,UI.Color.BTNRed1,UI.Color.BTNRed2,UI.Color.BTNRed3,true)
		
		addEventHandler("onDgsMouseClick",UI.Button[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[1])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
						if(item and item~="")then
							triggerServerEvent("Drop->Item",localPlayer,item,1)
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
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseDoubleClick",UI.Grid[1],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[1])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[1],dgsGridListGetSelectedItem(UI.Grid[1]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		--//Tab2
		UI.Tab[2]=dgsCreateTab(" ",UI.Tabpanel[1],3.0,3.0,nil,nil,tocolor(0,0,0,255),":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Backpack.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Backpack.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Backpack.png",tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
		
		UI.Grid[2]=dgsCreateGridList(5,5,370,220,false,UI.Tab[2],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		UI.Scroll[2]=dgsGridListGetScrollBar(UI.Grid[1])
		dgsSetProperty(UI.Scroll[2],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(UI.Scroll[2],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
		dgsSetProperty(UI.Grid[2],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
		item=dgsGridListAddColumn(UI.Grid[2],"Item",0.6)
		amount=dgsGridListAddColumn(UI.Grid[2],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.24)
		
		UI.Button[3]=dgsCreateButton(5,230,370,30,getLanguageWord(localPlayer,"Client","General","LABEL_ItemUse"),false,UI.Tab[2],_,_,_,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
		UI.Button[4]=dgsCreateButton(5,265,370,30,getLanguageWord(localPlayer,"Client","General","LABEL_ItemDrop"),false,UI.Tab[2],_,_,_,_,_,_,UI.Color.BTNRed1,UI.Color.BTNRed2,UI.Color.BTNRed3,true)
		
		addEventHandler("onDgsMouseClick",UI.Button[4],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[2])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[2],dgsGridListGetSelectedItem(UI.Grid[2]),1)
						if(item and item~="")then
							triggerServerEvent("Drop->Item",localPlayer,item,1)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseClick",UI.Button[3],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[2])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[2],dgsGridListGetSelectedItem(UI.Grid[2]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseDoubleClick",UI.Grid[2],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[2])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[2],dgsGridListGetSelectedItem(UI.Grid[2]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		--//Tab3
		UI.Tab[3]=dgsCreateTab(" ",UI.Tabpanel[1],3.0,3.0,nil,nil,tocolor(0,0,0,255),":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Clothing.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Clothing.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Clothing.png",tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
		
		UI.Grid[3]=dgsCreateGridList(5,5,370,255,false,UI.Tab[3],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		UI.Scroll[3]=dgsGridListGetScrollBar(UI.Grid[1])
		dgsSetProperty(UI.Scroll[3],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(UI.Scroll[3],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
		dgsSetProperty(UI.Grid[3],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
		item=dgsGridListAddColumn(UI.Grid[3],"Item",0.6)
		amount=dgsGridListAddColumn(UI.Grid[3],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.24)
		
		UI.Button[5]=dgsCreateButton(5,265,370,30,getLanguageWord(localPlayer,"Client","General","LABEL_ItemUse"),false,UI.Tab[3],_,_,_,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
		
		addEventHandler("onDgsMouseClick",UI.Button[5],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[3])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[3],dgsGridListGetSelectedItem(UI.Grid[3]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseDoubleClick",UI.Grid[3],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[3])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[3],dgsGridListGetSelectedItem(UI.Grid[3]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		--//Tab4
		UI.Tab[4]=dgsCreateTab(" ",UI.Tabpanel[1],3.0,3.0,nil,nil,tocolor(0,0,0,255),":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Other.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Other.png",":"..getResourceName(getThisResource()).."/Files/Images/Inventory/Category/Other.png",tocolor(255,255,255,255),tocolor(255,255,255,255),tocolor(120,0,0,255))
		
		UI.Grid[4]=dgsCreateGridList(5,5,370,255,false,UI.Tab[4],_,tocolor(50,50,50,255),tocolor(255,255,255,255),tocolor(30,30,30,255),tocolor(65,65,65,255))
		UI.Scroll[4]=dgsGridListGetScrollBar(UI.Grid[1])
		dgsSetProperty(UI.Scroll[4],"troughColor",tocolor(50,50,50,255))
		dgsSetProperty(UI.Scroll[4],"cursorColor",{UI.Color.Scroll1,UI.Color.Scroll2,UI.Color.Scroll3})
		dgsSetProperty(UI.Grid[4],"rowColor",{UI.Color.Grid1,UI.Color.Grid2,UI.Color.Grid3})
		item=dgsGridListAddColumn(UI.Grid[4],"Item",0.6)
		amount=dgsGridListAddColumn(UI.Grid[4],getLanguageWord(localPlayer,"Client","General","LABEL_Amount"),0.24)
		
		UI.Button[6]=dgsCreateButton(5,265,370,30,getLanguageWord(localPlayer,"Client","General","LABEL_ItemUse"),false,UI.Tab[4],_,_,_,_,_,_,UI.Color.BTNGreen1,UI.Color.BTNGreen2,UI.Color.BTNGreen3,true)
		
		addEventHandler("onDgsMouseClick",UI.Button[6],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[4])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[4],dgsGridListGetSelectedItem(UI.Grid[4]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		addEventHandler("onDgsMouseDoubleClick",UI.Grid[4],
			function(btn,state)
				if(btn=="left" and state=="down")then
					local item=dgsGridListGetSelectedItem(UI.Grid[4])
					if(item>0)then
						local item=dgsGridListGetItemText(UI.Grid[4],dgsGridListGetSelectedItem(UI.Grid[4]),1)
						if(item and item~="")then
							triggerServerEvent("Use->Item",localPlayer,item)
						end
					end
				end
			end,
		false)
		
		
		
		addEventHandler("onDgsMouseClick",UI.Button["Close"],
			function(btn,state)
				if(btn=="left" and state=="up")then
					setUIdatas("rem","cursor")
					State=false
				end
			end,
		false)
		
		dgsSetProperty(UI.Tab[1],"width",50)
		dgsSetProperty(UI.Tab[2],"width",50)
		dgsSetProperty(UI.Tab[3],"width",50)
		dgsSetProperty(UI.Tab[4],"width",50)
		dgsSetProperty(UI.Grid[1],"rowHeight",30)
		dgsSetProperty(UI.Grid[2],"rowHeight",30)
		dgsSetProperty(UI.Grid[3],"rowHeight",30)
		dgsSetProperty(UI.Grid[4],"rowHeight",30)
		dgsGridListSetSortEnabled(UI.Grid[1],false)
		dgsGridListSetSortEnabled(UI.Grid[2],false)
		dgsGridListSetSortEnabled(UI.Grid[3],false)
		dgsGridListSetSortEnabled(UI.Grid[4],false)
		
		fillInventoryGrid()
	else
		State=false
		setUIdatas("rem","cursor")
	end
end


function fillInventoryGrid()
	fillWithItemsGrid1(UI.Grid[1],item,amount)
	fillWithItemsGrid2(UI.Grid[2],item,amount)
	fillWithItemsGrid3(UI.Grid[3],item,amount)
	fillWithItemsGrid4(UI.Grid[4],item,amount)
end
addEvent("Refresh->Inventory->UI",true)
addEventHandler("Refresh->Inventory->UI",root,fillInventoryGrid)

function fillWithItemsGrid1(grid,itemName,itemCount)
	dgsGridListClear(grid)
	local Pastacan=tonumber(getData(localPlayer,"Pastacan"))
	local Ravioli=tonumber(getData(localPlayer,"Ravioli"))
	local Pepsi=tonumber(getData(localPlayer,"Pepsi"))
	local Cola=tonumber(getData(localPlayer,"Cola"))
	if(Pastacan>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Pastacan"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Pastacan),false,false)
	end
	if(Ravioli>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Ravioli"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Ravioli),false,false)
	end
	if(Pepsi>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Pepsi"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Pepsi),false,false)
	end
	if(Cola>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Cola"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Cola),false,false)
	end
end

function fillWithItemsGrid2(grid,itemName,itemCount)
	dgsGridListClear(grid)
	local Fuelcan=tonumber(getData(localPlayer,"Fuelcan"))
	local Repairkit=tonumber(getData(localPlayer,"Repairkit"))
	local FirstAidKit=tonumber(getData(localPlayer,"FirstAidKit"))
	local Itemdepot=tonumber(getData(localPlayer,"Itemdepot"))
	if(Fuelcan>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Fuelcan"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Fuelcan),false,false)
	end
	if(Repairkit>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Repairkit"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Repairkit),false,false)
	end
	if(FirstAidKit>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_FirstAidKit"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(FirstAidKit),false,false)
	end
	if(Itemdepot>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,getLanguageWord(localPlayer,"Client","Items","LABEL_Itemdepot"),false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Itemdepot),false,false)
	end
end

function fillWithItemsGrid3(grid,itemName,itemCount)
	dgsGridListClear(grid)
	local Skin7=tonumber(getData(localPlayer,"Skin_7"))
	local Skin11=tonumber(getData(localPlayer,"Skin_11"))
	local Skin12=tonumber(getData(localPlayer,"Skin_12"))
	local Skin13=tonumber(getData(localPlayer,"Skin_13"))
	local Skin31=tonumber(getData(localPlayer,"Skin_31"))
	if(Skin7>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"L4D2 Patient",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Skin7),false,false)
	end
	if(Skin11>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Victoria Kanayeva",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Skin11),false,false)
	end
	if(Skin12>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Mai Shiranui",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Skin12),false,false)
	end
	if(Skin13>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Moira Burton",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Skin13),false,false)
	end
	if(Skin31>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"Tank Girl",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Skin31),false,false)
	end
end

function fillWithItemsGrid4(grid,itemName,itemCount)
	dgsGridListClear(grid)
	local Boost_Money20=tonumber(getData(localPlayer,"Boost_Money20"));
	local Boost_Money50=tonumber(getData(localPlayer,"Boost_Money50"));
	local Boost_EXP20=tonumber(getData(localPlayer,"Boost_EXP20"));
	local Boost_EXP50=tonumber(getData(localPlayer,"Boost_EXP50"));
	if(Boost_Money20>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"20% Coin Boost Ticket",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Boost_Money20),false,false)
	end
	if(Boost_Money50>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"50% Coin Boost Ticket",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Boost_Money50),false,false)
	end
	if(Boost_EXP20>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"20% EXP Boost Ticket",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Boost_EXP20),false,false)
	end
	if(Boost_EXP50>=1)then
		local row=dgsGridListAddRow(grid)
		dgsGridListSetItemText(grid,row,itemName,"50% EXP Boost Ticket",false,false)
		dgsGridListSetItemText(grid,row,itemCount,tonumber(Boost_EXP50),false,false)
	end
end