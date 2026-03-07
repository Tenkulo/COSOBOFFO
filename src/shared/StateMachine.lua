--!strict
local StateMachine = {}
StateMachine.__index = StateMachine

type State = {
	Name: string,
	OnEnter: (entity: any) -> (),
	OnUpdate: (entity: any, dt: number) -> (),
	OnExit: (entity: any) -> (),
}

function StateMachine.new(entity: any)
	local self = setmetatable({
		Entity = entity,
		States = {},
		CurrentState = nil,
	}, StateMachine)
	return self
end

function StateMachine:AddState(state: State)
	self.States[state.Name] = state
end

function StateMachine:ChangeState(stateName: string)
	if self.CurrentState and self.CurrentState.OnExit then
		self.CurrentState.OnExit(self.Entity)
	end
	
	local nextState = self.States[stateName]
	if nextState then
		self.CurrentState = nextState
		if nextState.OnEnter then
			nextState.OnEnter(self.Entity)
		end
	end
end

function StateMachine:Update(dt: number)
	if self.CurrentState and self.CurrentState.OnUpdate then
		self.CurrentState.OnUpdate(self.Entity, dt)
	end
end

return StateMachine
