--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local crashTimer=nil

addEventHandler("onClientVehicleCollision",root,function()
	if(not isLoggedin())then
		return
	end
	if(not isPedInVehicle(localPlayer))then
		return
	end
	local veh=getPedOccupiedVehicle(localPlayer)
	if(not veh)then
		return
	end
	local rx,ry,rz=getElementRotation(veh)
	if(rx>=80 and rx<=220)then
		toggleControl("vehicle_left",false)
		toggleControl("vehicle_right",false)
		if(not isTimer(crashTimer))then
			crashTimer=setTimer(function()
				setElementFrozen(veh,true)
			end,30*1000,1)
		else
			killTimer(crashTimer)
		end
	else
		toggleControl("vehicle_left",true)
		toggleControl("vehicle_right",true)
		if(isTimer(crashTimer))then
			killTimer(crashTimer)
			crashTimer=nil
		end
	end
end)


addEventHandler("onClientRender",root,function()
	if(not isLoggedin())then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	local x,y,z=getElementPosition(localPlayer)
	for _,v in ipairs(getElementsByType("vehicle"))do
		if(v and isElement(v))then
			if(v~=getPedOccupiedVehicle(localPlayer))then
				local vx,vy,vz=getElementPosition(v)
				local distance=getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)
				if(distance<=10)then
					local x,y=getScreenFromWorldPosition(vx,vy,vz+1.3)
					if(x and y)then
						dxDrawRectangle(x-200/2,y,200,30,tocolor(255,255,255,120))
						dxDrawEdge(x-200/2,y,200,30,3,255)
						dxDrawText(Server.Vehicle.Names[getElementModel(v)] or "not found",x-200/2,y,200+x-200/2,30+y,tocolor(0,0,0,255),1,"sans","center","center",false,false,true,true)
					end
				end
			end
		end
	end
end)