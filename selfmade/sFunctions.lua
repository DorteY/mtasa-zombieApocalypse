--//MySQL
DB={
	HOST="127.0.0.1",
	PORT="3306",
	NAME="DoubleZ",
	PASS="52jfsfa@@fds978fa_9722fjal@@",
	USER="DoubleZ",
	HANDLER=nil,
}

addEventHandler("onResourceStart",resourceRoot,function()
	DB.HANDLER=dbConnect("mysql","dbname="..DB.NAME..";host="..DB.HOST..";charset=utf8;port="..DB.PORT,DB.USER,DB.PASS,"autoreconnect=1")
	print("[MYSQL] Opening connection to MySQL database..")
	if(DB.HANDLER)then
		print("[MYSQL] Connection to the MySQL database was successfully established!")
	else
		print("[MYSQL] Failed to connect to MySQL database!")
		stopResource(resource)
	end
	
    for _,v in pairs(getResources())do
        if(getResourceState(v)=="running" and v~=getThisResource()and v~=getResourceFromName("DGS")and v~=getResourceFromName("admin")and v~=getResourceFromName("reload")and v~=getResourceFromName("resourcebrowser")and v~=getResourceFromName("resourcemanager")and v~=getResourceFromName("zombies"))then
			stopResource(v)
			startResource(getResourceFromName("admin"))
			startResource(getResourceFromName("reload"))
			startResource(getResourceFromName("zombies"))
        end
    end
end)

addEventHandler("onResourceStop",resourceRoot,function()
	for _,v in pairs(getElementsByType("player"))do
		if(isLoggedin(v))then
			savePlayerDatas(v)
			setClickedState(v,false)
			setElementData(v,"Loggedin",0)
			
			local rdm=math.random(100000,999999)
			setPlayerName(v,"LAKEZ-"..rdm)
		end
	end
	if(DB.HANDLER)then
		destroyElement(DB.HANDLER)
		DB.HANDLER=nil
	end
end)

addEventHandler("onPlayerConnect",root,function(ni,ip,uni,se,ver)
	local result=nil
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","bans","TargetSerial",se),-1)
	local deleteit=false
	if(result and result[1])then
		for i=1,#result do
			if(result[i]["Time"]~=0 and(result[i]["Time"]-getTBanSecTime(0))<=0)then
				deleteit=true
			else
				local admin=tostring(result[i]["Admin"])
				local reason=tostring(result[i]["Reason"])
				local time=math.floor(((result[i]["Time"]-getTBanSecTime(0))/60)*100)/100
				if(time>=0)then
					cancelEvent(true,"Du wurdest von "..admin.." gebannt! Grund: "..reason..", Zeit: "..time)
				else
					cancelEvent(true,"Du wurdest von "..admin.." permanent gebannt! Grund: "..reason)
				end
				return
			end
		end
		if(deleteit==true)then
			dbExec(DB.HANDLER,"DELETE FROM ?? WHERE ??=?","bans","TargetSerial",se)
		end
	end
	
	if(Server.WhitelistState==true)then
		local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?","whitelist","Serial",se),-1)
		if(result and result[1])then
			if(result[1]["Access"]~="Yes")then
				cancelEvent(true,"You are on the Whitelist, but without Acces!\n"..Server.Discord.."")
			end
		else
			cancelEvent(true,"You are not on the Whitelist!\n"..Server.Discord.."")
		end
	end
end)

function getMySQLData(from,where,name,data)
	local sql=dbQuery(DB.HANDLER,"SELECT * FROM ?? WHERE ??=?",from,where,name)
	local row=dbPoll(sql,-1)
	if(#row>=1)then
		return row[1][data]
	end
end


function spawnLoot()
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ??","lootpositions"),-1)
	if(result and result[1])then
		for i=1,#result do
			local id=tonumber(result[i]["ID"])
			local x=result[i]["SpawnX"]
			local y=result[i]["SpawnY"]
			local z=result[i]["SpawnZ"]
			local rz=result[i]["RotZ"]
			local LootPriority=tonumber(result[i]["LootPriority"])
			
			if(isElement(Loot[id]))then
				destroyElement(Loot[id])
			end
			
			Loot[id]=createObject(2969,x,y,z,0,0,rz)
			setElementData(Loot[id],"Element->Type->Lootbox",true)
			setElementData(Loot[id],"Loot->ID",id)
			
			setElementCollisionsEnabled(Loot[id],true)
			setElementDoubleSided(Loot[id],true)
			
			if(LootPriority==0)then
				local rdmSpawnItem=math.random(1,300)
				
				local rdm=math.random(0,2)
				setElementData(Loot[id],"Loot->Item->Pastacan",tonumber(rdm))
				local rdm=math.random(0,2)
				setElementData(Loot[id],"Loot->Item->Ravioli",tonumber(rdm))
				local rdm=math.random(0,2)
				setElementData(Loot[id],"Loot->Item->Cola",tonumber(rdm))
				local rdm=math.random(0,2)
				setElementData(Loot[id],"Loot->Item->Pepsi",tonumber(rdm))
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=50)then
					local rdm=math.random(0,5)
					setElementData(Loot[id],"Loot->Item->Coins",tonumber(rdm))
				end
				if(rdmSpawnItem>=33 and rdmSpawnItem<=80)then
					local rdm=math.random(0,1)
					setElementData(Loot[id],"Loot->Item->Fuelcan",tonumber(rdm))
				end
			end
			if(LootPriority==1)then
				local rdmSpawnItem=math.random(1,220)
				
				local rdm=math.random(0,3)
				setElementData(Loot[id],"Loot->Item->Pastacan",tonumber(rdm))
				local rdm=math.random(0,3)
				setElementData(Loot[id],"Loot->Item->Ravioli",tonumber(rdm))
				local rdm=math.random(0,3)
				setElementData(Loot[id],"Loot->Item->Cola",tonumber(rdm))
				local rdm=math.random(0,3)
				setElementData(Loot[id],"Loot->Item->Pepsi",tonumber(rdm))
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=75)then
					local rdm=math.random(0,5)
					setElementData(Loot[id],"Loot->Item->Coins",tonumber(rdm))
				end
				if(rdmSpawnItem>=33 and rdmSpawnItem<=120)then
					local rdm=math.random(0,1)
					setElementData(Loot[id],"Loot->Item->Fuelcan",tonumber(rdm))
				end
			end
			if(LootPriority==2)then
				local rdmSpawnItem=math.random(1,160)
				
				local rdm=math.random(0,5)
				setElementData(Loot[id],"Loot->Item->Pastacan",tonumber(rdm))
				local rdm=math.random(0,5)
				setElementData(Loot[id],"Loot->Item->Ravioli",tonumber(rdm))
				local rdm=math.random(0,5)
				setElementData(Loot[id],"Loot->Item->Cola",tonumber(rdm))
				local rdm=math.random(0,5)
				setElementData(Loot[id],"Loot->Item->Pepsi",tonumber(rdm))
				local rdm=math.random(0,3)
				setElementData(Loot[id],"Loot->Item->Fuelcan",tonumber(rdm))
				
				if(rdmSpawnItem>=33 and rdmSpawnItem<=75)then
					local rdm=math.random(0,30)
					setElementData(Loot[id],"Loot->Item->Coins",tonumber(rdm))
				end
			end
			
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,spawnLoot)

addEventHandler("onResourceStart",resourceRoot,function()
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM ??","itemdepots"),-1)
	if(result and result[1])then
		for i=1,#result do
			local id=tonumber(result[i]["ID"])
			local owner=result[i]["Owner"]
			local x=result[i]["SpawnX"]
			local y=result[i]["SpawnY"]
			local z=result[i]["SpawnZ"]
			local rz=result[i]["Rot"]
			
			Itemdepots[id]=createObject(1271,x,y,z-0.6,0,0,rz)
			setElementData(Itemdepots[id],"Element->Type->Itemdepot",true)
			setElementData(Itemdepots[id],"Itemdepot->ID",id)
		end
	end
end)

--//Set stuff by start
local LootTimer=nil
local function setStuffByStart()
	local time=getRealTime()
	local hour=time.hour
	local minute=time.minute
	
	setTime(hour,minute)
	setMinuteDuration(60000)
	--
	setGameType("Apocalypse "..Server.Version)
	setFPSLimit(60)
	if(Server.WhitelistState==true)then
		setServerPassword("lakeZ")
	else
		setServerPassword("")
	end
	
	if(not isTimer(LootTimer))then
		LootTimer=setTimer(function()
			spawnLoot()
			killTimer(LootTimer)
			LootTimer=nil
			outputChatBox("WARNING: Loot respawn!",root,200,0,0)
		end,2*60*60*1000,0)
	end
end
setTimer(setStuffByStart,1000,1)

--//Other func
function getSecTime(duration)
	local time=getRealTime()
	local year=time.year
	local day=time.yearday
	local hour=time.hour
	local minute=time.minute
	
	return year*365*24*60+day*24*60+(hour+duration)*60+minute
end

function stringTextWithAllParameters(...)
	local tbl={...}
	return table.concat(tbl," ")
end

addEvent("Trigger->Command",true)
addEventHandler("Trigger->Command",root,function(cmd,...)
	executeCommandHandler(cmd,client,...)
end)

function addPlayerValue(player,item,amount)
	if(isElement(player))then
		if(item and amount)then
			setData(player,item,tonumber(getData(player,item))+amount)
			if(item=="Hunger" or item=="Thirst")then
				if(tonumber(getData(player,item))>=100)then
					setData(player,item,100)
				end
			end
		end
	end
end
function takePlayerValue(player,item,amount)
	if(isElement(player))then
		if(item and amount)then
			if(tonumber(getData(player,item))>=amount)then
				setData(player,item,tonumber(getData(player,item))-amount)
			end
		end
	end
end
function getPlayerValue(player,item)
	if(isElement(player))then
		if(item)then
			return tonumber(getData(player,item))
		end
	end
end

function damagePlayer(player,amount,damager,weapon)
	local amount=amount
	if(isElement(player))then
		local armor=getPedArmor(player)
		local health=getElementHealth(player)
		local died=false
		if(armor>0)then
			if(armor>=amount)then
				setPedArmor(player,armor-amount)
			else
				setPedArmor(player,0)
				local newamount=amount-armor
				if(health-newamount<=0)then
					killPed(player,damager,weapon,3,false)
					amount=armor+health
					died=true
				else
					setElementHealth(player,health-newamount)
				end
			end
		else
			if(health-amount<=0)then
				amount=health
				killPed(player,damager,weapon,3,false)
				died=true
			else
				setElementHealth(player,health-amount)
			end
		end
	end
end


function getSecTime(duration)
	local time=getRealTime()
	local year=tostring(time.year+1900)
	local day=tostring(time.monthday)
	local hour=tostring(time.hour)
	local minute=tostring(time.minute)
	
	if(not duration)then
		duration=0
	end
	local total=year*365*24*60+day*24*60+(hour+duration)*60+minute
	return total
end

function getTBanSecTime(duration)
	return getSecTime(duration)
end