BaseView = BaseView or BaseClass()
function BaseView:__init()
	self.is_open = false
end

function BaseView:OpenView()
	self.is_open = true
end

function BaseView:CloseView()
	self.is_open = false
end

function BaseView:loadUICallback()
	
end

function BaseView:AddUICallback()

end

function BaseView:RemoveUICallback()

end
