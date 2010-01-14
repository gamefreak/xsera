function LoadScenario(id)
	local scen = deepcopy(gameData.Scenarios[id])
	scen.objects = {}
	scen.destroyQueue = {}
	local datId
	local max = scen.initial.id + scen.initial.count - 1
	local ctr = 0
	
	for datId = scen.initial.id, max do
		local state = gameData.InitialObject[datId]
		local new = NewObject(state.type)

		if state.attributes == 512 then
			if scen.playerShip == nil then
				new.physics.velocity = {x = 0.0, y = 0.0}
				scen.playerShip = new
				scen.playerShipId = ctr
			else
				print("There is already a an intial player ship set.")
			end
		end
		new.physics.position = state.location
		scen.objects[ctr] = new
		ctr = ctr + 1
	end
	return scen
end