ProtocalBase = ProtocalBase or BaseClass()
function ProtocalBase:__init()
	
end

function ProtocalBase:RegisterProtocal(msgcode, func)
	if NetBase.Instance.callback_list[msgcode] then 
		print("! WARN msgcode Registed :"..msgcode)
	else
		local callback = {}
		callback.class = self
		callback.func_name = func
		NetBase.Instance.callback_list[msgcode] = callback
	end
end

function ProtocalBase:Send(msg)
	print("Send ", msg)
	local str = msg:GetJson()
	print("Send ", str)
	NetBase.Instance:Send(str)

end

function ProtocalBase:__delete()
	-- body
end