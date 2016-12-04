
SnakeData = SnakeData or BaseClass()
function SnakeData:__init()	
	self:ResetData()
	self.snake_pos = {x = 1, y = 1}
	self.food_pos = {x = 10, y = 10}
	self.snake_list = {}
	self.score = 0
end

function SnakeData:ResetData()
	self.data_table = {}
	for i=0, Config.Snake.MAX_X + 1 do
		self.data_table[i] = {}
		for j=0, Config.Snake.MAX_Y + 1 do
			self.data_table[i][j] = 0
			if i == 0 or i == Config.Snake.MAX_X + 1 or j == 0 or j == Config.Snake.MAX_Y + 1 then
				self.data_table[i][j] = 2
			end
		end
	end
end

function SnakeData:SetGrid(x, y, grid_type)
	if self.data_table[x][y] == grid_type then 
		return false		
	else
		self.data_table[x][y] = grid_type
		return true		
	end
end

function SnakeData:SetSnakePos(x, y)
	local oldpos = {}
	oldpos.x = self.snake_pos.x
	oldpos.y = self.snake_pos.y
	if self.data_table[x] and self.data_table[x][y] then 
		self.data_table[x][y] = 1
		self.snake_pos.x = x
		self.snake_pos.y = y
	end

	if self.data_table[oldpos.x] and self.data_table[oldpos.x][oldpos.y] then 
		self.data_table[oldpos.x][oldpos.y] = 0
	end

end

function SnakeData:SetFood(x, y)
	local oldpos = {}
	oldpos.x = self.food_pos.x
	oldpos.y = self.food_pos.y

	if self.data_table[x] and self.data_table[x][y] then 
		self.data_table[x][y] = 4
		self.food_pos.x = x
		self.food_pos.y = y
	end

	if self.data_table[oldpos.x] and self.data_table[oldpos.x][oldpos.y] then 
		self.data_table[oldpos.x][oldpos.y] = 0
	end
end

function SnakeData:SetSnakeList(snake_list)
	for k,v in pairs(self.snake_list) do
		self.data_table[v.x][v.y] = 0
	end
	self.snake_list = snake_list
	for k,v in pairs(snake_list) do
		if Player.Instance.player_id == v.id then
			self.snake_pos.x = v.x
			self.snake_pos.y = v.y
			self.score = v.score
			self.data_table[v.x][v.y] = 1
		else 
			self.data_table[v.x][v.y] = 5
		end
	end
end

function SnakeData:GetNextStep(targetx, targety)
	local posx = self.snake_pos.x
	local posy =  self.snake_pos.y
	if not targetx then
		targetx =  self.food_pos.x
	end
	if not targety then
		targety =  self.food_pos.y
	end

	local dx = nil
	local dy = nil

	if targetx < posx then
		dx = 1
	end

	if targetx > posx then
		dx = 2
	end

	if targety < posy then
		dy = 3
	end

	if targety > posy then
		dy = 4
	end

	local r = math.random(0,1)
	if dx and dy then
		if r == 0 then 
			return dx
		else
			return dy
		end 
	else
		if dx then
			return dx
		elseif dy then 
			return dy
		else
			return math.random(1, 4), true
		end
	end
end