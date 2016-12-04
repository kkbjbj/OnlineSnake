require("game.daily_reward.daily_reward_data")
require("game.daily_reward.daily_reward_view")

DailyRewardCtrl = DailyRewardCtrl or BaseClass()

function DailyRewardCtrl:__init()

	if DailyRewardCtrl.Instance ~= nil then
		error("attempt to create singleton DailyRewardCtrl twice!")
	end
	DailyRewardCtrl.Instance = self

	self.data = DailyRewardData.New()
	self.view = DailyRewardView.New(self, self.data)
end
