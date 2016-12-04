
SnakeView = SnakeView or BaseClass(BaseView)
function SnakeView:__init(ctrl, data)
	self.name = "snake_view_g2"
	self.ctrl = ctrl
	self.data = data
end

function SnakeView:UpdateView()
	os.execute("CLS")

	local char = {[0] = " ", [1] = "@", [2] = "#", [3] = ".", [4] = "+", [5] = "*"}
	local str = ""
	for i=0, Config.Snake.MAX_X + 1 do
		local line = ""	
		for j=0, Config.Snake.MAX_Y + 1 do
			local gt = self.data.data_table[i][j]
			local c = char[gt]
			line = line..c
		end
		str = str.."\n"..line
		print(line)
	end
	local fx = self.data.food_pos.x
	local fy = self.data.food_pos.y

	print(string.format("AI:%s____________Score:%d",self.ctrl.ai_type, self.data.score))
	print("FPS: ", Config.Game.CUR_FPS, Config.Game.FPS)
	

end
