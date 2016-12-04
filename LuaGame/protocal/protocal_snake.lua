
ProtocalSnake = ProtocalSnake or BaseClass(ProtocalBase)

function ProtocalSnake:__init()

	ProtocalSnake.Instance = self
	self:RegisterProtocal(1001, "OnGridChange")
	self:RegisterProtocal(1002, "OnFoodChange")
	self:RegisterProtocal(1003, "OnSnakeListBack")
end

function ProtocalSnake:OnGridChange(msg)
	local x, y = msg.posx, msg.posy
	SnakeCtrl.Instance:SetSnakePos(x, y)
end

function ProtocalSnake:OnFoodChange(msg)
	local x, y, score = msg.posx, msg.posy
	SnakeCtrl.Instance:SetFood(x, y)
end

function ProtocalSnake:OnSnakeListBack(msg)
	SnakeCtrl.Instance:SetSnakeList(msg.snakeList)
end

function ProtocalSnake:RequireMove(dir)
	local msg = MsgSnakeMove.New(dir)
	local str = msg:GetJson()
	NetBase.Instance:Send(str)
end
