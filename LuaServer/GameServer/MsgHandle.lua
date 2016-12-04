MsgHandle = MsgHandle or BaseClass()

function MsgHandle:__init()
	if MsgHandle.Instance ~= nil then
		error("attempt to create singleton MsgHandle twice!")
	end
	MsgHandle.Instance = self
	self.handle_list = {}

	self:Init()
end

function MsgHandle:Init()
	self:RegistHandle(1000, "OnSnakeMove")
end

function MsgHandle:OnMsg(id, msgstr)
	local massage = MsgBase.New()
	massage:InitByJson(msgstr)
	local msgcode = massage:GetMsgCode()
	local func_name = self.handle_list[msgcode]
	if func_name == nil then 
		return
	end

	local player = UserManager.Instance:GetPlayer(id)
	if player then 
		self[func_name](self, player, massage:GetMsg())
	end
end

function MsgHandle:RegistHandle(msgcode, func_name)
	if self.handle_list[msgcode] ~= nil then 
		error("msgcode Registed",msgcode)
	end
	self.handle_list[msgcode] = func_name
end

function MsgHandle:OnSnakeMove(player, msg)
	local snake_logic = player:GetSnakeLogic()
	snake_logic:OnSnakeMove(msg.dir)
end