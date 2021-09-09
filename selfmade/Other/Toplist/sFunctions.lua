--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

addEvent("Get->Toplist->Data",true)
addEventHandler("Get->Toplist->Data",root,function(category)
	local tbl={}
	local result=dbPoll(dbQuery(DB.HANDLER,"SELECT * FROM stats ORDER BY "..category.." DESC;"),-1)
	if(#result>=1)then
		for i,v in pairs(result)do
			table.insert(tbl,{v["Username"],v[category]})
			if(i>=15)then
				break
			end
		end
	end
	triggerClientEvent(client,"Refresh->Toplist->UI",client,tbl)
end)