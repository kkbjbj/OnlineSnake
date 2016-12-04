NetBase = NetBase or BaseClass()
function NetBase:__init()
	if NetBase.Instance ~= nil then
		error("Singleton error class:  NetBase")
	end
	NetBase.Instance = self
	self.sock = nil
	self.callback_list = {}
end

function NetBase:ConnectServet()	
	self.sock = assert(SocketHelp.connect(Config.Game.GameServer, Config.Game.GameServerPort))	
	self.sock:settimeout(0)
end

function NetBase:Send(msg)
	if self.sock then		
		self.sock:send(msg .. "\n")
	else
		print("send fail")
	end
end

function NetBase:Recvt(time_out)
	time_out = time_out or 0
	local recvt, sendt, status = SocketHelp.select({self.sock}, nil, time_out)
    while #recvt > 0 do
        local response, receive_status = self.sock:receive()
        if receive_status ~= "closed" then
            if response then
            	self:HandleMsg(response)            	            	        
                recvt, sendt, status = SocketHelp.select({self.sock}, nil, 0)
            end
        else
            break
        end
    end
end

function NetBase:HandleMsg(msg)

	local massage = MsgBase.New()
	massage:InitByJson(msg)
	local msgcode = massage:GetMsgCode()

	if self.callback_list[msgcode] then 
		local class = self.callback_list[msgcode].class
		local func = self.callback_list[msgcode].func_name
		--消息handle
		if class[func] then
			class[func](class, massage:GetMsg())	
		else
			print("msg not Handled :", msgcode, func)	
		end
	else
		print("msg not Handled :", msgcode)
	end
end

function NetBase:__delete()
	self.callback_list = {}
end
