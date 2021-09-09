--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

--//Infobox
local sound=nil
local startInfoboxAlpha=0
local infoboxTimer=nil

addEvent("Draw->Infobox->UI",true)
addEventHandler("Draw->Infobox->UI",root,function(typ,textbar,text,time)
	if(isTimer(infoboxTimer))then
		killTimer(infoboxTimer)
		infoboxTimer=nil
		removeEventHandler("onClientRender",root,dxDrawInfobox)
		startInfoboxAlpha=0
	end
	
	removeEventHandler("onClientRender",root,dxDrawInfobox)
	addEventHandler("onClientRender",root,dxDrawInfobox)
	
	if(typ)then
		infoboxText=text or "NOT FOUND"
		infoboxTextBar=textbar or "Information"
		if(typ=="Error")then
			infoboxColor={200,0,0}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="Success")then
			infoboxColor={0,200,0}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="Info")then
			infoboxColor={0,110,220}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		elseif(typ=="Warning")then
			infoboxColor={200,200,0}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		else
			infoboxColor={255,255,255}
			if(isElement(sound))then
				destroyElement(sound)
				sound=nil
			end
		end
		sound=playSound(":"..getResourceName(getThisResource()).."/Files/Sounds/Infobox/"..typ..".mp3")
		setSoundVolume(sound,0.6)
	end
	TimerInfoStart=time or 7
	TimerInfoEnd=time or 7
	infoboxTimer=setTimer(function()
		TimerInfoStart=TimerInfoStart-1
		if(TimerInfoStart==0)then
			removeEventHandler("onClientRender",root,dxDrawInfobox)
			if(isTimer(infoboxTimer))then
				killTimer(infoboxTimer)
				infoboxTimer=nil
				removeEventHandler("onClientRender",root,dxDrawInfobox)
				startInfoboxAlpha=0
			end
		end
	end,1000,TimerInfoStart)
end)
function dxDrawInfobox()
	if(190~=startInfoboxAlpha)then
		if(190<startInfoboxAlpha)then
			local diff=startInfoboxAlpha-190
			local rem=math.ceil(diff/150)
			startInfoboxAlpha=startInfoboxAlpha-rem
		else
			local diff=190-startInfoboxAlpha
			local rem=math.ceil(diff/150)
			startInfoboxAlpha=startInfoboxAlpha+rem
		end
	end
	
	dxDrawRectangle(790*Gsx,30*Gsy,330*Gsx,130*Gsy,tocolor(0,0,0,startInfoboxAlpha),false)
	dxDrawRectangle(790*Gsx,30*Gsy,330*Gsx,25*Gsy,tocolor(infoboxColor[1],infoboxColor[2],infoboxColor[3],startInfoboxAlpha),false)
	
	dxDrawText(infoboxTextBar,1715*Gsx,34*Gsy,200*Gsx,20*Gsy,tocolor(255,255,255,startInfoboxAlpha),1.12,"default-bold","center",_,_,_,false,_,_)
	dxDrawText(infoboxText,1715*Gsx,165*Gsy,200*Gsx,30*Gsy,tocolor(255,255,255,startInfoboxAlpha),1.20,"default","center","center",_,_,false,_,_)
	
	dxDrawRectangle(795*Gsx,145*Gsy,320*Gsx,10*Gsy,tocolor(255,255,255,startInfoboxAlpha),false)
	dxDrawRectangle(795*Gsx,145*Gsy,(TimerInfoEnd-TimerInfoStart)/TimerInfoEnd*320*Gsx,10*Gsy,tocolor(infoboxColor[1],infoboxColor[2],infoboxColor[3],startInfoboxAlpha),false)
end