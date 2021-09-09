VehicleSoundNEW={
	[411]=true,
	[415]=true,
	[451]=true,
	[560]=true,
	[541]=true,
	[480]=true,
	[494]=true,
	[502]=true,
	[503]=true,
	[402]=true,
	[429]=true,
	[477]=true,
}
VehicleSoundBIKE={
	[522]=true,
	[521]=true,
	[461]=true,
	[581]=true,
	[463]=true,
}
VehicleSoundLKW={
	[403]=true,
	[406]=true,
	[407]=true,
	[408]=true,
	[414]=true,
	[431]=true,
	[437]=true,
	[443]=true,
	[455]=true,
	[456]=true,
	[514]=true,
	[515]=true,
	[524]=true,
	[544]=true,
	[578]=true,
}
local VehicleStartEngine={}

addEventHandler("onPlayerVehicleEnter",root,function(veh,seat)
	if(veh)then
		if(seat==0)then
			local vehmodel=getElementModel(veh)
			if(vehmodel)then
				if(vehmodel~=481 and vehmodel~=509 and vehmodel~=510)then
					if(not getElementData(veh,"veh:engine"))then
						setElementData(veh,"veh:engine",false)
						setVehicleEngineState(veh,false)
					end
					if(getElementType(source)=="player")then
						if(not isKeyBound(source,"K","down",engineState))then
							bindKey(source,"K","down",engineState)
						end
						if(not isKeyBound(source,"L","down",lightState))then
							bindKey(source,"L","down",lightState)
						end
					end
					
					if(tonumber(getData(source,"Playtime"))<=300)then
						outputChatBox("Press 'K' to turn on/off engine!",source,0,200,0)
						outputChatBox("Press 'L' to turn on/off lights!",source,0,200,0)
					end
				end
			end
		end
	end
end)
addEventHandler("onPlayerVehicleExit",root,function(veh,seat)
	if(veh)then
		if(seat==0)then
			local id=getElementData(veh,"veh:id")
			local fuel=getElementData(veh,"veh:fuel")
			local x,y,z=getElementPosition(veh)
			local rx,ry,rz=getElementRotation(veh)
			local health=getElementHealth(veh)
			if(id)then
				if(not(isElementInWater(veh))and getElementHealth(veh)>=300)then
					dbExec(DB.HANDLER,"UPDATE ?? SET ??=?,??=?,??=?,??=?,??=?,??=?,??=?,??=? WHERE ??=?","vehicles","SpawnX",x,"SpawnY",y,"SpawnZ",z,"RotX",rx,"RotY",ry,"RotZ",rz,"Fuel",fuel,"Health",health,"ID",id)
				end
			end
			
			if(getElementType(source)=="player")then
				if(isKeyBound(source,"K","down",engineState))then
					unbindKey(source,"K","down",engineState)
				end
				if(isKeyBound(source,"L","down",lightState))then
					unbindKey(source,"L","down",lightState)
				end
			end
		end
	end
end)

--//Engine/Light funcs
function engineState(player)
	if(isPedInVehicle(player))then
		if(getPedOccupiedVehicleSeat(player)==0)then
			local veh=getPedOccupiedVehicle(player)
			if(veh and isElement(veh))then
				local x,y,z=getElementPosition(veh)
				local rdm=math.random(1,16)
				if(getElementSpeed(veh,"km/h")<=45)then
					if(getElementData(veh,"veh:id"))then
						local fuel=tonumber(getElementData(veh,"veh:fuel"))or 0
						if(fuel>1)then
							if(getVehicleEngineState(veh)==false and getElementData(veh,"veh:engine")==false)then
								if(not isTimer(VehicleStartEngine[veh]))then
									if(x and y and z)then
										if(VehicleSoundNEW[getElementModel(veh)])then
											triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/Motor_New.mp3",1)
										elseif(VehicleSoundBIKE[getElementModel(veh)])then
											triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/Motor_Bike.mp3",1)
										elseif(VehicleSoundLKW[getElementModel(veh)])then
											triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/Motor_LKW.mp3",1)
										else
											triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/Motor_Old.mp3",1)
										end
									end
									VehicleStartEngine[veh]=setTimer(function(veh)
										setElementData(veh,"veh:engine",true)
										setVehicleEngineState(veh,true)
										if not getElementData(veh,"timerrunning")then
											setElementData(veh,"timerrunning",true)
											updateVehicleStats(veh)
										end
										killTimer(VehicleStartEngine[veh])
										VehicleStartEngine[veh]=nil
									end,2000,1,veh)
								end
							else
								if(x and y and z)then
									triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/Motor_Stop.mp3",1)
								end
								setElementData(veh,"veh:engine",false)
								setVehicleEngineState(veh,false)
							end
						else
							--triggerClientEvent(player,"Draw->Infobox->UI",player,"Error","Error","Dem Fahrzeug ist der Benzin ausgegangen!")todo
						end
					end
				end
			end
		end
	end
end
function updateVehicleStats(veh)
	if(isElement(veh))then
		if(getVehicleEngineState(veh)==true and getElementData(veh,"veh:engine")==true)then
			local speed=getElementSpeed(veh,"km/h")
			local _,usage=getVehicleFuelSizeUsage(veh)
			
			usage=usage*3
			if(speed>=150)then
				usage=(usage*100)/70
			elseif(speed>=100)then
				usage=usage
			elseif(speed>=3)then
				usage=(usage/100)*70
			else
				usage=(usage/100)*25
			end
			
			setElementData(veh,"veh:fuel",tonumber(getElementData(veh,"veh:fuel"))-usage)
			if(getElementData(veh,"veh:fuel")<1)then
				saveBenzinForPrivVeh(veh)
				setVehicleEngineState(veh,false)
				setElementData(veh,"veh:engine",false)
				setElementData(veh,"timerrunning",false)
			elseif math.floor(getElementData(veh,"veh:fuel"))/5==math.floor(getElementData(veh,"veh:fuel")/5)then
				saveBenzinForPrivVeh(veh)
				setTimer(updateVehicleStats,1000,1,veh)
			else
				setTimer(updateVehicleStats,1000,1,veh)
			end
		else
			setElementData(veh,"timerrunning",false)
		end
	end
end
function saveBenzinForPrivVeh(veh)
	local id=getElementData(veh,"veh:id")
	local fuel=getElementData(veh,"veh:fuel")
	if(id and fuel)then
		dbExec(DB.HANDLER,"UPDATE ?? SET ??=? WHERE ??=?","vehicles","Fuel",fuel,"ID",id)
	end
end

function lightState(player)
	if(isLoggedin(player))then
		if(isPedInVehicle(player))then
			if(getPedOccupiedVehicleSeat(player)==0)then
				local veh=getPedOccupiedVehicle(player)
				if(veh and isElement(veh))then
					local x,y,z=getElementPosition(veh)
					if(getVehicleOverrideLights(veh)~=2)then
						setVehicleOverrideLights(veh,2)
						if(x and y and z)then
							triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/LightOn.mp3",1)
						end
					else
						setVehicleOverrideLights(veh,1)
						if(x and y and z)then
							triggerClientEvent(root,"play:stop:sound",root,"play",x,y,z,false,"Vehicle/LightOff.mp3",1)
						end
					end
				end
			end
		end
	end
end


--//Load vehicles from Database
addEventHandler("onResourceStart",resourceRoot,function()
	local Counter=0
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM vehicles"),-1)
	if(result and result[1])then
		for i=1,#result do
			local dsatz=result[i]
			local ID=tonumber(dsatz["ID"])
			if(ID)then
				local VehID=dsatz["VehID"]
				local SpawnX=dsatz["SpawnX"]
				local SpawnY=dsatz["SpawnY"]
				local SpawnZ=dsatz["SpawnZ"]
				local RotX=dsatz["RotX"]
				local RotY=dsatz["RotY"]
				local RotZ=dsatz["RotZ"]
				local Health=dsatz["Health"]
				
				local Fuel=dsatz["Fuel"]
				
				if(not(isElement(Server.Vehicles[ID])))then
					Server.Vehicles[ID]=createVehicle(VehID,SpawnX,SpawnY,SpawnZ,RotX,RotY,RotZ," ")
					
					setElementData(Server.Vehicles[ID],"veh:id",ID)
					setElementData(Server.Vehicles[ID],"veh:fuel",Fuel)
					
					setElementHealth(Server.Vehicles[ID],Health)
					setVehicleOverrideLights(Server.Vehicles[ID],1)
					setVehicleLocked(Server.Vehicles[ID],false)
					--setVehicleDoorsUndamageable(Server.Vehicles[Owner],true)
					
					Counter=Counter+1
				end
			end
		end
		print("[MYSQL] Loaded Vehicles (x"..Counter..")")
	end
end)


--//Other funcs
local VehicleRespawnTable={}
addEventHandler("onVehicleExplode",root,function()
	if(isElement(source))then
		local x,y,z=getElementPosition(source)
		createExplosion(x,y,z,6)
		
		local VehicleID=getElementData(source,"veh:id")
		if(VehicleID)then
			VehicleRespawnTable[source]=setTimer(function(source)
				destroyElement(source)
				dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","vehicles","ID",VehicleID)
			end,5*60*1000,1,source)
		end
	end
end)