
ProtocalDailyReward = ProtocalDailyReward or BaseClass(ProtocalBase)

function ProtocalDailyReward:__init()

	ProtocalDailyReward.Instance = self
	self:RegisterProtocal(2, "OnMsgDailyReward")
end

function ProtocalDailyReward:OnMsgDailyReward(massage)
	print(massage)
end