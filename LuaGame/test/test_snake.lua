require "test.snake_ai"

TestSnake = TestSnake or BaseClass()

function TestSnake:__init()		
	if TestSnake.Instance ~= nil then
		error("attempt to create singleton TestSnake twice!")
	end
	TestSnake.Instance = self	
	print("p:AI_Player, w:AI_Wark_Around, f:AI_Follow")
	print("Input Mode:p,w,f")
	local t = io.read()
	if t == "p" then 
		self.ai = SnakeAIEat.New(0.2)
		os.execute("title AIPlayer")
		os.execute("color f0")
	elseif t == "w" then 
		self.ai = SnakeAIWalk.New(0.3)
		os.execute("title AIWalker")
		os.execute("color f9")
	else
		self.ai = SnakeAITarget.New(0.1)
		os.execute("title AIFollower")
		os.execute("color f2")
	end
end


