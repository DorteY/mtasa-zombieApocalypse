--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

addEventHandler("onPlayerChat",root,function(message,messageType)
	if(isLoggedin(source))then
		if(not isPedDead(source))then
			if(messageType==0)then
				local x,y,z=getElementPosition(source)
				local interior=getElementInterior(source)
				local dimension=getElementDimension(source)
				local pname=getPlayerName(source)
				
				for _,v in pairs(getElementsByType("player"))do
					if(isLoggedin(v))then
						local vx,vy,vz=getElementPosition(v)
						local vinterior=getElementInterior(v)
						local vdimension=getElementDimension(v)
						
						if(interior==vinterior and dimension==vdimension)then
							if(getDistanceBetweenPoints3D(x,y,z,vx,vy,vz)<=10)then
								outputChatBox("[LOCAL]: "..pname.." says: "..message,v,255,255,255)
								triggerClientEvent(v,"play:stop:sound",v,"play",x,y,z,false,"Message.mp3",1)
							end
						end
					end
				end
				outputLog("[LOCAL]: "..pname.." says: "..message,"Chat")
			elseif(messageType==2)then
			end
		end
	end
	cancelEvent()
end)