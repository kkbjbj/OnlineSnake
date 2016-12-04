GlobalSnakelogic = GlobalSnakelogic or BaseClass()

GlobalSnakelogic.MAX_X = Config.SNAKE_MAX_X
GlobalSnakelogic.MAX_Y = Config.SNAKE_MAX_Y

function GlobalSnakelogic:__init()
	self.snake_list = {}
	self.food_pos = {}

	local foodx = math.random(100)%GlobalSnakelogic.MAX_X + 1
	local foody = math.random(100)%GlobalSnakelogic.MAX_Y + 1
	self.food_pos = {x = foodx, y = foody}
end

function GlobalSnakelogic:OnSnakeMove(playerID, posx, posy)
	if not self.snake_list[playerID] then 
		local snake = {}
		snake.id = playerID
		snake.score = 0
		snake.x = 1
		snake.y = 1
		self.snake_list[playerID] = snake
		self:SendFoodPos(playerID)
	end
	local snake = self.snake_list[playerID]
	snake.x = posx
	snake.y = posy

	if posx == self.food_pos.x and posy == self.food_pos.y then
		snake.score = snake.score + 1
		self:NextFood()		
	end

	self:BroadCastAll()
end

function GlobalSnakelogic:BroadCastAll()
	local list = {}
	for k,v in pairs(self.snake_list) do
		local snake = {}
		snake.id = 	k
		snake.x = 	v.x
		snake.y = 	v.y
		snake.score = 	v.score
		table.insert(list, snake)
	end

	local msg = MsgGSnakePos.New(list)
	local jsonMsg = msg:GetJson()
	for k,v in pairs(self.snake_list) do
		ServerNetWork.Instance:Send(k, jsonMsg)
	end	
end

function GlobalSnakelogic:RemoveSnake(playerID)
	if self.snake_list[playerID] ~= nil then 
		self.snake_list[playerID] = nil
	end
end

function GlobalSnakelogic:NextFood()
	local foodx = math.random(100)%GlobalSnakelogic.MAX_X + 1
	local foody = math.random(100)%GlobalSnakelogic.MAX_Y + 1
	self.food_pos.x = foodx
	self.food_pos.y = foody
	
	local msg = MsgSnakeFoodPos.New(self.food_pos.x, self.food_pos.y, self.score)
	local jsonMsg = msg:GetJson()
	for k,v in pairs(self.snake_list) do
		ServerNetWork.Instance:Send(k, jsonMsg)
	end	
end

function GlobalSnakelogic:SendFoodPos(playerID)
	local msg = MsgSnakeFoodPos.New(self.food_pos.x, self.food_pos.y)
	local jsonMsg = msg:GetJson()
	ServerNetWork.Instance:Send(playerID, jsonMsg)
end

