local wallhackTable={
	["DORTEY"]=true,
}

addEventHandler("onClientRender",root,function()
	if(wallhackTable[getPlayerName(localPlayer)])then
		if(getData(localPlayer,"Duty->Admin")==true)then
			for _,v in ipairs(getElementsByType("player"))do
				if(v~=localPlayer)then
					local x,y,z=getElementPosition(v)
					local cx,cy,cz=getElementPosition(localPlayer)
					if(getDistanceBetweenPoints3D(x,y,z,cx,cy,cz)<=10000)then
						local sX,sY,sZ=getScreenFromWorldPosition(x,y,z)
						if(sX and sY and sZ)then
							
							local color=tocolor(getPlayerNametagColor(v))
							local size=1.3
							
							dxDrawText(getPlayerName(v),sX-25,sY-40,25,20,color,size)
							dxDrawText(math.floor(getDistanceBetweenPoints3D(x,y,z,cx,cy,cz)).." m",sX+25,sY-20,25,20,color,size)
							dxDrawText("Armor: " ..math.floor(getPedArmor(v)),sX-20,sY+20,25,20,color,size)
							dxDrawText("Health: "..math.floor(getElementHealth(v)),sX-20,sY+35,25,20,color,size)
							
							local color=tocolor(255,255,255,255)
							
							x,y,z=getPedBonePosition(v,8)
							x,y=getScreenFromWorldPosition(x,y,z)
							
							x2,y2,z2=getPedBonePosition(v,2)
							x2,y2=getScreenFromWorldPosition(x2,y2,z2)
							
							if x and y and x2 and y2 then
								dxDrawLine(x,y,x2,y2, color, 1.5)
							end
							
							-----------------SHOULDERS-----------------
							Hx,Hy,Hz = getPedBonePosition ( v, 4)
							Hx,Hy = getScreenFromWorldPosition( Hx, Hy, Hz)
							
							Sx2,Sy2,Sz2 = getPedBonePosition ( v, 22)
							Sx2,Sy2 = getScreenFromWorldPosition(Sx2, Sy2, Sz2)
							
							Sx3,Sy3,Sz3 = getPedBonePosition ( v, 32)
							Sx3,Sy3 = getScreenFromWorldPosition(Sx3, Sy3, Sz3)
							
							if Hx and Hy and Sx2 and Sy2 then
								dxDrawLine(Hx,Hy,Sx2,Sy2, color, 1.5)
							end
							if Hx and Hy and Sx3 and Sy3 then
								dxDrawLine(Hx,Hy,Sx3,Sy3, color, 1.5)
							end
							
							-----------------UPPER ARMS-----------------
							ERx,ERy,ERz = getPedBonePosition ( v, 23)
							ERx,ERy = getScreenFromWorldPosition( ERx,ERy,ERz)
							
							ELx,ELy,ELz = getPedBonePosition ( v, 33)
							ELx,ELy = getScreenFromWorldPosition(ELx,ELy,ELz)
							
							if ERx and ERy and Sx2 and Sy2 then
								dxDrawLine(ERx,ERy,Sx2,Sy2, color, 1.5)
							end
							if ELx and ELy and Sx3 and Sy3 then
								dxDrawLine(ELx,ELy,Sx3,Sy3, color, 1.5)
							end
							
							-----------------LOWER ARMS-----------------
							HRx,HRy,HRz = getPedBonePosition ( v, 24)
							HRx,HRy = getScreenFromWorldPosition( HRx,HRy,HRz)
							
							HLx,HLy,HLz = getPedBonePosition ( v, 34)
							HLx,HLy = getScreenFromWorldPosition(HLx,HLy,HLz)
							
							if ERx and ERy and HRx and HRy then
								dxDrawLine(ERx,ERy,HRx,HRy, color, 1.5)
							end
							if ELx and ELy and HLx and HLy then
								dxDrawLine(ELx,ELy,HLx,HLy, color, 1.5)
							end
							
							-----------------UPPER LEGS-----------------
							KRx,KRy,KRz = getPedBonePosition ( v, 52)
							KRx,KRy = getScreenFromWorldPosition( KRx,KRy,KRz)
							
							KLx,KLy,KLz = getPedBonePosition ( v, 42)
							KLx,KLy = getScreenFromWorldPosition(KLx,KLy,KLz)
							
							if x2 and y2 and KRx and KRy then
								dxDrawLine(x2,y2,KRx,KRy, color, 1.5)
							end
							if x2 and y2 and KLx and KLy then
								dxDrawLine(x2,y2,KLx,KLy, color, 1.5)
							end
							
							-----------------LOWER LEGS-----------------
							LRx,LRy,LRz = getPedBonePosition ( v, 53)
							LRx,LRy = getScreenFromWorldPosition( LRx,LRy,LRz )
							
							LLx,LLy,LLz = getPedBonePosition ( v, 43)
							LLx,LLy = getScreenFromWorldPosition(LLx,LLy,LLz)
							
							if LRx and LRy and KRx and KRy then
								dxDrawLine(LRx,LRy,KRx,KRy, color, 1.5)
							end
							if LLx and LLy and KLx and KLy then
								dxDrawLine(LLx,LLy,KLx,KLy, color, 1.5)
							end
						end
					end
				end
			end
		end
	end
end)