MsgBase = MsgBase or  BaseClass()
function MsgBase:__init()
	self.msg_code = 0
	self.msg = {}
end

function MsgBase:Init(msg_code, msg)
	self.msg_code = msg_code or 0
	self.msg = msg or {}
end

function MsgBase:InitByJson(json_msg)
	local massage = JsonHelp.decode(json_msg)
	self.msg_code = massage.msgcode
	self.msg = massage.msg
end


function MsgBase:GetMsg()
	return self.msg
end

function MsgBase:GetMsgCode()
	return self.msg_code
end

function MsgBase:GetJson()
	local massage = {}
	massage.msgcode = self.msg_code
	massage.msg = self.msg
	return JsonHelp.encode(massage)
end
