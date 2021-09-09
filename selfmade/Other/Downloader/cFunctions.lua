--//                                              \\
--||  Project: MTA - Zombie Apocalypse            ||
--||  Developers: DORTEY#5702                     ||
--||                                              ||
--||  Since: 2019 (Lake-Gaming.com)               ||
--\\                                              //

--//Camera flight
local viewTable={
	{1480.6,-1721.8,25,1480.6,-1750,20},
	{2133.6,-1096,40,2133.6,-1140,30},
	{1800.3,-1959.7,42,1751.5,1751.5,-1935.6,22},
}
function changeCameraPos(amount)
	setCameraMatrix(viewTable[amount][1],viewTable[amount][2],viewTable[amount][3],viewTable[amount][4],viewTable[amount][5],viewTable[amount][6])
end

--//Downloader
local Timerr
local downloadMusic=nil
local Music=true
local cdn={}

function changeDownloadMusicState()
	if(Music==true)then
		Music=false
		if(downloadMusic)then
			setSoundVolume(downloadMusic,0)
		end
	else
		Music=true
		if(downloadMusic)then
			setSoundVolume(downloadMusic,1)
		end
	end
end

function downloadMusicP()
	downloadMusic=playSound(":"..getResourceName(getThisResource()).."/Files/Sounds/Downloading.mp3",true)
	setSoundVolume(downloadMusic,1)
	
	bindKey("B","down",changeDownloadMusicState)
	
	changeCameraPos(1)
	Timerr=setTimer(function()
		local rdm=math.random(1,#viewTable)
		changeCameraPos(rdm)
	end,5*1000,0)
end

function cdn.new()
    local self=setmetatable({},{__index=cdn})
    self.m_Counter=0
    self.m_Max=0
    self.m_Content={}
    self.m_Ready=false
	
	downloadMusicP()
	
    addEvent("cdn:receiveContent",true)
    addEvent("cdn:receiveFile",true)
    addEvent("cdn:onClientReady",true)
    addEventHandler("cdn:receiveContent",root,function(...)self:receiveContent(...)end)
    addEventHandler("cdn:receiveFile",root,function(...)self:receiveFile(...)end)
    self.m_fRender=function(...)self:renderMain(...)end
    self.m_ScreenX,self.m_ScreenY=guiGetScreenSize()
    self.m_Width,self.m_Heigth=320,40
    triggerServerEvent("cdn:requireContent",localPlayer)
    return self
end

function cdn:receiveContent(list)
    local demanded={}
    for _,v in pairs(list)do
        if fileExists(v[1])then
            local file=fileOpen(v[1],true)
            if(file)then
                if(md5(fileRead(file,fileGetSize(file)))~=v[2])then
                    self.m_Max=self.m_Max+1
                    demanded[self.m_Max]=v[1]
                end
                fileClose(file)
            end
        else
            self.m_Max=self.m_Max+1
            demanded[self.m_Max]=v[1]
        end
    end
    if(self.m_Max>0)then
        self.m_Content=demanded
        addEventHandler("onClientRender",root,self.m_fRender)
        triggerServerEvent("cdn:requireFiles",localPlayer,self.m_Content)
    else
        self:setReady()
    end
end

function cdn:receiveFile(data,path,counter)
    local file=fileCreate(path)
    if(file)then
        fileWrite(file,data)
        fileClose(file)
        self.m_Counter=counter
        if(self.m_Counter==self.m_Max)then
            self:setReady()
        else
            triggerServerEvent("cdn:requestNextFile",localPlayer,localPlayer)
        end
    end
end

function cdn:setReady()
    triggerEvent("cdn:onClientReady",root,resourceRoot)
    removeEventHandler("onClientRender",root,self.m_fRender)
	if(isTimer(Timerr))then
		killTimer(Timerr)
		destroyElement(downloadMusic)
		Timerr=nil
		downloadMusic=nil
		unbindKey("B","down",changeDownloadMusicState)
	end
    self.m_Ready=true
end

function cdn:getReady()
    return self.m_Ready
end

function cdn:renderMain(delta)
	if(self.m_Counter>0)then
		showChat(false)
		fadeCamera(true)
		setElementDimension(localPlayer,0)
		setElementInterior(localPlayer,0)
		
		--dxDrawImage(920*Gsx,340*Gsy,100*Gsx,100*Gsy,":"..getResourceName(getThisResource()).."/Files/Images/Logo.png",0,0,0,tocolor(255,255,255,200),false)
		dxDrawRectangle(GLOBALscreen[1]/2-360/2,GLOBALscreen[2]/2-240/2,360,240,UI.Color.BG,false)
		dxDrawRectangle(GLOBALscreen[1]/2-360/2,GLOBALscreen[2]/2-240/2,360,35,UI.Color.Bar,false)
		dxDrawText("Downloading files...",GLOBALscreen[1]/2-360/2+120,GLOBALscreen[2]/2-240/2+8,100,20,tocolor(255,255,255,255),1.15,"sans","left",_,_,_,false,_,_)
		dxDrawText("Welcome to "..Server.Name..", a Selfmade Zombie Apocalypse Server.\n\nOur Discord: "..Server.Discord.."\n\n\n\nPress 'B' to mute/unmute the Music.",GLOBALscreen[1]/2-360/2+10,GLOBALscreen[2]/2-240/2+50,100,20,tocolor(255,255,255,255),1,"default","left",_,_,_,false,_,_)
		
		dxDrawText(self.m_Counter.."/"..self.m_Max.." files...",GLOBALscreen[1]/2-360/2+10,GLOBALscreen[2]/2-240/2+180,100,20,tocolor(255,255,255,255),1.10*Gsx,"default-bold","left",_,_,_,false,_,_)
		
		dxDrawRectangle(GLOBALscreen[1]/2-360/2+8,GLOBALscreen[2]/2-240/2+198,344,34,tocolor(0,0,0,255),false)
		dxDrawRectangle(GLOBALscreen[1]/2-360/2+10,GLOBALscreen[2]/2-240/2+200,self.m_Counter*340/self.m_Max,30,UI.Color.Bar,false)
	end
end

addEventHandler("onClientResourceStart",resourceRoot,function()
    _G["CDN"]=cdn.new()
end)