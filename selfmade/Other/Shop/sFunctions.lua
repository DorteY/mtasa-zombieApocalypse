local weaponskillsTable={
	[22]={"Colt45",69,Server.Shop.Price.Skills.Colt45},
	[23]={"Silenced",70,Server.Shop.Price.Skills.Silenced},
	[24]={"Deagle",71,Server.Shop.Price.Skills.Deagle},
	[25]={"Shotgun",72,Server.Shop.Price.Skills.Shotgun},
	[26]={"Sawedoff",73,Server.Shop.Price.Skills.Sawedoff},
	[28]={"Uzi",75,Server.Shop.Price.Skills.Uzi},
	[29]={"Mp5",76,Server.Shop.Price.Skills.Mp5},
	[30]={"AK47",77,Server.Shop.Price.Skills.AK47},
	[31]={"M4",78,Server.Shop.Price.Skills.M4},
	[33]={"Rifle",79,Server.Shop.Price.Skills.Rifle},
	[34]={"Sniper",79,Server.Shop.Price.Skills.Sniper},
}
local skinTable={
	[7]={"L4D2 Patient",7,Server.Shop.Price.Skins.ID7},
	[11]={"Victoria Kanayeva",11,Server.Shop.Price.Skins.ID11},
	[12]={"Mai Shiranui",12,Server.Shop.Price.Skins.ID12},
	[13]={"Moira Burton",13,Server.Shop.Price.Skins.ID13},
	[31]={"Tank Girl",31,Server.Shop.Price.Skins.ID31},
}

addEvent("Buy->Shop->Item",true)
addEventHandler("Buy->Shop->Item",root,function(typ,typ2)
	if(typ=="Premium")then
		if(typ2=="7days")then
			buyPremium(client,"7days")
		elseif(typ2=="14days")then
			buyPremium(client,"14days")
		end
	elseif(typ=="Weapondepot")then
		if(getPlayerValue(client,"Coins")>=Server.Shop.Price.Weapondepot)then
			if(getPlayerValue(client,"Weapondepot")==0)then
				addPlayerValue(client,"Weapondepot",1)
				takePlayerValue(client,"Coins",Server.Shop.Price.Weapondepot)
				
				triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information","You bought a Weapon-Depot")
			else
				triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error","You already have a Weapondepot!")
			end
		else
			triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_NotEnoughCoins"))
		end
	elseif(typ=="Itemdepot")then
		if(getPlayerValue(client,"Coins")>=Server.Shop.Price.Itemdepot)then
			addPlayerValue(client,"Itemdepot",1)
			takePlayerValue(client,"Coins",Server.Shop.Price.Itemdepot)
			
			triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information","You bought a Item-Depot")
		else
			triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_NotEnoughCoins"))
		end
	elseif(typ=="Weaponskill")then
		if(getPlayerValue(client,"Coins")>=weaponskillsTable[typ2][3])then
			if(weaponskillsTable[typ2][1])then
				takePlayerValue(client,"Coins",weaponskillsTable[typ2][3])
				setPedStat(client,weaponskillsTable[typ2][2],999)
				setData(client,weaponskillsTable[typ2][1],999)
				triggerClientEvent(client,"Draw->Infobox->UI",client,"Success","Information",getLanguageWord(client,"Server","General","TEXT_SkillBought"))
			end
		else
			triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_NotEnoughCoins"))
		end
	elseif(typ=="Skin")then
		if(getPlayerValue(client,"Coins")>=skinTable[typ2][3])then
			if(getPlayerValue(client,"Skin_"..skinTable[typ2][2])==0)then
				addPlayerValue(client,"Skin_"..skinTable[typ2][2],1)
				takePlayerValue(client,"Coins",skinTable[typ2][3])
			end
		else
			triggerClientEvent(client,"Draw->Infobox->UI",client,"Error","Error",getLanguageWord(client,"Server","General","TEXT_NotEnoughCoins"))
		end
	end
end)




