local GeneralTimer={}
local EatDrinkTimer={}
local HealTimer={}
local DropedItemTable={}
local DropedItemTimerTable={}

addEvent("Use->Item",true)
addEventHandler("Use->Item",root,function(item)
	if(isLoggedin(client))then
		if(not isPedDead(client))then
			local pname=getPlayerName(client)
			--if(item=="Pastacan" or item=="Spaghetti")then
			if(item==getLanguageWord(client,"Client","Items","LABEL_Pastacan"))then
				item="Pastacan"
				if(getPlayerValue(client,item)>=1)then
					if(not isTimer(EatDrinkTimer[client]))then
						local rdm=math.random(17,21)
						takePlayerValue(client,item,1)
						setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
						addPlayerValue(client,"Hunger",rdm)
						EatDrinkTimer[client]=setTimer(function(client)
							killTimer(EatDrinkTimer[client])
							EatDrinkTimer[client]=nil
							outputLog(pname.." eat a Pastacan!","Uses")
						end,5*1000,1,client)
					else
						triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_AlrearyEatingDrinking"))
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_Ravioli"))then
				item="Ravioli"
				if(getPlayerValue(client,item)>=1)then
					if(not isTimer(EatDrinkTimer[client]))then
						local rdm=math.random(15,21)
						takePlayerValue(client,item,1)
						setPedAnimation(client,"food","EAT_Burger",-1,false,false,false,false)
						addPlayerValue(client,"Hunger",rdm)
						EatDrinkTimer[client]=setTimer(function(client)
							killTimer(EatDrinkTimer[client])
							EatDrinkTimer[client]=nil
							outputLog(pname.." eat a Ravioli!","Uses")
						end,5*1000,1,client)
					else
						triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_AlrearyEatingDrinking"))
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_Pepsi"))then
				item="Pepsi"
				if(getPlayerValue(client,item)>=1)then
					if(not isTimer(EatDrinkTimer[client]))then
						local rdm=math.random(10,17)
						takePlayerValue(client,item,1)
						setPedAnimation(client,"vending","vend_drink2_p",-1,false,false,false,false)
						addPlayerValue(client,"Thirst",rdm)
						EatDrinkTimer[client]=setTimer(function(client)
							killTimer(EatDrinkTimer[client])
							EatDrinkTimer[client]=nil
							outputLog(pname.." drink a Pepsi!","Uses")
						end,4*1000,1,client)
					else
						triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_AlrearyEatingDrinking"))
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_Cola"))then
				item="Cola"
				if(getPlayerValue(client,item)>=1)then
					if(not isTimer(EatDrinkTimer[client]))then
						local rdm=math.random(10,17)
						takePlayerValue(client,item,1)
						setPedAnimation(client,"vending","vend_drink2_p",-1,false,false,false,false)
						addPlayerValue(client,"Thirst",rdm)
						EatDrinkTimer[client]=setTimer(function(client)
							killTimer(EatDrinkTimer[client])
							EatDrinkTimer[client]=nil
							outputLog(pname.." drink a Cola!","Uses")
						end,4*1000,1,client)
					else
						triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_AlrearyEatingDrinking"))
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_FirstAidKit"))then
				item="FirstAidKit"
				if(getPlayerValue(client,item)>=1)then
					if(not isTimer(HealTimer[client]))then
						if(getElementHealth(client)<100)then
							setElementFrozen(client,true)
							setPedAnimation(client,"BOMBER","BOM_Plant_Loop")
							HealTimer[client]=setTimer(function(client)
								takePlayerValue(client,item,1)
								setElementHealth(client,getElementHealth(client)+50)
								killTimer(HealTimer[client])
								HealTimer[client]=nil
								setElementFrozen(client,false)
								setPedAnimation(client)
								outputLog(pname.." used a FirstAidKit!","Uses")
							end,10*1000,1,client)
						end
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_Fuelcan"))then
				item="Fuelcan"
				if(getPlayerValue(client,item)>=1)then
					if(isPedInVehicle(client))then
						local veh=getPedOccupiedVehicle(client)
						if(veh and isElement(veh))then
							if(not isTimer(GeneralTimer[client]))then
								if(getElementSpeed(veh,"km/h")<=5)then
									toggleAllControls(client,false)
									setElementFrozen(veh,true)
									triggerClientEvent(client,"Draw->Infobox->UI",client,"Info","Information",getLanguageWord(client,"Server","Vehicle","TEXT_Tankstart"))
									GeneralTimer[client]=setTimer(function(client)
										if(isPedInVehicle(client))then
											if(veh and isElement(veh))then
												local maxLiter=getVehicleFuelSizeUsage(veh)
												takePlayerValue(client,item,1)
												setElementData(veh,"veh:fuel",tonumber(getElementData(veh,"veh:fuel"))+20)
												if(getElementData(veh,"veh:fuel")>=maxLiter)then
													setElementData(veh,"veh:fuel",maxLiter)
												end
												toggleAllControls(client,true)
												setElementFrozen(veh,false)
												killTimer(GeneralTimer[client])
												GeneralTimer[client]=nil
												outputLog(pname.." used a Fuelcan!","Uses")
												triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","Vehicle","TEXT_Tanksuccess"))
											end
										end
									end,50*1000,1,client)
								end
							end
						end
					else
						triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","Vehicle","TEXT_NotInVehicle"))
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_Repairkit"))then
				item="Repairkit"
				if(getPlayerValue(client,item)>=1)then
					if(not isPedInVehicle(client))then
						for _,v in pairs(getElementsByType("vehicle"))do
							local x,y,z=getElementPosition(v)
							local px,py,pz=getElementPosition(client)
							if(getDistanceBetweenPoints3D(x,y,z,px,py,pz)<=3)then
								if(not isTimer(GeneralTimer[client]))then
									if(getElementSpeed(v,"km/h")<=5)then
										if(getElementHealth(v)<=800)then
											toggleAllControls(client,false)
											setElementFrozen(v,true)
											setPedAnimation(client,"graffiti","spraycan_fire")
											GeneralTimer[client]=setTimer(function(client)
												fixVehicle(v)
												takePlayerValue(client,item,1)
												toggleAllControls(client,true)
												setElementFrozen(v,false)
												killTimer(GeneralTimer[client])
												GeneralTimer[client]=nil
												setPedAnimation(client)
												outputLog(pname.." used a Repairkit!","Uses")
												triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","Vehicle","TEXT_Repairsuccess"))
											end,60*1000,1,client)
										end
									end
								end
							end
						end
					end
				end
			elseif(item==getLanguageWord(client,"Client","Items","LABEL_Itemdepot"))then
				item="Itemdepot"
				if(getPlayerValue(client,item)>=1)then
					if(not(isPedInVehicle(client)))then
						if(isPedOnGround(client))then
							for _,v in pairs(getElementsByType("object"))do
								if(getElementModel(v)==1271 and getElementData(v,"Element->Type->Itemdepot"))then
									local x,y,z=getElementPosition(v)
									if(getDistanceBetweenPoints3D(x,y,z,getElementPosition(client))<=1.5)then
										triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error","you have to keep moving away\nfrom the other itemdepot!")
										return
									end
								end
							end
							if(not isTimer(GeneralTimer[client]))then
								toggleAllControls(client,false)
								setElementFrozen(client,true)
								setPedAnimation(client,"BOMBER","BOM_Plant_Loop")
								GeneralTimer[client]=setTimer(function(client)
									if(isElement(client))then
										if(getPlayerValue(client,"Itemdepot")>=1)then
											setPedAnimation(client)
											setElementFrozen(client,false)
											toggleAllControls(client,true)
											
											local x,y,z=getElementPosition(client)
											local _,_,rz=getElementRotation(client)
											
											local IDcounter=dbPoll(dbQuery(DB.HANDLER,"SELECT ?? FROM ?? WHERE Itemdepot=Itemdepot","Itemdepot","counter"),-1)[1]["Itemdepot"]
											dbExec(DB.HANDLER,"UPDATE ?? SET ??=?","counter","Itemdepot",IDcounter+1)
											
											Itemdepots[IDcounter]=createObject(1271,x,y,z-0.6,0,0,rz)
											setElementData(Itemdepots[IDcounter],"Element->Type->Itemdepot",true)
											setElementData(Itemdepots[IDcounter],"Itemdepot->ID",IDcounter)
											takePlayerValue(client,"Itemdepot",1)
											
											dbExec(DB.HANDLER,"INSERT INTO itemdepots (ID,Owner,SpawnX,SpawnY,SpawnZ,Rot) VALUES (?,?,?,?,?,?)",IDcounter,getPlayerName(client),x,y,z,rz)
										end
									end
								end,30*1000,1,client)
							end
						end
					end
				end
			--//Skins
			elseif(item=="L4D2 Patient")then
				item="Skin_7"
				if(getPlayerValue(client,item)>=1)then
					setElementModel(client,7)
					setData(client,"SkinID",getElementModel(client))
				end
			elseif(item=="Victoria Kanayeva")then
				item="Skin_11"
				if(getPlayerValue(client,item)>=1)then
					setElementModel(client,11)
					setData(client,"SkinID",getElementModel(client))
				end
			elseif(item=="Mai Shiranui")then
				item="Skin_12"
				if(getPlayerValue(client,item)>=1)then
					setElementModel(client,12)
					setData(client,"SkinID",getElementModel(client))
				end
			elseif(item=="Moira Burton")then
				item="Skin_13"
				if(getPlayerValue(client,item)>=1)then
					setElementModel(client,13)
					setData(client,"SkinID",getElementModel(client))
				end
			elseif(item=="Tank Girl")then
				item="Skin_31"
				if(getPlayerValue(client,item)>=1)then
					setElementModel(client,31)
					setData(client,"SkinID",getElementModel(client))
				end
				
			elseif(item=="20% Coin Boost Ticket")then
				item="Boost_Money20";
				if(getPlayerValue(client,item)>=1)then
					setData(client,"BoosttimeMoney20",getData(client,"BoosttimeMoney20")+30);
					takePlayerValue(client,item,1);
					triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","Inventory","USE_BoostCoin20"));
				end
			elseif(item=="50% Coin Boost Ticket")then
				item="Boost_Money50";
				if(getPlayerValue(client,item)>=1)then
					setData(client,"BoosttimeMoney50",getData(client,"BoosttimeMoney50")+30);
					takePlayerValue(client,item,1);
					triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","Inventory","USE_BoostCoin50"));
				end
			elseif(item=="20% EXP Boost Ticket")then
				item="Boost_EXP20";
				if(getPlayerValue(client,item)>=1)then
					setData(client,"BoosttimeEXP20",getData(client,"BoosttimeEXP20")+30);
					takePlayerValue(client,item,1);
					triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","Inventory","USE_BoostEXP20"));
				end
			elseif(item=="50% EXP Boost Ticket")then
				item="Boost_EXP50";
				if(getPlayerValue(client,item)>=1)then
					setData(client,"BoosttimeEXP50",getData(client,"BoosttimeEXP50")+30);
					takePlayerValue(client,item,1);
					triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","Inventory","USE_BoostEXP50"));
				end
			end
			triggerClientEvent(client,"Refresh->Inventory->UI",client)
		end
	end
end)

addEvent("Drop->Item",true)
addEventHandler("Drop->Item",root,function(item,amount)
	if(isLoggedin(client))then
		if(not isPedDead(client))then
			if(tonumber(getData(client,item))>=amount)then
				local x,y,z=getElementPosition(client)
				if(x and y and z)then
					local Pickup=createPickup(x+2,y+2,z,3,1279,50)
					setElementData(Pickup,"Item",item)
					setElementData(Pickup,"Amount",amount)
					takePlayerValue(client,item,amount)
					
					DropedItemTimerTable[Pickup]=setTimer(function()
						if(isElement(Pickup))then
							destroyElement(Pickup)
						end
						killTimer(DropedItemTimerTable[Pickup])
						DropedItemTimerTable[Pickup]=nil
					end,25*1000,1)
					
					addEventHandler("onPickupHit",Pickup,function(player)
						if(not(isPedInVehicle(player)))then
							addPlayerValue(player,getElementData(source,"Item"),getElementData(source,"Amount"))
							destroyElement(source)
							source=nil
						end
					end)
					triggerClientEvent(client,"Refresh->Inventory->UI",client)
				end
			end
		end
	end
end)

addEventHandler("onPlayerQuit",root,function()
	if(isTimer(GeneralTimer[source]))then
		killTimer(GeneralTimer[source])
		GeneralTimer[source]=nil
	end
	if(isTimer(EatDrinkTimer[source]))then
		killTimer(EatDrinkTimer[source])
		EatDrinkTimer[source]=nil
	end
	if(isTimer(HealTimer[source]))then
		killTimer(HealTimer[source])
		HealTimer[source]=nil
	end
end)