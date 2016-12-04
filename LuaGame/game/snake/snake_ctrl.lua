require("game.snake.snake_data")
require("game.snake.snake_view")

SnakeCtrl = SnakeCtrl or BaseClass()

function SnakeCtrl:__init()

	if SnakeCtrl.Instance ~= nil then
		error("attempt to create singleton SnakeCtrl twice!")
	end
	SnakeCtrl.Instance = self

	self.ai_type = "None"
	self.data = SnakeData.New()
	self.view = SnakeView.New(self, self.data)

end

function SnakeCtrl:SetGrid(x, y, grid_type)
	if self.data:SetGrid(x, y, grid_type) then 
		self.view:UpdateView()
	end
end


function SnakeCtrl:SetFood(x, y)
	self.data:SetFood(x, y)
	self.view:UpdateView()
end

function SnakeCtrl:SetSnakePos(x, y)
	self.data:SetSnakePos(x, y)
	self.view:UpdateView()
end

function SnakeCtrl:GetSnakePos()
	return self.data.snake_pos.x, self.data.snake_pos.y
end

function SnakeCtrl:SetSnakeList(snake_list)
	self.data:SetSnakeList(snake_list)
	self.view:UpdateView()
end

function SnakeCtrl:GetSnakeList()
	return self.data.snake_list
end

function SnakeCtrl:GetNextStep(targetx, targety)
	return self.data:GetNextStep(targetx, targety)
end


function SnakeCtrl:SetAI(str)
	self.ai_type = str
end



