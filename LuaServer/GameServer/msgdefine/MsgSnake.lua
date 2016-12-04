MsgSnakeMove = MsgSnakeMove or  BaseClass(MsgBase)
function MsgSnakeMove:__init(dir)
	local msg = {}
	msg.dir = dir
	self:Init(1000, msg)
end

MsgSnakePos = MsgSnakePos or  BaseClass(MsgBase)
function MsgSnakePos:__init(x, y)
	local msg = {}
	msg.posx = x
	msg.posy = y
	self:Init(1001, msg)
end

MsgSnakeFoodPos = MsgSnakeFoodPos or BaseClass(MsgBase)
function MsgSnakeFoodPos:__init(x, y)
	local msg = {}
	msg.posx = x
	msg.posy = y
	self:Init(1002, msg)
end

MsgGSnakePos = MsgGSnakePos or  BaseClass(MsgBase)
function MsgGSnakePos:__init(List)
	local msg = {}
	msg.snakeList = {}
	for k,v in pairs(List) do
		local snake = {}
		snake.id = v.id
		snake.x  = v.x
		snake.y  = v.y
		snake.score = v.score
		table.insert(msg.snakeList, snake)
	end
	self:Init(1003, msg)
end