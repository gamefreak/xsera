import('Math')

Physics = {
	system = { gravity, gravityIsLoc, gravityMass }, -- this is quite static'd up, to use a Java term
	GRAVITY = 6.6742e-11,
	ID = 0,
	
	NewSystem = function(gravity, gravityIsLoc, gravityMass)
		Physics.system.gravity = gravity or vec(0, 0)
        Physics.system.gravityIsLoc = gravityIsLoc or false
        Physics.system.gravityMass = gravityMass
	end,
	
	UpdateSystem = function(dt, objects)
		if physicsObjects ~= {} then
            if objects ~= nil then
                for i, o in pairs(objects) do
			        -- printTable(o)
				    if system.gravityIsLoc then
                        local distX = o.position.x - system.gravity.x
					    local distY = o.position.y - system.gravity.y
					    local relativeGravityPosition = o.position - system.gravity
                        local hypot = hypot(distX, distY)
                        local grav = GRAVITY * (system.gravityMass * o.mass) / (distX^2 + distY^2)
                        Physics.UpdateObject(o.physics, dt, rav/hypot*relativeGravityPosition)
                        -- the above line really needs to be tested
                    else
                        Physics.UpdateObject(o.physics, dt, system.gravity)
                    end
				end
			end
		end
	end,
	
	NewObject = function(mass, vel, pos)
		Physics.ID = Physics.ID + 1
		return { velocity = vel or vec(0, 0), angle = 0, angularVelocity = 0, torque = 0, mass = mass or 1, position = pos or vec(0, 0), force = vec(0, 0), object_id = Physics.ID }
	end,
	
	ApplyImpulse = function(obj, impulse)
		if obj.mass == nil then
			if obj.object_id == nil then
				printTable(obj, "obj")
				error("non-standard object passed", 2)
			end
			print("WARNING: OBJECT (ID: " .. obj.object_id .. ") DOES NOT HAVE MASS!")
		else
			obj.velocity = obj.velocity + (impulse / obj.mass) * (dt * TIME_FACTOR)
		end
	end,
	
	ApplyAngularImpulse = function(obj, impulse)
		obj.angularVelocity = obj.angularVelocity + impulse
	end,
	
	SetVelocity = function(obj, newVelocity)
		obj.velocity = newVelocity
	end,
	
	UpdateObject = function(obj, dt, gravity)
		obj.force = obj.force + gravity * obj.mass
		
		obj.velocity = obj.velocity + (obj.force * dt) / obj.mass
		obj.position = obj.position + (obj.velocity * dt)
		
		obj.angularVelocity = obj.angularVelocity + (obj.torque * dt)
		obj.angle = obj.angle + (obj.angularVelocity * dt)
		
		if obj.angle > (2 * math.pi) then
			obj.angle = obj.angle % (2 * math.pi)
		end
		while obj.angle < 0 do
			obj.angle = obj.angle + 2 * math.pi
		end
		
		obj.torque = 0
		obj.force = vec(0, 0)
	end
}