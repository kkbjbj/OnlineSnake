--基础工具
require "basetool.baseclass"
require "basetool.json"
BitHelp = require "basetool.bit"
SocketHelp = require("socket")

--配置加载
require "config.config"
require "basetool.help"

--log
require "basetool.logcenter"
--定时器
require "basetool.timer_manager"
--事件管理
require "basetool.event_manager"

--基础View
require "game.base_view"

--网络部分
require "msgdefine.MsgDefine"
require "basetool.netbase"
require "protocal.protocal_base"
require "protocal.protocal"

--逻辑部分
require "player.player"
require "game.daily_reward.daily_reward_ctrl"
require "game.snake.snake_ctrl"

--测试部分
require "test.test_center"


function main()
	math.randomseed(os.time())
	
	--基础工具部分
	JsonHelp = json 
	
	EventManager.New()
	TimerManager.New()
	LogCenter.New()

	--网络部分
	NetBase.New()
	Protocal.New()

	--逻辑部分
	Player.New()

	DailyRewardCtrl.New()
	SnakeCtrl.New()
	
	testGame()
	start()
end

function start()
	
	NetBase.Instance:ConnectServet()
	local update_clock = GetTime()
	local UPDATE_TIME = 1/Config.Game.FPS
	while true do
		Sleep(Config.Game.SleepInterval)		
		local cur_clock = GetTime()
		if cur_clock - update_clock >= UPDATE_TIME then
			 Config.Game.CUR_FPS = 1/(cur_clock - update_clock)			
			 update_clock = GetTime()			 
			 NetBase.Instance:Recvt()
			 TimerManager.Instance:Update()
			 EventManager.Instance:Fire("update")
		end
	end
end

function testGame()	
	TestTimer.New()	
	TestEvent.New()	
	TestSnake.New()		
end

main()

io.read()

