--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

UI={
	Window={},
	Button={},
	Edit={},
	Image={},
	Label={},
	Tabpanel={},
	Tab={},
	Grid={},
	Scroll={},
	Combo={},
	Radio={},
	
	Color={
		Bar=tocolor(130,0,0,255),
		BG=tocolor(35,35,35,230),
		
		TabBG=tocolor(50,50,50,255),
		
		BTNMain1=tocolor(55,55,55,255),
		BTNMain2=tocolor(75,75,75,255),
		BTNMain3=tocolor(40,40,40,255),
		
		BTNGreen1=tocolor(0,90,0,255),
		BTNGreen2=tocolor(0,120,0,255),
		BTNGreen3=tocolor(0,70,0,255),
		
		BTNRed1=tocolor(90,0,0,255),
		BTNRed2=tocolor(120,0,0,255),
		BTNRed3=tocolor(70,0,0,255),
		
		Edit=tocolor(0,0,0,255),
		
		Grid1=tocolor(50,50,50,255),
		Grid2=tocolor(90,90,90,255),
		Grid3=tocolor(10,10,10,255),
		
		Scroll1=tocolor(100,100,100,255),
		Scroll2=tocolor(35,35,35,255),
		Scroll3=tocolor(10,10,10,255),
	},
}
loadstring(exports.dgs:dgsImportFunction())()

GLOBALscreen={guiGetScreenSize()}
Gsx=GLOBALscreen[1]/1920
Gsy=GLOBALscreen[2]/1080

setBlurLevel(0)
setOcclusionsEnabled(false)
engineSetAsynchronousLoading(true,true)
setWorldSpecialPropertyEnabled("snipermoon",true)
setWorldSpecialPropertyEnabled("extraairresistance",false)


function setUIdatas(typ,typ2,typ3)
	if(typ=="set")then
		if(typ2=="cursor")then
			showCursor(true)
			setClickedState(localPlayer,true)
			if(typ3)then
				function closeUI()
					if(isElement(UI.Window[1]))then
						destroyElement(UI.Window[1])
					end
					if(isElement(UI.Window[2]))then
						destroyElement(UI.Window[2])
					end
					setUIdatas("rem","cursor")
					unbindKey("backspace","down",function()
						closeUI()
					end)
				end
				bindKey("backspace","down",closeUI)
			end
		end
	elseif(typ=="rem")then
		if(typ2=="cursor")then
			showChat(true)
			showCursor(false)
			setClickedState(localPlayer,false)
			if(isElement(UI.Window[1]))then
				dgsCloseWindow(UI.Window[1])
			end
		end
	end
end

function isMouseInPosition(x,y,width,height)
	if(not isCursorShowing())then
		return false
	end
    local cx,cy=getCursorPosition()
    local cx,cy=(cx*GLOBALscreen[1]),(cy*GLOBALscreen[2])
    if((cx>=x and cx<=x+width)and(cy>=y and cy<=y+height))then
        return true
    else
        return false
    end
end

function dxDrawEdge(x,y,sz,m,vastagsag,alpha,r,g,b)
	if(not alpha)then
		alpha=180
	end
	if(not r and not g and not b)then
		r,g,b=0,0,0
	end

	dxDrawRectangle(x,y-vastagsag,sz,vastagsag,tocolor(r,g,b,alpha))
	dxDrawRectangle(x-vastagsag,y-vastagsag,vastagsag,m+(vastagsag*2),tocolor(r,g,b,alpha))
	dxDrawRectangle(x+sz,y-vastagsag,vastagsag,m+(vastagsag*2),tocolor(r,g,b,alpha))
	dxDrawRectangle(x,y+m,sz,vastagsag,tocolor(r,g,b,alpha))
end

function getPingColor(ping)
	if(ping<=50)then
		return {0,200,0}
	elseif(ping<=150)then
		return {200,200,0}
	else
		return {200,0,0}
	end
end

local OnlyNumbersTable={"a","b","c","d","e","f","g","h","i","j","k","l","m","o","p","y","r","s","t","u","v","w","x","y","z","A","B","C","D","E","F","G","H","I","J","K","L","M","O","P","Q","R","S","T","U","V","W","X","Y","Z","ä","ü","ö","Ä","Ü","Ö"," ",",","#","'","+","*","~",":",";","=","}","?","\\","{","&","/","§","\"","!","°","@","|","`","´","-","+"}
function isOnlyNumbers(text)
	local counter=0
	for _,v in ipairs(OnlyNumbersTable)do
		if(string.find(text,v))then
			counter=counter+1
			break
		end
	end
	if(counter>=1)then
		triggerEvent("Draw->Infobox->UI",localPlayer,"Error","Error","Only numbers are allowed!")
		return false
	else
		return true
	end
end

function teaEncodeBinary(data,key)
    return teaEncode(base64Encode(data),key)
end
function teaDecodeBinary(data,key)
    return base64Decode(teaDecode(data,key))
end




--local editorState = false
--local font = dxCreateFont("Files/Fonts/Roboto.ttf", 10)
--local small_font = dxCreateFont("Files/Fonts/Roboto.ttf", 8)
--local moveingWidget = false
--local currentlyMoveing = false
--local offsetX = 0
--local offsetY = 0
--local hoveredActionButton = ""
--
--local mySavedConfig = {}
--local myDisabledWidgets = {}
--
--local boundingBoxes = {
--	{
--		["name"]="Hud",
--		["showing"]=true,
--		["width"]=290*Gsx,
--		["height"]=245*Gsy,
--		["x"]=1620*Gsx,
--		["y"]=10*Gsy,
--	},
--	{
--		["name"]="Infobox",
--		["showing"]=true,
--		["width"]=330*Gsx,
--		["height"]=130*Gsy,
--		["x"]=790*Gsx,
--		["y"]=30*Gsy,
--	},
--	{
--		["name"]="Savezone",
--		["showing"]=true,
--		["width"]=290*Gsx,
--		["height"]=75*Gsy,
--		["x"]=1620*Gsx,
--		["y"]=340*Gsy,
--	},
--	{
--		["name"]="Speedo",
--		["showing"]=true,
--		["width"]=300*Gsx,
--		["height"]=300*Gsy,
--		["x"]=1600*Gsx,
--		["y"]=780*Gsy,
--	},
--	{
--		["name"]="Speedo (Fuel)",
--		["showing"]=true,
--		["width"]=120*Gsx,
--		["height"]=120*Gsy,
--		["x"]=1450*Gsx,
--		["y"]=950*Gsy,
--	},
--	{
--		["name"]="Hud (Weapon)",
--		["showing"]=true,
--		["width"]=100*Gsx,
--		["height"]=130*Gsy,
--		["x"]=1500*Gsx,
--		["y"]=20*Gsy,
--	},
--	{
--		["name"]="Radar",
--		["showing"]=true,
--		["width"]=380*Gsx,
--		["height"]=250*Gsy,
--		["x"]=20*Gsx,
--		["y"]=810*Gsy,
--	},
--}
--
--addEventHandler("onClientResourceStart",resourceRoot,
--    function()
--		-- fileDelete("widgets.json")
--		--exports["exBlur"]:removeBlur("widget")
--        checkJSON_File()
--    end 
--)
--
--addEventHandler("onClientResourceStop", resourceRoot,
--    function()
--		-- fileDelete("widgets.json")
--		-- local file = fileCreate("widgets.json")
--		-- fileWrite(file, toJSON(mySavedConfig))
--		-- fileClose(file)
--    end 
--)
--
--
--function convertToBool(string)
--	if tostring(string) == "true" then
--		return true
--	else
--		return false
--	end
--end
--
--function widgetEditorDraw()
--	if not editorState then return end
--	dxDrawRectangle(0, 0, GLOBALscreen[1], GLOBALscreen[2], tocolor(0, 0, 0, 150))
--	for k, v in ipairs(mySavedConfig) do
--		if convertToBool(v["showing"]) then
--			dxDrawRectangle(v["x"], v["y"], v["width"], v["height"], tocolor(0, 0, 0, 200), true)
--			dxDrawText(v["name"], v["x"], v["y"], v["width"] + v["x"], v["height"] + v["y"], white, 1, font, "center", "center", false, false, true, true)
--		end
--	end
--	
--	if moveingWidget then
--		if isCursorShowing() then
--			local cX, cY = getCursorPosition()
--			cX, cY = cX * GLOBALscreen[1], cY * GLOBALscreen[2]
--			mySavedConfig[currentlyMoveing]["x"] = cX + offsetX
--			mySavedConfig[currentlyMoveing]["y"] = cY + offsetY
--		end
--	end
--	if isCursorShowing() then
--		local cX, cY = getCursorPosition()
--		cX, cY = cX * GLOBALscreen[1], cY * GLOBALscreen[2]
--		if not isInBox(GLOBALscreen[1] / 2 - 64 / 2 - 64, 80, 64, 64, cX, cY) or not isInBox(GLOBALscreen[1] / 2 - 64 / 2 + 64, 80, 64, 64, cX, cY) then
--			hoveredActionButton = ""
--		end
--		if moveingWidget and isInBox(GLOBALscreen[1] / 2 - 64 / 2 - 64, 80, 64, 64, cX, cY) and mySavedConfig[currentlyMoveing]["showing"] then
--			dxDrawImage(GLOBALscreen[1] / 2 - 64 / 2 - 64, 80, 64, 64, "Files/IMages/Reset.png", 0, 0, 0, tocolor(205, 55, 55, 255), true)
--			hoveredActionButton = "reset"
--		else
--			dxDrawImage(GLOBALscreen[1] / 2 - 64 / 2 - 64, 80, 64, 64, "Files/IMages/Reset.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
--		end
--		if moveingWidget and isInBox(GLOBALscreen[1] / 2 - 64 / 2 + 64, 80, 64, 64, cX, cY) and mySavedConfig[currentlyMoveing]["showing"] then
--			dxDrawImage(GLOBALscreen[1] / 2 - 64 / 2 + 64, 80, 64, 64, "Files/IMages/Delete.png", 0, 0, 0, tocolor(205, 55, 55, 255), true)
--			hoveredActionButton = "delete"
--		else
--			dxDrawImage(GLOBALscreen[1] / 2 - 64 / 2 + 64, 80, 64, 64, "Files/IMages/Delete.png", 0, 0, 0, tocolor(255, 255, 255, 255), true)
--		end
--	end
--	-- Disabled Widgets
--	if #myDisabledWidgets > 0 then
--		dxDrawRectangle(20, 20, 200, #myDisabledWidgets * 30, tocolor(0, 0, 0, 120), true)
--		for k, v in ipairs(myDisabledWidgets) do
--			dxDrawRectangle(20, 20 + k * 30 - 30, 200, 29, tocolor(0, 0, 0, 120), true)		
--			dxDrawText(mySavedConfig[v]["name"], 20, 20 + k * 30 - 30, 200 + 20, 29 + 20 + k * 30 - 30, white, 1, font, "center", "center", false, false, true, true)
--		end
--	end
--end
--addEventHandler("onClientRender", root, widgetEditorDraw)
--
--addEventHandler("onClientClick", getRootElement(),
--    function(button, state, x, y, wx, wy, wz, element)
--		if not editorState then return end
--        if button == "left" and state == "down" then
--                for k, v in pairs(mySavedConfig) do
--                    if isInBox(mySavedConfig[k]["x"], mySavedConfig[k]["y"], mySavedConfig[k]["width"], mySavedConfig[k]["height"], x, y) then
--                        currentlyMoveing = k
--                        moveingWidget = true
--                        offsetX = mySavedConfig[k]["x"] - x
--                        offsetY = mySavedConfig[k]["y"] - y
--                    end
--                end
--        elseif button == "left" and state == "up" then        
--			if hoveredActionButton ~= "" then
--				if hoveredActionButton == "reset" then
--					mySavedConfig[currentlyMoveing]["x"] = boundingBoxes[currentlyMoveing]["x"]
--					mySavedConfig[currentlyMoveing]["y"] = boundingBoxes[currentlyMoveing]["y"]
--				end
--				if hoveredActionButton == "delete" then
--					mySavedConfig[currentlyMoveing]["showing"] = false
--					table.insert(myDisabledWidgets, currentlyMoveing)
--				end
--				-- outputChatBox(currentlyMoveing)
--			end
--			if moveingWidget then
--                moveingWidget = false
--                currentlyMoveing = false
--            end
--        end
--		if button == "left" and state == "down" then
--			for k, v in ipairs(myDisabledWidgets) do
--				if isInBox(20, 20 + k * 30 - 30, 200, 29, x, y) then
--					mySavedConfig[v]["showing"] = true
--					mySavedConfig[v]["x"] = boundingBoxes[v]["x"]
--					mySavedConfig[v]["y"] = boundingBoxes[v]["y"]
--					table.remove(myDisabledWidgets, k)
--					return
--				end				
--			end
--		end
--    end 
--)
--
--addEventHandler("onClientClick", getRootElement(),
--	function(button, state, x, y, wx, wy, wz, element)
--		if not editorState then return end
--		if button == "right" and state == "down" then
--			for k, v in pairs(mySavedConfig) do
--				if isInBox(mySavedConfig[k]["x"], mySavedConfig[k]["y"], mySavedConfig[k]["width"], mySavedConfig[k]["height"], wx, wy) then
--					currentlyMoveing = k
--					moveingWidgett = true
--					offsetX = mySavedConfig[k]["width"] - wx
--					offsetY = mySavedConfig[k]["height"] - wy
--				end
--			end
--		elseif button == "right" and state == "up" then
--			if hoveredActionButton ~= "" then
--				if hoveredActionButton == "reset" then
--					mySavedConfig[currentlyMoveing]["width"] = boundingBoxes[currentlyMoveing]["width"]
--					mySavedConfig[currentlyMoveing]["height"] = boundingBoxes[currentlyMoveing]["height"]
--				end
--				if hoveredActionButton == "delete" then
--					mySavedConfig[currentlyMoveing]["showing"] = false
--					table.insert(myDisabledWidgets, currentlyMoveing)
--				end
--				-- outputChatBox(currentlyMoveing)
--			end
--			if moveingWidget then
--				moveingWidget = false
--				currentlyMoveing = false
--			end
--		end
--
--	end
--)
--
--function toggleEditor()
--   if(isLoggedin())then
--		editorState = not editorState
--		if editorState then
--			showCursor(true)
--			showChat(false)
--			checkJSON_File()
--		else
--			showCursor(false)
--			showChat(true)
--			currentlyMoveing = false
--			moveingWidget = false
--			fileDelete("widgets.json")
--			local file = fileCreate("widgets.json")
--			fileWrite(file, toJSON(mySavedConfig))
--			fileClose(file)
--		end
--	end
--end
--bindKey("F5", "down", toggleEditor)
--
--function checkJSON_File()
--	myDisabledWidgets = {}
--	mySavedConfig = {}
--	if not fileExists("widgets.json") then     
--		local file = fileCreate("widgets.json")
--		fileWrite(file, toJSON(boundingBoxes))
--		fileClose(file)
--		mySavedConfig = boundingBoxes
--	else
--		local file = fileOpen("widgets.json")
--		local config = fromJSON(fileRead(file, 9999))
--
--		for k, v in ipairs(config) do
--			mySavedConfig[tonumber(k)] = {
--				["name"] = tostring(v["name"]),
--				["showing"] = convertToBool(v["showing"]),
--				["width"] = tonumber(v["width"]),
--				["height"] = tonumber(v["height"]),
--				["x"] = tonumber(v["x"]),
--				["y"] = tonumber(v["y"]),
--			}
--			if not convertToBool(v["showing"]) then
--				myDisabledWidgets[#myDisabledWidgets + 1] = k
--			end
--		end
--
--		fileClose(file)
--	end
--end
--
--function getNode(id, node)
--	if mySavedConfig[id] and mySavedConfig[id][node] then
--		return mySavedConfig[id][node]
--	end
--end
--
--function isInBox(dX, dY, dSZ, dM, eX, eY)
--    if(eX >= dX and eX <= dX+dSZ and eY >= dY and eY <= dY+dM) then
--        return true
--    else
--        return false
--    end
--end