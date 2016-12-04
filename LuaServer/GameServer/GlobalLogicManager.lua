require "GlobalSnakelogic"
GlobalLogicManager = GlobalLogicManager or BaseClass()

function GlobalLogicManager:__init()
	if GlobalLogicManager.Instance ~= nil then
		error("attempt to create singleton GlobalLogicManager twice!")
	end
	GlobalLogicManager.Instance = self
	
	self.global_snake_logic = GlobalSnakelogic.New()
end

function GlobalLogicManager:OnSnakeMove(playerID, posx, posy)
	return self.global_snake_logic:OnSnakeMove(playerID, posx, posy)
end

function GlobalLogicManager:OnUserLogout(playerID)
	return self.global_snake_logic:RemoveSnake(playerID)
end
