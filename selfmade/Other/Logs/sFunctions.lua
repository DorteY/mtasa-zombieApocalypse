--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

function outputLog(text,logname)
	if(not text or text==nil)then
		text="nil"
	end
	if(not logname or logname==nil)then
		logname="nil"
	end
	local logtime=getRealTime()
	local year=tostring(logtime.year+1900)
	local month=tostring(logtime.month+1)
	local day=tostring(logtime.monthday)
	local hour=tostring(logtime.hour)
	local minute=tostring(logtime.minute)
	local second=tostring(logtime.second+1)
	if(#month==1)then
		month="0"..month
	end
	if(#day==1)then
		day="0"..day
	end
	if(#hour==1)then
		hour="0"..hour
	end
	if(#minute==1)then
		minute="0"..minute
	end
	if(#second==1)then
		second="0"..second
	end
	logname=logname..".txt"
	
	
	local log=getLog(":"..getResourceName(getThisResource()).."/Logs/"..logname)
	local filesize=fileGetSize(log)
	fileSetPos(log,filesize)
	fileWrite(log,"["..hour..":"..minute..":"..second.."] ["..day.."."..month.."."..year.."]: "..text.."\n")
	fileClose(log)
end
function getLog(path)
	if(not fileExists(path))then
		fileClose(fileCreate(path))
	end
	return fileOpen(path,false)
end