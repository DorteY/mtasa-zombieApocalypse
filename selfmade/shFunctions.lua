--//Tables
Loot={}
AFKPlayerTable={}
Itemdepots={}

Server={
	Vehicles={},
	
	Name="DoubleZ",
	Discord="https://discord.gg/E2ZkSwy",
	Version="0.9",
	
	InvalidCharacters={"!","_","§","$","%","&","/","@","(",")",".","'","=","?","´","`","#","*","#","°","^","<",">","{","}",";",":","|","[","]","none"},
	
	WhitelistState=false,
	
	LevelEXP={
		[1]=1000,
		[2]=2000,
		[3]=3000,
		[4]=4000,
		[5]=5000,
		[6]=6000,
		[7]=7000,
		[8]=8000,
		[9]=9000,
		[10]=10000,
		[11]=11000,
		[12]=12000,
		[13]=13000,
		[14]=14000,
		[15]=15000,
		[16]=16000,
		[17]=17000,
		[18]=18000,
		[19]=19000,
		[20]=20000,
		[21]=21000,
		[22]=22000,
		[23]=23000,
		[24]=24000,
		[25]=25000,
		[26]=26000,
		[27]=27000,
		[28]=28000,
		[29]=29000,
		[30]=30000,
		[31]=31000,
		[32]=32000,
		[33]=33000,
		[34]=34000,
		[35]=35000,
		[36]=36000,
		[37]=37000,
		[38]=38000,
		[39]=39000,
		[40]=40000,
		[41]=41000,
		[42]=42000,
		[43]=43000,
		[44]=44000,
		[45]=45000,
		[46]=46000,
		[47]=47000,
		[48]=48000,
		[49]=49000,
		[50]=50000,
		[51]=1,
	},
	Weapon={
		Damage={
			[0]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
			[4]={[3]=10,[4]=9,[5]=5,[6]=5,[7]=5,[8]=5,[9]=20},
			[8]={[3]=20,[4]=20,[5]=20,[6]=20,[7]=20,[8]=20,[9]=25},
			[10]={[3]=9,[4]=9,[5]=9,[6]=9,[7]=9,[8]=9,[9]=9},
			[16]={[3]=80,[4]=80,[5]=50,[6]=50,[7]=50,[8]=50,[9]=130},
			[17]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
			[18]={[3]=5,[4]=5,[5]=5,[6]=5,[7]=5,[8]=5,[9]=5},
			[22]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=15},
			[23]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=15},
			[24]={[3]=49,[4]=40,[5]=29,[6]=29,[7]=35,[8]=35,[9]=65},
			[25]={[3]=25,[4]=25,[5]=20,[6]=20,[7]=20,[8]=20,[9]=35},
			[26]={[3]=30,[4]=30,[5]=20,[6]=20,[7]=20,[8]=20,[9]=35},
			[27]={[3]=30,[4]=30,[5]=20,[6]=20,[7]=20,[8]=20,[9]=40},
			[28]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=10},
			[29]={[3]=9,[4]=9,[5]=8,[6]=8,[7]=8,[8]=8,[9]=12},
			[32]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=10},
			[30]={[3]=10,[4]=10,[5]=8,[6]=8,[7]=8,[8]=8,[9]=14},
			[31]={[3]=9,[4]=9,[5]=7,[6]=7,[7]=7,[8]=7,[9]=12},
			[33]={[3]=15,[4]=15,[5]=12,[6]=12,[7]=12,[8]=12,[9]=20},
			[34]={[3]=15,[4]=15,[5]=12,[6]=12,[7]=12,[8]=12,[9]=200},
			[35]={[3]=80,[4]=80,[5]=50,[6]=50,[7]=50,[8]=50,[9]=130},
			[36]={[3]=80,[4]=80,[5]=50,[6]=50,[7]=50,[8]=50,[9]=130},
			[37]={[3]=8,[4]=8,[5]=5,[6]=5,[7]=5,[8]=5,[9]=12},
			[38]={[3]=8,[4]=8,[5]=6,[6]=6,[7]=6,[8]=6,[9]=12},
			[39]={[3]=200,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200},
			[51]={[3]=200,[4]=200,[5]=200,[6]=200,[7]=200,[8]=200,[9]=200},
		},
	},
	Admin={
		Level={
			[4]="Projectleader",
			[3]="Administrator",
			[2]="Moderator",
			[1]="Supporter",
			[0]="Player",
			
			Color={
				[4]="#ff8484",
				[3]="#008106",
				[2]="#0097ff",
				[1]="#e2dc00",
				[0]="#ffffff",
			},
			Color2={
				[4]=tocolor(255,132,132,255),
				[3]=tocolor(0,130,0,255),
				[2]=tocolor(0,150,255,255),
				[1]=tocolor(225,225,0,255),
				[0]=tocolor(255,255,255,255),
			}
		},
	},
	Shop={
		Price={
			Weapondepot=6000,
			Itemdepot=3500,
			
			Skills={
				Colt45=1000,
				Silenced=1000,
				Deagle=8000,
				Shotgun=5000,
				Sawedoff=5000,
				Uzi=5000,
				Mp5=10000,
				AK47=18000,
				M4=22000,
				Rifle=30000,
				Sniper=32000,
			},
			Skins={
				ID7=6800,
				ID11=6500,
				ID12=8000,
				ID13=7000,
				ID31=7300,
			}
		},
	},
	Vehicle={
		Names={
			[411]="BMW E63 645Ci",
			[575]="Broadway",
			[558]="Cadillac Eldorado Brougham",
			[542]="Clover Rusty",
			[547]="Chevrolet Corsa",
			[433]="Military Truck",
			[527]="VW Golf G2",
			[445]="Holden Statesman",
			[549]="Tampa FAF",
		},
		TypeIDS={
			SmallCars={
				[496]=true,
				[401]=true,
				[527]=true,
				[589]=true,
				[410]=true,
				[436]=true,
				[439]=true,
				[574]=true,
				[530]=true,
				[572]=true,
				[583]=true,
				[441]=true,
				[464]=true,
				[594]=true,
				[501]=true,
				[465]=true,
				[564]=true,
				[568]=true,
				[424]=true,
				[457]=true,
				[571]=true,
				[539]=true,
			},
			MiddleCars={
				[602]=true,
				[518]=true,
				[419]=true,
				[587]=true,
				[533]=true,
				[526]=true,
				[474]=true,
				[545]=true,
				[517]=true,
				[600]=true,
				[549]=true,
				[491]=true,
				[445]=true,
				[604]=true,
				[507]=true,
				[587]=true,
				[466]=true,
				[492]=true,
				[546]=true,
				[551]=true,
				[516]=true,
				[467]=true,
				[426]=true,
				[547]=true,
				[405]=true,
				[580]=true,
				[550]=true,
				[566]=true,
				[540]=true,
				[421]=true,
				[529]=true,
				[438]=true,
				[420]=true,
				[470]=true,
				[596]=true,
				[598]=true,
				[597]=true,
				[536]=true,
				[575]=true,
				[534]=true,
				[567]=true,
				[535]=true,
				[576]=true,
				[412]=true,
				[402]=true,
				[542]=true,
				[603]=true,
				[475]=true,
				[429]=true,
				[541]=true,
				[415]=true,
				[480]=true,
				[562]=true,
				[565]=true,
				[434]=true,
				[411]=true,
				[559]=true,
				[560]=true,
				[506]=true,
				[451]=true,
				[558]=true,
				[555]=true,
				[477]=true,
				[504]=true,
				[500]=true,
			},
			BigCars={
				[409]=true,
				[525]=true,
				[599]=true,
				[601]=true,
				[422]=true,
				[482]=true,
				[605]=true,
				[418]=true,
				[543]=true,
				[478]=true,
				[554]=true,
				[579]=true,
				[400]=true,
				[404]=true,
				[489]=true,
				[505]=true,
				[479]=true,
				[442]=true,
				[458]=true,
				[494]=true,
				[502]=true,
				[503]=true,
				[561]=true,
				[483]=true,
				[495]=true,
			},
			Transport={
				[552]=true,
				[416]=true,
				[433]=true,
				[427]=true,
				[490]=true,
				[528]=true,
				[428]=true,
				[499]=true,
				[609]=true,
				[498]=true,
				[588]=true,
				[423]=true,
				[414]=true,
				[531]=true,
				[456]=true,
				[459]=true,
				[582]=true,
				[413]=true,
				[440]=true,
				[508]=true,
			},
			Bikes={
				[509]=true,
				[481]=true,
				[510]=true,
			},
			MotorBikes={
				[581]=true,
				[462]=true,
				[521]=true,
				[463]=true,
				[522]=true,
				[461]=true,
				[448]=true,
				[468]=true,
				[586]=true,
				[523]=true,
				[471]=true,
			},
			LKW={
				[403]=true,
				[406]=true,
				[407]=true,
				[408]=true,
				[414]=true,
				[431]=true,
				[437]=true,
				[443]=true,
				[455]=true,
				[456]=true,
				[514]=true,
				[515]=true,
				[524]=true,
				[544]=true,
				[578]=true,
			},
			Trailers={
				[606]=true,
				[607]=true,
				[610]=true,
				[584]=true,
				[611]=true,
				[608]=true,
				[435]=true,
				[450]=true,
				[591]=true,
			},
			Trains={
				[590]=true,
				[538]=true,
				[570]=true,
				[569]=true,
				[537]=true,
				[449]=true,
			},
			Monster={
				[444]=true,
				[556]=true,
				[557]=true,
			},
			Heli={
				[548]=true,
				[425]=true,
				[417]=true,
				[487]=true,
				[488]=true,
				[497]=true,
				[563]=true,
				[447]=true,
				[469]=true,
			},
			SmallPlane={
				[511]=true,
				[512]=true,
				[593]=true,
				[520]=true,
				[476]=true,
				[519]=true,
				[460]=true,
				[513]=true,
			},
			BigPlane={
				[592]=true,
				[577]=true,
				[553]=true,
			},
		},
	},
}


--//Usefull functions
function isClickedState(player)
	if(not player)then
		player=localPlayer
	end
	if(isElement(player))then
		return getElementData(player,"ClickedState")
	end
end
function setClickedState(player,state)
	if(not player)then
		player=localPlayer
	end
	if(isElement(player))then
		setElementData(player,"ClickedState",state)
	end
end
function isLoggedin(player)
	if(not player)then
		player=localPlayer
	end
	if(isElement(player))then
		return tonumber(getElementData(player,"Loggedin"))==1
	end
end
function isPremium(player)
	if(not player)then
		player=localPlayer
	end
	if(isElement(player))then
		if(tonumber(getData(player,"Premium"))==1)then
			return true
		else
			return false
		end
	end
end

--//Vehicle funcs
function getElementSpeed(theElement, unit)
    assert(isElement(theElement), "Bad argument 1 @ getElementSpeed (element expected, got " .. type(theElement) .. ")")
    local elementType = getElementType(theElement)
    assert(elementType == "player" or elementType == "ped" or elementType == "object" or elementType == "vehicle" or elementType == "projectile", "Invalid element type @ getElementSpeed (player/ped/object/vehicle/projectile expected, got " .. elementType .. ")")
    assert((unit == nil or type(unit) == "string" or type(unit) == "number") and (unit == nil or (tonumber(unit) and (tonumber(unit) == 0 or tonumber(unit) == 1 or tonumber(unit) == 2)) or unit == "m/s" or unit == "km/h" or unit == "mph"), "Bad argument 2 @ getElementSpeed (invalid speed unit)")
    unit = unit == nil and 0 or ((not tonumber(unit)) and unit or tonumber(unit))
    local mult = (unit == 0 or unit == "m/s") and 50 or ((unit == 1 or unit == "km/h") and 180 or 111.84681456)
    return (Vector3(getElementVelocity(theElement)) * mult).length
end

function setElementSpeed(element, unit, speed)
    local unit = unit or 0
    local speed = tonumber(speed) or 0
    local acSpeed = getElementSpeed(element, unit)
    if (acSpeed) then
        local diff = speed / acSpeed
        if diff ~= diff then return false end
        local x, y, z = getElementVelocity(element)
        return setElementVelocity(element, x * diff, y * diff, z * diff)
    end

    return false
end
function getVehicleFuelSizeUsage(veh)
	local vehid=getElementModel(veh)
	
	local size,usage=50,0.037
	if(Server.Vehicle.TypeIDS.Bikes[vehid])then
		size,usage=0,0
	elseif(Server.Vehicle.TypeIDS.MotorBikes[vehid])then
		size,usage=25,0.05556
	elseif(Server.Vehicle.TypeIDS.SmallCars[vehid])then
		size,usage=40,0.037
	elseif(Server.Vehicle.TypeIDS.MiddleCars[vehid])then
		size,usage=60,0.02778
	elseif(Server.Vehicle.TypeIDS.BigCars[vehid])then
		size,usage=80,0.0222
	elseif(Server.Vehicle.TypeIDS.Transport[vehid])then
		size,usage=100,0.0185
	elseif(Server.Vehicle.TypeIDS.LKW[vehid])then
		size,usage=350,0.013889
	elseif(Server.Vehicle.TypeIDS.Trailers[vehid])then
		size,usage=0,0
	elseif(Server.Vehicle.TypeIDS.Trains[vehid])then
		size,usage=250,0.02778
	elseif(Server.Vehicle.TypeIDS.Monster[vehid])then
		size,usage=250,0.01195
	elseif(Server.Vehicle.TypeIDS.Heli[vehid])then
		size,usage=175,0.02778
	elseif(Server.Vehicle.TypeIDS.SmallPlane[vehid])then
		size,usage=150,0.037
	elseif(Server.Vehicle.TypeIDS.BigPlane[vehid])then
		size,usage=1500,0.0093
	end
	return size,usage
end

--//Language
LanguageWords={
	[0]={
		["Client"]={
			["General"]={
				["LABEL_TakeItem"]="Item entnehmen",
				["LABEL_NoDeathmatch"]="Jegliche art von Deathmatch ist verboten!",
				["LABEL_Amount"]="Anzahl",
				["LABEL_BuyPremium"]="Premium kaufen",
				["LABEL_BuyItem"]="Item kaufen",
				["LABEL_ItemUse"]="Item benutzen",
				["LABEL_ItemDrop"]="Item rausschmeissen",
				["LABEL_Store"]="Einlagern",
				["LABEL_Outsource"]="Auslagern",
				["LABEL_Hitbell"]="Hitglocke",
				["LABEL_YourDistance"]="Deine Reichweite",
				["LABEL_Hospital"]="Du bist noch für folgende Sekunden im Krankenhaus",
				["LABEL_Hours"]="Stunde(n)",
				["LABEL_Seconds"]="Sekunde(n)",
				["LABEL_Playtime"]="Spielzeit",
				["LABEL_Kills"]="Getötet(e)",
				["LABEL_Deaths"]="Gestorben",
			},
			["RegisterLogin"]={
				["LABEL_Username"]="Benutzername",
				["LABEL_Password"]="Passwort",
				["LABEL_Password2"]="Passwort wdh.",
				["LABEL_Register"]="Registrieren",
				["LABEL_Login"]="Einloggen",
				["LABEL_Email"]="E-Mail",
				["TEXT_InvalidEmail"]="Gebe eine Gültige E-mail an!",
				["TEXT_PasswordNotMatch"]="Beide Passwörter simmen nicht überein!",
			},
			["Helpmenu"]={
				["LABEL_1"]="Willkommen auf "..Server.Name..", einem Selfmade Zombie Apocalypse Server.\n\nDiscord: "..Server.Discord.."",
			},
			["Items"]={
				["LABEL_Pastacan"]="Spaghetti",
				["LABEL_Ravioli"]="Ravioli",
				["LABEL_Pepsi"]="Pepsi",
				["LABEL_Cola"]="Cola",
				["LABEL_Fuelcan"]="Benzinkanister",
				["LABEL_Repairkit"]="Reperaturset",
				["LABEL_FirstAidKit"]="Verbandskasten",
				["LABEL_Itemdepot"]="Itemdepot",
			},
		},
		["Server"]={
			["General"]={
				["TEXT_PlayerNotFound"]="Spieler wurde nicht gefunden!",
				["TEXT_MaxLevel"]="Level überschritten!",
				["TEXT_EnterAtarget"]="Gebe einen Spieler an!",
				["TEXT_Hours"]="Stunde(n)",
				["TEXT_Seconds"]="Sekunde(n)",
				["TEXT_NotEnoughItems_Lootbox"]="So viele Items sind nicht mehr in der Lootbox!",
				["TEXT_DeadMessage_Hunger"]="Du bist aufgrund an Mangel von Hunger gestorben!",
				["TEXT_DeadMessage_Thirst"]="Du bist aufgrund an Mangel von Durst gestorben!",
				["TEXT_NotEnoughCoins"]="Du hast nicht genug Coins!",
				["TEXT_AlrearyEatingDrinking"]="Du Isst/Trinkst bereits!",
				["TEXT_SkillBought"]="Skill erfolgreich gekauft!",
				["TEXT_AFKSet"]="Du bist im AFK modus! Tippe",
				["TEXT_AFKLeft"]="Du hast den AFK modus verlassen!",
			},
			["RegisterLogin"]={
				["TEXT_Registered"]="Du hast dich erfolgreich registriert!",
				["TEXT_Loggedin"]="Du hast dich erfolgreich eingeloggt!",
				["TEXT_PasswordWrong"]="Das Eingegebene Passwort ist falsch!",
				["TEXT_InvalidCharacters"]="Es sind keine Sonderzeichen erlaubt!",
			},
			["Premium"]={
				["TEXT_Premiumstate"]="Dein Premium-Status ist noch aktiv für",
				["TEXT_PremiumExpired"]="Dein Premium-status ist abgelaufen.",
				["TEXT_AlreadyPremium"]="Du hast derzeit einen noch aktiven\nPremium status!",
			},
			["Vehicle"]={
				["TEXT_Tankstart"]="Das Fahrzeug wird nun betankt!",
				["TEXT_Tanksuccess"]="Das Fahrzeug wurde erfolgreich betankt!",
				["TEXT_NotInVehicle"]="Du bist in keinem Fahrzeug!",
				["TEXT_Repairsuccess"]="Das Fahrzeug wurde erfolgreich repariert!",
			},
			["Inventory"]={
				["USE_BoostCoin20"]="Du hast ein 20% Coin Boost Ticket\nbenutzt, dieses hält nun 30 Minuten!",
				["USE_BoostCoin50"]="Du hast ein 50% Coin Boost Ticket\nbenutzt, dieses hält nun 30 Minuten!",
				["USE_BoostEXP20"]="Du hast ein 20% EXP Boost Ticket\nbenutzt, dieses hält nun 30 Minuten!",
				["USE_BoostEXP50"]="Du hast ein 50% EXP Boost Ticket\nbenutzt, dieses hält nun 30 Minuten!",
			}
		},
	},
	[1]={
		["Client"]={
			["General"]={
				["LABEL_TakeItem"]="Take Item",
				["LABEL_NoDeathmatch"]="Any deathmatch is prohibited!",
				["LABEL_Amount"]="Amount",
				["LABEL_BuyPremium"]="Buy premium",
				["LABEL_BuyItem"]="Buy item",
				["LABEL_ItemUse"]="Use item",
				["LABEL_ItemDrop"]="Drop item",
				["LABEL_Store"]="Store",
				["LABEL_Outsource"]="Outsource",
				["LABEL_Hitbell"]="Hitbell",
				["LABEL_YourDistance"]="Your Distance",
				["LABEL_Hospital"]="You are still in the hospital for the following seconds",
				["LABEL_Hours"]="Hour(s)",
				["LABEL_Seconds"]="Second(s)",
				["LABEL_Playtime"]="Play time",
				["LABEL_Kills"]="Kill(s)",
				["LABEL_Deaths"]="Death(s)",
			},
			["RegisterLogin"]={
				["LABEL_Username"]="Username",
				["LABEL_Password"]="Password",
				["LABEL_Password2"]="Password again.",
				["LABEL_Register"]="Register",
				["LABEL_Login"]="Log in",
				["LABEL_Email"]="E-Mail",
				["TEXT_InvalidEmail"]="Enter a Valid email!",
				["TEXT_PasswordNotMatch"]="Both passwords not match!",
			},
			["Helpmenu"]={
				["LABEL_1"]="Welcome to "..Server.Name..", a selfmade zombie apocalypse server.\n\nDiscord: "..Server.Discord.."",
			},
			["Items"]={
				["LABEL_Pastacan"]="Pastacan",
				["LABEL_Ravioli"]="Ravioli",
				["LABEL_Pepsi"]="Pepsi",
				["LABEL_Cola"]="Cola",
				["LABEL_Fuelcan"]="Fuelcan",
				["LABEL_Repairkit"]="Repairkit",
				["LABEL_FirstAidKit"]="First Aid Kit",
				["LABEL_Itemdepot"]="Itemdepot",
			},
		},
		["Server"]={
			["General"]={
				["TEXT_PlayerNotFound"]="Player doesn't exist!",
				["TEXT_MaxLevel"]="Level exceeded!",
				["TEXT_EnterAtarget"]="Enter a Targetplayer!",
				["TEXT_Hours"]="Hour(s)",
				["TEXT_Seconds"]="Second(s)",
				["TEXT_NotEnoughItems_Lootbox"]="So many items are no longer in the lootbox!",
				["TEXT_DeadMessage_Hunger"]="You died of lack of hunger!",
				["TEXT_DeadMessage_Thirst"]="You died of lack of thirst!",
				["TEXT_NotEnoughCoins"]="You haven't enough Coins!",
				["TEXT_AlrearyEatingDrinking"]="You're already eating/drinking!",
				["TEXT_SkillBought"]="Skill successfully bought!",
				["TEXT_AFKSet"]="You're in the AFK mode! Type",
				["TEXT_AFKLeft"]="You have left the AFK mode!",
			},
			["RegisterLogin"]={
				["TEXT_Registered"]="You have registered successfully!",
				["TEXT_Loggedin"]="You have successfully logged in!",
				["TEXT_PasswordWrong"]="The entered password is wrong!",
				["TEXT_InvalidCharacters"]="No special characters are allowed!",
			},
			["Premium"]={
				["TEXT_Premiumstate"]="Your Premium-status is still active for",
				["TEXT_PremiumExpired"]="Your Premium-status has expired.",
				["TEXT_AlreadyPremium"]="You already have a active Premium-status!",
			},
			["Vehicle"]={
				["TEXT_Tankstart"]="The vehicle is now being refueled!",
				["TEXT_Tanksuccess"]="The vehicle was successfully refueled!",
				["TEXT_NotInVehicle"]="You're not in a Vehicle!",
				["TEXT_Repairsuccess"]="Vehicle was successfully repair!",
			},
			["Inventory"]={
				["USE_BoostCoin20"]="You used a 20% Coin Boost\nticket, this one now lasts 30 minutes!",
				["USE_BoostCoin50"]="You used a 50% Coin Boost\nticket, this one now lasts 30 minutes!",
				["USE_BoostEXP20"]="You used a 20% EXP Boost\nticket, this one now lasts 30 minutes!",
				["USE_BoostEXP50"]="You used a 50% EXP Boost\nticket, this one now lasts 30 minutes!",
			}
		},
	},
}

function getLanguageWord(player,Side,AreaName,AreaNameWord)
	if(isElement(player))then
		local language=tonumber(getElementData(player,"Language"))
		if(language and Side and AreaName and AreaNameWord)then
			return LanguageWords[language][Side][AreaName][AreaNameWord]
		end
	end
end