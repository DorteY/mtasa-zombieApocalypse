function addPlayerAchievment(player,achievment,text,amount)
	if(isElement(player))then
		if(isLoggedin(player))then
			local pname=getPlayerName(player)
			local sql=getMySQLData("achievement","Username",pname,achievment)
			if(sql==0)then
				addPlayerValue(player,"Coins",amount)
				dbExec(DB.HANDLER,"UPDATE ?? SET "..achievment.."=? WHERE ??=?","achievement",1,"Username",pname)
				triggerClientEvent(player,"Draw->Achievement->UI",player,text,amount)
			end
		end
	end
end