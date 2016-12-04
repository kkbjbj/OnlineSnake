
DailyRewardView = DailyRewardView or BaseClass(BaseView)
function DailyRewardView:__init(ctrl, data)
	self.name = "daily_reward_view"
	self.ctrl = ctrl
	self.data = data
end

