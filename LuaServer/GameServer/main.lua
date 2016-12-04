--基础工具
require "basetool.baseclass"
require "basetool.json"
local bitopt = require "basetool.bit"
local socket = require("socket")

require "config"
require "msgdefine.MsgDefine"
require "net.Network"

require "MsgHandle"
require "UserManager"
require "GlobalLogicManager"

Config = Config or {}

Config.Snake = {
	MAX_X = 20,
	MAX_Y = 60,
}


function main()
	math.randomseed(os.time())
	
	--基础工具部分
	JsonHelp = json
	BitHelp = bitopt
	SocketHelp = socket

	GlobalLogicManager.New()
	UserManager.New()
	MsgHandle.New()
	ServerNetWork.New(12345, 0.1)
	print("GameServer")	
	ServerNetWork.Instance:Start()
	io.read()
end

 main()