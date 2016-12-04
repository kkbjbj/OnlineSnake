require "basetool.log.socket"
require "logging.console"

LogCenter = LogCenter or BaseClass()

function LogCenter:__init()
	if LogCenter.Instance ~= nil then
		error("attempt to create singleton LogCenter twice!")
	end
	LogCenter.Instance = self

	--local log_sock = require "basetool.log.socket"
	--local log_console = require "logging.console"

	self.console_logger = logging.console()
	self.sock_logger = logging.socket(Config.Game.LogServer, Config.Game.LogPort)

end

function LogCenter:Info(msg)
	self.console_logger:info(msg)
end

function LogCenter:Debug(msg)
	self.console_logger:debug(msg)
end

function LogCenter:Error(msg)
	self.console_logger:error(msg)
end

function LogCenter:Report(msg, err_type)
	err_type = err_type or 1
	if err_type == 1 then 
		self.sock_logger:info(msg)
	elseif err_type == 2 then 
		self.sock_logger:debug(msg)
	elseif err_type == 3 then
		self.sock_logger:error(msg)
	else
	end
end