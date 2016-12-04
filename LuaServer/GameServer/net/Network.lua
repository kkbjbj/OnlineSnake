ServerNetWork = ServerNetWork or BaseClass()

function ServerNetWork:__init(port, timeout)
	if ServerNetWork.Instance ~= nil then
		error("attempt to create singleton ServerNetWork twice!")
	end
	ServerNetWork.Instance = self

	self.host = "127.0.0.1"
	self.port = tostring(port)
	self.server_sock = assert(SocketHelp.bind(self.host, self.port, 1024))
	self.server_sock:settimeout(0)
	self.client_tab = {}
	self.conn_count = 0
	self.link_number = 0
end

function ServerNetWork:Start()
	while true do
	    local conn = self.server_sock:accept()
	    if conn then
	    	self.link_number = self.link_number + 1
	        self.conn_count = self.conn_count + 1
	        self.client_tab[self.link_number] = conn
	        self:OnUserConnect(conn)

	        UserManager.Instance:OnUserLogin(self.conn_count)
	        print("A client successfully connect!") 
	    end
	  
	    for i, client in pairs(self.client_tab) do
	        local recvt, sendt, status = SocketHelp.select({client}, nil, Config.NetInterval)
	        if #recvt > 0 then
	            local receive, receive_status = client:receive()
	            if receive_status ~= "closed" then
	                if receive then
	                	MsgHandle.Instance:OnMsg(i, receive)
	                    --client:send(receive)
	                    --print("Receive Client " .. i .. " : ", receive)
	                end
	            else
	                self.client_tab[i] = nil
	                UserManager.Instance:OnUserLogout(i)
	                client:close() 
	                print("Client " .. i .. " disconnect!") 
	            end
	        end
	         
	    end
	end

end

function ServerNetWork:OnUserConnect(connect)
	local msg_connect = {}
	msg_connect.msgcode = 0
	msg_connect.msg = {}
	msg_connect.msg.playerID = self.link_number
	local jsonMsg = JsonHelp.encode(msg_connect)
	connect:send(jsonMsg.. "\n")
end

function ServerNetWork:Send(id, msg)
	local client = self.client_tab[id]
	if client then
		client:send(msg .. "\n")
	else
		print("send fail id",id)
	end
end

function ServerNetWork:BroadCast(msg)
	for i, client in pairs(self.client_tab) do
		client:send(msg .. "\n")
	end
end
