require "protocal.protocal_player"
require "protocal.protocal_daily_reward"
require "protocal.protocal_snake"

Protocal = Protocal or BaseClass()
function Protocal:__init()
	Protocal.Instance = self

	ProtocalPlayer.New()
	ProtocalDailyReward.New()
	ProtocalSnake.New()
end
