--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local function rgbFromHealth(player)
	local health=getElementHealth(player)
	local armor=getPedArmor(player)
	if(health<=0)then
		return 0,0,0
	elseif(armor>0)then
		if(health>100)then
			return 2.55*armor,255,health*1.275+(255-health*1.275)*(armor/100)
		else
			return 2.55*armor,2.55*health+(255-2.55*health)*(armor/100),2.55*armor
		end
	elseif(health>100)then
		return 0,255,health*1.275
	else
		return(100-health)*2.55/2,(health*2.55),0
	end
end



addEventHandler("onClientRender",root,function()
	if(not isLoggedin())then
		return
	end
	if(isPedDead(localPlayer))then
		return
	end
	if(isClickedState(localPlayer)==true)then
		return
	end
	for _,v in pairs(getElementsByType("player"))do
		local x,y,z=getPedBonePosition(v,8)
		local xx,yy,zz=getElementPosition(localPlayer)
		if(getDistanceBetweenPoints3D(x,y,z,xx,yy,zz)<=8)then
			if(getElementDimension(v)==getElementDimension(localPlayer)and getElementInterior(v)==getElementInterior(localPlayer)and isElementOnScreen(v)and isLineOfSightClear(xx,yy,zz,x,y,z,true,false,false,true,false,false,false)--[[and v~=localPlayer]])then
				local sx,sy=getScreenFromWorldPosition(x,y,z)
				if(sx and sy)then
					if(isLoggedin(v))then
						local r,g,b=rgbFromHealth(v)
						local adminlevel=tonumber(getData(v,"AdminLevel"))or 0
						local premiumlevel=tonumber(getData(v,"Premium"))or 0
						local afk=getData(v,"AFK")or false
						
						--//Nametag
						local Nametag=""
						if(afk==true)then
							Nametag="[AFK] "
						else
							if(adminlevel>=1)then
								Nametag="[DoubleZ] "
							elseif(premiumlevel==1)then
								Nametag="[V.I.P] "
							end
						end
						--//Icons
						--[[if(isChatBoxInputActive())then
							setElementData(localPlayer,"isChatBoxInputActive",true)
						else
							setElementData(localPlayer,"isChatBoxInputActive",false)
						end
						
						if(getElementData(localPlayer,"isChatBoxInputActive")==true)then
							dxDrawImage(sx-15,sy-60,30,30,"FIles/Images/Nametag/Typing.png")
						end]]
						
						
						dxDrawText(Nametag..getPlayerName(v),sx+3,sy-163,sx,sy,tocolor(0,0,0,255),1.5,"sans","center","center")
						dxDrawText(Nametag..getPlayerName(v),sx,sy-160,sx,sy,tocolor(r,g,b,255),1.5,"sans","center","center")
						if(getData(v,"Duty->Admin")==true)then
							dxDrawText("Adminmode",sx,sy-220,sx,sy,tocolor(255,0,0,255),1.2,"sans","center","center")
						end
					end
				end
			end
		end
	end
end)



for _,v in pairs(getElementsByType("player"))do
	setPlayerNametagShowing(v,false)
end
addEventHandler("onClientPlayerJoin",root,function()
	setPlayerNametagShowing(source,false)
end)