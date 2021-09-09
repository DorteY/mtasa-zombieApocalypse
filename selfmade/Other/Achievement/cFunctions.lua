--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

local x,y=guiGetScreenSize()
local AchievmentText=nil
local achieveAlpha=0

addEvent("Draw->Achievement->UI",true)
addEventHandler("Draw->Achievement->UI",root,function(text,amount)
	AchievmentText=text
	AchievmentCoins=amount
	
	if(isClickedState(localPlayer)==false)then
	addEventHandler("onClientRender",root,renderAchievment)
		setTimer(function()
			AchievmentText=nil
			removeEventHandler("onClientRender",root,renderAchievment)
			achieveAlpha=0
		end,15*1000,1)
	else
		outputChatBox("Achievment reached: "..text.." - You get x"..AchievmentCoins.." Coins.",255,255,255,true)
	end
end)

function renderAchievment()
	if(isClickedState(localPlayer)==false)then
		if(255~=achieveAlpha)then
			if(255<achieveAlpha)then
				local diff=achieveAlpha-255
				local rem=math.ceil(diff/150)
				achieveAlpha=achieveAlpha-rem
			else
				local diff=255-achieveAlpha
				local rem=math.ceil(diff/150)
				achieveAlpha=achieveAlpha+rem
			end
		end
		
		dxDrawImage(0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,"Files/Images/Bar.png",0,0,0,tocolor(255,255,255,achieveAlpha),false)
        dxDrawText("Achievement reached!!\n"..AchievmentText.."\n+ x"..AchievmentCoins.." Coins",0*Gsx,0*Gsy,1920*Gsx,1080*Gsy,tocolor(160,0,0,achieveAlpha),1.80,"default","center","center",false,false,false,false,false)
	end
end