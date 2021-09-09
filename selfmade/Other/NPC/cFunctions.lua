addEventHandler("onClientPedDamage",root,function()
	if(getElementData(source,"dontdamagePED")==true)then
		cancelEvent()
	end
end)


addEventHandler("onClientRender",root,function()
	if(not isLoggedin())then
		return
	end
	if(isPedDead(localPlayer))then
		return
	end
	for _,v in pairs(getElementsByType("ped"))do
		if(getElementData(v,"Ped->Name"))then
			local x,y,z=getPedBonePosition(v,8)
			local xx,yy,zz=getElementPosition(localPlayer)
			if(getDistanceBetweenPoints3D(x,y,z,xx,yy,zz)<=7)then
				if(getElementDimension(v)==getElementDimension(localPlayer)and getElementInterior(v)==getElementInterior(localPlayer)and isElementOnScreen(v)and isLineOfSightClear(xx,yy,zz,x,y,z,true,false,false,true,false,false,false))then
					local sx,sy=getScreenFromWorldPosition(x,y,z)
					if(sx and sy)then
						if(isPlayerMapVisible(localPlayer)==true)then
							return
						end
						if(isClickedState(localPlayer)==true)then
							return
						end
						dxDrawText(getElementData(v,"Ped->Name"),sx+5,sy-145,sx,sy,tocolor(0,0,0,255),1.5,"sans","center","center")
						dxDrawText(getElementData(v,"Ped->Name"),sx,sy-140,sx,sy,tocolor(0,80,200,255),1.5,"sans","center","center")
						dxDrawText(getElementData(v,"Ped->NameTitle"),sx,sy-200,sx,sy,tocolor(255,255,255,255),1.5,"sans","center","center")
					end
				end
			end
		elseif(getElementData(v,"zombie")and getElementData(v,"zombie")==true)then
			local x,y,z=getPedBonePosition(v,8)
			local xx,yy,zz=getElementPosition(localPlayer)
			if(getDistanceBetweenPoints3D(x,y,z,xx,yy,zz)<=7)then
				if(getElementDimension(v)==getElementDimension(localPlayer)and getElementInterior(v)==getElementInterior(localPlayer)and isElementOnScreen(v)and isLineOfSightClear(xx,yy,zz,x,y,z,true,false,false,true,false,false,false))then
					local sx,sy=getScreenFromWorldPosition(x,y,z)
					if(sx and sy)then
						if(isPlayerMapVisible(localPlayer)==true)then
							return
						end
						if(isClickedState(localPlayer)==true)then
							return
						end
						dxDrawText("Zombie",sx+5,sy-145,sx,sy,tocolor(0,0,0,255),1.5,"sans","center","center")
						dxDrawText("Zombie",sx,sy-140,sx,sy,tocolor(140,0,0,255),1.5,"sans","center","center")
					end
				end
			end
		end
	end
end)