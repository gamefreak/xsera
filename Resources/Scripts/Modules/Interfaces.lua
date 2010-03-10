import('BoxDrawing')
import('Camera')
import('GlobalVars')

selection = {
	control = {};
	target = {};
}
setmetatable(selection, weak)
menuShift = -391
topOfMenu = -69
menuStride = -11
shipSelected = false
menuShipyard = { "BUILD", {} }

function MakeShip()
	shipBuilding = { p = shipQuerying.p, n = shipQuerying.n, r = shipQuerying.r, c = shipQuerying.c, t = shipQuerying.t }
	if shipBuilding.c > cash or scen.planet.buildqueue.percent ~= 100 then
		sound.play("NaughtyBeep")
		return
	end
	scen.planet.buildqueue.factor = shipBuilding.t
	scen.planet.buildqueue.time = mode_manager.time()
	scen.planet.buildqueue.current = mode_manager.time() - scen.planet.buildqueue.time
	cash = cash - shipBuilding.c
	buildTimerRunning = true
end

function Shipyard()
	menuLevel = menuShipyard
	local num = 1
	while scen.planet.build[num] ~= nil do
		menuShipyard[num + 1] = {}
		menuShipyard[num + 1][1] = scen.planet.build[num]:gsub("(%w+)/(%w+)", "%2")
		if num ~= 1 then
			menuShipyard[num + 1][2] = false
		else
			menuShipyard[num + 1][2] = true
			shipSelected = true
			shipQuerying.p = scen.planet
			shipQuerying.n = scen.planet.build[num]:gsub("(%w+)/(%w+)", "%2")
			shipQuerying.r = scen.planet.build[num]:gsub("(%w+)/(%w+)", "%1")
			shipQuerying.c = scen.planet.buildCost[num]
			shipQuerying.t = scen.planet.buildTime[num]
		end
		menuShipyard[num + 1][3] = MakeShip
		menuShipyard[num + 1][4] = {}
		menuShipyard[num + 1][4][1] = scen.planet
		menuShipyard[num + 1][4][2] = scen.planet.build[num]:gsub("(%w+)/(%w+)", "%2")
		menuShipyard[num + 1][4][3] = scen.planet.build[num]:gsub("(%w+)/(%w+)", "%1")
		num = num + 1
	end
	shipSelected = true
end

menuSpecial = { "SPECIAL ORDERS",
	{ "Transfer Control", true, DoTransferControl },
	{ "Hold Position", false, nil },
	{ "Go To My Position", false, nil },
	{ "Fire Weapon 1", false, nil },
	{ "Fire Weapon 2", false, nil },
	{ "Fire Special", false, nil }
}

function Special()
	menuLevel = menuSpecial
end

menuMessages = { "MESSAGES",
	{ "Next Page/Clear", true, DoMessageNext },
	{ "Previous Page", false, nil },
	{ "Last Message", false, nil }
}

function Messages()
	menuLevel = menuMessages
end

menuStatus = { "MISSION STATUS",
--	{ "", false },
	
}

function MissionStatus()
	menuLevel = menuStatus
end

menuOptions = { "MAIN MENU",
	{ "<Build>", true, Shipyard },
	{ "<Special Orders>", false, Special },
	{ "<Messages>", false, Messages },
	{ "<Mission Status>", false, MissionStatus }
}
menuLevel = menuOptions

function InterfaceDisplay(dt)
	if menu_display ~= nil then
		if menu_display == "esc_menu" then
			DrawEscapeMenu()
		elseif menu_display == "defeat_menu" then
			DrawDefeatMenu()
		elseif menu_display == "info_menu" then
			DrawInfoMenu()
		elseif menu_display == "victory_menu" then
			DrawVictoryMenu()
		elseif menu_display == "pause_menu" then
			DrawPauseMenu(dt)
		end
	end
end

function DrawEscapeMenu()
	SwitchBox( { top = 85, left = -140, bottom = -60, right = 140, boxColour = ClutColour(10, 8) } )
	graphics.draw_text("Resume, start chapter over, or quit?", MAIN_FONT, "left", { x = -125, y = 65 }, 16)
	if down.esc == true then
		SwitchBox( { xCoord = -125, yCoord = 30, length = 250, text = "Resume", boxColour = ClutLighten(ClutColour(12, 6), 1), textColour = ClutColour(12, 6), execute = nil, letter = "ESC" } )
	elseif down.esc == "act" then
		keyup = normal_keyup
		key = normal_key
		down.esc = false
		menu_display = nil
	else
		SwitchBox( { xCoord = -125, yCoord = 30, length = 250, text = "Resume", boxColour = ClutColour(12, 6), textColour = ClutColour(12, 6), execute = nil, letter = "ESC" } )
	end
	if down.rtrn == true then
		SwitchBox( { xCoord = -125, yCoord = 0, length = 250, text = "Start Chapter Over", boxColour = ClutLighten(ClutColour(9, 6)), textColour = ClutColour(9, 6), execute = nil, letter = "RTRN" } )
	elseif down.rtrn == "act" then
		mode_manager.switch('Demo4')
		down.rtrn = false
	else
		SwitchBox( { xCoord = -125, yCoord = 0, length = 250, text = "Start Chapter Over", boxColour = ClutColour(9, 6), textColour = ClutColour(9, 6), execute = nil, letter = "RTRN" } )
	end
	if down.q == true then
		SwitchBox( { xCoord = -125, yCoord = -30, length = 250, text = "Quit to Main Menu", boxColour = ClutColour(8, 4), textColour = ClutColour(8, 17), execute = nil, letter = "Q" } )
	elseif down.q == "act" then
		menu_display = nil
		mode_manager.switch('Xsera/MainMenu')
	else
		SwitchBox( { xCoord = -125, yCoord = -30, length = 250, text = "Quit to Main Menu", boxColour = ClutColour(8, 5), textColour = ClutColour(8, 5), execute = nil, letter = "Q" } )
	end
end

function DrawDefeatMenu()
	SwitchBox( { top = 85, left = -140, bottom = -60, right = 140, boxColour = ClutColour(16, 6) } )
	graphics.draw_text("You lost your Heavy Cruiser and failed.", MAIN_FONT, "left", { x = -125, y = 26 }, 16)
	graphics.draw_text("Start chapter over, or quit?", MAIN_FONT, "left", { x = -125, y = 10 }, 16)
	if down.rtrn == true then
		SwitchBox( { xCoord = -125, yCoord = -20, length = 250, text = "Start Chapter Over", boxColour = ClutLighten(ClutColour(9, 6), 1), textColour = ClutColour(9, 6), execute = nil, letter = "RTRN" } )
	elseif down.rtrn == "act" then
		menu_display = nil
		mode_manager.switch('Demo4')
	else
		SwitchBox( { xCoord = -125, yCoord = -20, length = 250, text = "Start Chapter Over", boxColour = ClutColour(9, 6), textColour = ClutColour(9, 6), execute = nil, letter = "RTRN" } )
	end
	if down.q == true then
		SwitchBox( { xCoord = -125, yCoord = -50, length = 250, text = "Quit to Main Menu", boxColour = ClutColour(8, 5), textColour = ClutColour(8, 17), execute = nil, letter = "Q" } )
	elseif down.q == "act" then
		menu_display = nil
		mode_manager.switch('Xsera/MainMenu')
	else
		SwitchBox( { xCoord = -125, yCoord = -50, length = 250, text = "Quit to Main Menu", boxColour = ClutColour(8, 4), textColour = ClutColour(8, 1), execute = nil, letter = "Q" } )
	end
end

storedTime = 0.0

function DrawVictoryMenu()
	SwitchBox( { xCoord = -125, yCoord = 100, length = 290, text = " ", boxColour = ClutColour(3, 7), textColour = ClutColour(3, 7), execute = nil, letter = "Results", underbox = -100 } )
	graphics.draw_text("You did it! Congratulations!", MAIN_FONT, "left", { x = -110, y = 90 }, 16)
	SwitchBox( { top = 31, left = -75, bottom = -50, right = 115, boxColour = ClutColour(3, 7), background = ClutColour(3, 14) } )
	local startx = 113
	local starty = 28
	local xcheck = 1
	local ycheck = 1
	local xshift = 0
	local xlength = 0
	while endGameData[ycheck] ~= nil do
		local xcheck = 1
		while endGameData[ycheck][xcheck] ~= nil do
			if xcheck == 1 then
				xCoord = 121
				xlength = 64
			else
				xCoord = 60 * (3 - xcheck) + 1
				xlength = 60
			end
			if endGameData[ycheck][xcheck][1] == true then
				if endGameData[ycheck][xcheck][2] ~= cClear then
					graphics.draw_box(starty - (ycheck - 1) * 15, startx - xCoord - xlength, starty - ycheck * 15, startx - xCoord, 0, endGameData[ycheck][xcheck][2])
					graphics.draw_text(endGameData[ycheck][xcheck][3], MAIN_FONT, "left", { x = startx - xCoord - xlength + 2, y = starty - (ycheck - 1) * 15 - 6 }, 16)
				else
					graphics.draw_text(endGameData[ycheck][xcheck][3], MAIN_FONT, "left", { x = startx - xCoord - xlength + 2, y = starty - (ycheck - 1) * 15 - 6 }, 16)
				end
			else
				storedTime = storedTime + dt
				if storedTime >= 0.07 then
					storedTime = storedTime - 0.07
					if endGameData[ycheck][xcheck][1] == "inprogress" then
						if position == nil then
							position = 1
						end
						if position == 1 then
							graphics.draw_box(starty - (ycheck - 1) * 15, startx - xCoord - xlength / 2 - 5, starty - ycheck * 15, startx - xCoord - xlength / 2 + 5, 0, ClutColour(3, 7))
							position = 2
						elseif position == 2 then
							graphics.draw_box(starty - (ycheck - 1) * 15, startx - xCoord - 10, starty - ycheck * 15, startx - xCoord, 0, ClutColour(3, 7))
							endGameData[ycheck][xcheck][1] = true
							position = nil
						end
						sound.play("ITeletype")
					elseif endGameData[ycheck][xcheck][1] == false then
						endGameData[ycheck][xcheck][1] = "inprogress"
						sound.play("ITeletype")
						graphics.draw_box(starty - (ycheck - 1) * 15, startx - xCoord - xlength, starty - ycheck * 15, startx - xCoord - xlength + 10, 0, ClutColour(3, 7))
					end
				end
				ycheck = 5
				xcheck = 4
			end
			xcheck = xcheck + 1
		end
		ycheck = ycheck + 1
	end
end

function DrawInfoMenu()
	SwitchBox( { top = 250, left = -260, bottom = -250, right = 280, boxColour = ClutColour(1, 8) } )
	if down.esc == true then
		SwitchBox( { xCoord = -255, yCoord = -240, length = 530, text = "Done", boxColour = ClutLighten(ClutColour(1, 8)), textColour = ClutColour(1, 8), execute = nil, letter = "ESC" } )
	elseif down.esc == "act" then
		keyup = normal_keyup
		key = normal_key
		down.esc = false
		menu_display = nil
		return
	else
		SwitchBox( { xCoord = -255, yCoord = -240, length = 530, text = "Done", boxColour = ClutColour(1, 8), textColour = ClutColour(1, 8), execute = nil, letter = "ESC" } )
	end
	local x = 245
	local col_switch = true
	while x - 15 >= -188 do
		if col_switch == false then
			col_switch = true
			graphics.draw_box(x, -257, x - 15, 277, 0, ClutColour(16, 11))
		else
			col_switch = false
			graphics.draw_box(x, -257, x - 15, 277, 0, ClutColour(16, 12))
		end
		graphics.draw_box(x, -257, x - 15, -217, 0, ClutColour(16, 1))
		graphics.draw_box(x, 5, x - 15, 45, 0, ClutColour(16, 1))
		x = x - 15
	end
	local num = 1
	local line_num = 1
	while keyboard[num] ~= nil do
		local subnum = 1
		graphics.draw_box(line_num * -15 + 260, -257, line_num * -15 + 245, 277, 0, ClutColour(1, 8))
		graphics.draw_text(keyboard[num][1], MAIN_FONT, "left", { x = -252, y = line_num * -15 + 253 }, 16)
		line_num = line_num + 1
		local xCoord = 0
		local yShift = 0
		local adjust = 0
		local numBoxes = 1
		while keyboard[num][numBoxes] ~= nil do
			numBoxes = numBoxes + 1
		end
		local rows = math.ceil(numBoxes / 2)
		while keyboard[num][subnum + 1] ~= nil do
			if subnum % rows ~= subnum then
				xCoord = 50
				adjust = (rows - 1) * 15
			else
				adjust = 0
				xCoord = -212
			end
			graphics.draw_text(keyboard[num][subnum + 1].name, MAIN_FONT, "left", { x = xCoord, y = line_num * -15 + 254 + adjust }, 16)
			if keyboard[num][subnum + 1].key_display == nil then
				graphics.draw_text(keyboard[num][subnum + 1].key, MAIN_FONT, "center", { x = xCoord - 24, y = line_num * -15 + 254 + adjust }, 16)
			else
				graphics.draw_text(keyboard[num][subnum + 1].key_display, MAIN_FONT, "center", { x = xCoord - 24, y = line_num * -15 + 254 + adjust }, 16)
			end
			line_num = line_num + 1
			subnum = subnum + 1
		end
		if numBoxes % 2 == 0 then
			line_num = line_num - rows + 1
		else
			line_num = line_num - rows + 2
		end
		num = num + 1
	end
end

local timeElapsed = 0

function DrawPauseMenu(dt)
	if down.o == true then
		menu_display = nil
		return
	end
	timeElapsed = timeElapsed + dt
	if timeElapsed % 0.8 > 0.4 then
		SwitchBox( { top = 20, left = -80, bottom = -20, right = 140, boxColour = ClutColour(5, 11), background = c_half_clear } )
		graphics.draw_text("> CAPS LOCK - PAUSED <", MAIN_FONT, "center", { x = 30, y = 0 }, 23, ClutColour(5, 11))
	end
end

radar = { top = 184, left = -394, bottom = 100, right = -303, width = 91, length = 84 }

function DrawRadar()
	graphics.draw_box(radar.top, radar.left, radar.bottom, radar.right, 0, ClutColour(5, 13)) -- background (dark green)
	if cameraRatio <= 1 / 8 then
		graphics.draw_box(radar.top, radar.left, radar.bottom, radar.right, 1, ClutColour(5, 11)) -- foreground (light green with edge)
	else
		boxSize = (cameraRatio * 8 - 1) / cameraRatio / 16
		graphics.draw_box(radar.top - radar.length * boxSize, radar.left + radar.width * boxSize, radar.bottom + radar.length * boxSize, radar.right - radar.width * boxSize, 0, ClutColour(5, 11))
	end
	
	
	local radarRange = { x = 2^11, y = 2^11 }
	for i, o in pairs(scen.objects) do
		if o ~= scen.playerShip
		and o.base.attributes["appear-on-radar"] == true
		and math.abs(o.physics.position.x - scen.playerShip.physics.position.x) < radarRange.x
		and math.abs(o.physics.position.y - scen.playerShip.physics.position.y) < radarRange.y then
			tab = { r = 0, g = 1, b = 0, a = 1 }
			placement = { x = radar.left + ((o.physics.position.x - scen.playerShip.physics.position.x) / radarRange.x + 1) * radar.width / 2, y = radar.bottom + ((o.physics.position.y - scen.playerShip.physics.position.y) / radarRange.y + 1) * radar.length / 2 }
			graphics.draw_point(placement, 10, tab)
		end
	end
end

menuLevel = menuOptions

function DrawPanels()
	updateWindow()
	local cam = cameraToWindow()
	printTable(cam)
	graphics.set_camera(cam[1], cam[2], cam[3], cam[4])
	
--	printTable(panels)
	
	graphics.draw_image("Panels/SideLeftTrans", panels.left.center, { x = panels.left.width, y = panels.left.height })
	graphics.draw_image("Panels/SideRightTrans", panels.right.center, { x = panels.right.width, y = panels.right.height })
	
--[[------------------
	Right Panel
-----------------]]---
	
--	Battery (red)
	if scen.playerShip.status.battery ~= nil then
		graphics.draw_box(138, panels.right.center.x - 11, 38, panels.right.center.x, 0, ClutColour(8, 8))
		graphics.draw_box(scen.playerShip.status.battery / scen.playerShip.status.batteryMax * 100 + 38, panels.right.center.x - 11, 38, panels.right.center.x, 0, ClutColour(8, 5))
	end
--	Energy (yellow)
	if scen.playerShip.status.energy ~= nil then
		graphics.draw_box(-91, panels.right.center.x - 11, 9, panels.right.center.x, 0, ClutColour(3, 7))
		graphics.draw_box(scen.playerShip.status.battery / scen.playerShip.status.batteryMax * 100 - 91, panels.right.center.x - 11, -91, panels.right.center.x, 0, ClutColour(9, 6))
	end
--	Shield (blue)
	if scen.playerShip.status.health ~= nil then
		graphics.draw_box(-219, panels.right.center.x - 11, -119, panels.right.center.x, 0, ClutColour(14, 8))
--		graphics.draw_box(scen.playerShip.status.battery / scen.playerShip.status.batteryMax * 100 - 119, panels.right.center.x - 11, -119, panels.right.center.x, 0, ClutColour(14, 6))
	end
--	Factory resources (green - mostly)
	count = 1
	if shipSelected == true then
		if cash >= shipQuerying.c then
			local drawGreen = math.floor((cash - shipQuerying.c) / 200)
			local drawBlue = math.ceil((shipQuerying.c) / 200) + drawGreen
		--	print(count, "=>", drawGreen, "-[", ((cash - shipQuerying.c) / 200), "]-")
			while count <= drawGreen do
				graphics.draw_box(152 - 3.15 * count, 394, 150 - 3.15 * count, 397, 0, ClutColour(12, 3))
				count = count + 1
			end
		--	print(count, drawGreen, drawBlue)
			while count <= drawBlue do
				graphics.draw_box(152 - 3.15 * count, 394, 150 - 3.15 * count, 397, 0, ClutColour(14, 5))
				count = count + 1
			end
		--	print(count, drawBlue)
		else
			local drawGreen = math.floor(cash / 200)
			local drawRed = math.ceil(shipQuerying.c / 200)
		--	print(count, "=>", drawGreen, "-[", (cash / 200), "]-")
			while count <= drawGreen do
				graphics.draw_box(152 - 3.15 * count, 394, 150 - 3.15 * count, 397, 0, ClutColour(12, 3))
				count = count + 1
			end
		--	print(count, drawGreen, drawRed)
			while count <= drawRed do
				graphics.draw_box(152 - 3.15 * count, 394, 150 - 3.15 * count, 397, 0, ClutColour(2, 9))
				count = count + 1
			end
		--	print(count, drawRed)
		end
	end
	while count <= 100 do
		if count > resources then
			graphics.draw_box(152 - 3.15 * count, 394, 150 - 3.15 * count, 397, 0, ClutColour(12, 14))
		else
			graphics.draw_box(152 - 3.15 * count, 394, 150 - 3.15 * count, 397, 0, ClutColour(12, 3))
		end
		count = count + 1
	end
--	Factory resource bars (yellow)
	count = 1
	while count <= 7 do
		if count <= resourceBars then
			graphics.draw_box(154.5 - 4.5 * count, 384, 151 - 4.5 * count, 392, 0, ClutColour(3, 3))
		else
			graphics.draw_box(154.5 - 4.5 * count, 384, 151 - 4.5 * count, 392, 0, ClutColour(9, 13))
		end
		count = count + 1
	end
--	Factory build bar (purple)
	planet = scen.planet
	if planet ~= nil then
		graphics.draw_line({ x = 382, y = 181 }, { x = 392, y = 181 }, 0.5, ClutColour(13, 9))
		graphics.draw_line({ x = 382, y = 181 }, { x = 382, y = 177 }, 0.5, ClutColour(13, 9))
		graphics.draw_line({ x = 392, y = 177 }, { x = 392, y = 181 }, 0.5, ClutColour(13, 9))
		graphics.draw_line({ x = 382, y = 159 }, { x = 392, y = 159 }, 0.5, ClutColour(13, 9))
		graphics.draw_line({ x = 382, y = 163 }, { x = 382, y = 159 }, 0.5, ClutColour(13, 9))
		graphics.draw_line({ x = 392, y = 159 }, { x = 392, y = 163 }, 0.5, ClutColour(13, 9))
		graphics.draw_box(179, 384, 161, 390, 0, ClutColour(13, 9))
		graphics.draw_box(18 * (100 - planet.buildqueue.percent) / 100 + 161, 384, 161, 390, 0, ClutColour(13, 5))
	end
	
--[[------------------
	Left Panel
------------------]]--
	
--	Radar box (green)
	DrawRadar()
--	Communications panels (green)
	graphics.draw_box(-63, -393, -158, -297, 0, ClutColour(5, 11))
	graphics.draw_line({ x = -391, y = -74 }, { x = -298, y = -74 }, 1, ClutColour(12, 3))
	graphics.draw_box(-165, -389.5, -185.5, -304, 0, ClutColour(5, 11))
--	Menu drawing
	local shift = 1
	local num = 1
	graphics.draw_text(menuLevel[1], MAIN_FONT, "left", { x = menuShift, y = topOfMenu }, 13)
	while menuLevel[num] ~= nil do
		if menuLevel[num][1] ~= nil then
			if menuLevel[num][2] == true then
				graphics.draw_box(topOfMenu + menuStride * shift + 4, -392, topOfMenu + menuStride * shift - 5, -298, 0, ClutColour(12, 10))
			end
			graphics.draw_text(menuLevel[num][1], MAIN_FONT, "left", { x = menuShift, y = topOfMenu + menuStride * shift }, 13)
			shift = shift + 1
		end
		num = num + 1
	end
	if text_being_drawn == true then
		graphics.draw_text(scen.text[textnum], MAIN_FONT, "center", { x = 0, y = -250 }, 30)
	end

--	Weapon ammo count
--OFFSET = 32 PIXELS <= ?
	if scen.playerShip.weapons ~= nil then
		if scen.playerShip.weapons.pulse ~= nil
		and scen.playerShip.weapons.pulse.ammo ~= -1 then
			graphics.draw_text(string.format('%03d', scen.playerShip.weapons.pulse.ammo), MAIN_FONT, "left", { x = -376, y = 60 }, 13, ClutColour(16, 1))
		end
		
		if scen.playerShip.weapons.beam ~= nil
		and scen.playerShip.weapons.beam.ammo ~= -1 then
			graphics.draw_text(string.format('%03d', scen.playerShip.weapons.beam.ammo), MAIN_FONT, "left", { x = -345, y = 60 }, 13, ClutColour(16, 1))
		end
		
		if scen.playerShip.weapons.special ~= nil
		and scen.playerShip.weapons.special.ammo ~= -1 then
			graphics.draw_text(string.format('%03d', scen.playerShip.weapons.special.ammo), MAIN_FONT, "left", { x = -314, y = 60 }, 13, ClutColour(16, 1))
		end
	end

	if selection.control ~= nil then
		DrawTargetBox(selection.control,true)
	end

	if selection.target ~= nil then
		DrawTargetBox(selection.target,false)
	end

	graphics.draw_box(-165.5, -389.5, -175.5, -358, 0, ClutColour(4, 6))
	graphics.draw_text("RIGHT", MAIN_FONT, "left", { x = -388, y = -170 }, 13, ClutColour(14, 5))
	graphics.draw_text("Select", MAIN_FONT, "left", { x = -354, y = -170 }, 13, ClutColour(14, 5))
	if menuLevel ~= menuOptions then
		graphics.draw_box(-175.5, -389.5, -185.5, -358, 0, ClutColour(4, 6))
		graphics.draw_text("LEFT", MAIN_FONT, "left", { x = -388, y = -180 }, 13, ClutColour(14, 5))
		graphics.draw_text("Go Back", MAIN_FONT, "left", { x = -354, y = -180 }, 13, ClutColour(14, 5))
	end
end

function change_menu(menu, direction)
	local num = 2
	if direction == "i" then
		while menu[num][2] ~= true do
			num = num + 1
		end
		if num ~= 2 then
			menu[num][2] = false
			num = num - 1
			menu[num][2] = true
			if menu == menuShipyard then
				shipQuerying.p = menuShipyard[num][4][1]
				shipQuerying.n = menuShipyard[num][4][2]
				shipQuerying.r = menuShipyard[num][4][3]
				shipQuerying.c = scen.planet.buildCost[num - 1]
				shipQuerying.t = scen.planet.buildTime[num - 1]
			end
		end
	elseif direction == "k" then
		while menu[num][2] ~= true do
			num = num + 1
		end
		if menu[num + 1] ~= nil then
			menu[num][2] = false
			num = num + 1
			menu[num][2] = true
			if menu == menuShipyard then
				shipQuerying.p = menuShipyard[num][4][1]
				shipQuerying.n = menuShipyard[num][4][2]
				shipQuerying.r = menuShipyard[num][4][3]
				shipQuerying.c = scen.planet.buildCost[num - 1]
				shipQuerying.t = scen.planet.buildTime[num - 1]
			end
		end
	elseif direction == "j" then
		if menu ~= menuOptions then
			menuLevel = menuOptions
			shipSelected = false
		end
	elseif direction == "l" then
		while menu[num][2] ~= true do
			num = num + 1
		end
		if menu[num][3] ~= nil then
			menu[num][3]()
		end
	end
end

function GetMouseCoords()
	local x, y = mouse_position()
	return {
		x = scen.playerShip.physics.position.x -shipAdjust + camera.w * x - camera.w / 2;
		y = scen.playerShip.physics.position.y  + camera.h * y - camera.h / 2;
	}
end

function DrawMouse1()
	mousePos = GetMouseCoords()
	if FindDist(mousePos, oldMousePos) > 0 then
		mouseStart = mode_manager.time()
	end
	if mode_manager.time() - mouseStart < 2.0 then
		ship = scen.playerShip.physics.position
		
		if mousePos.x > 260 / cameraRatio + ship.x then
			mousePos.x = 260 / cameraRatio + ship.x
		elseif mousePos.x < -320 / cameraRatio + ship.x - shipAdjust then
			mousePos.x = -320 / cameraRatio + ship.x - shipAdjust
		end
		
		if mousePos.y > 230 / cameraRatio + ship.y then
			mousePos.y = 230 / cameraRatio + ship.y
		elseif mousePos.y < -220 / cameraRatio + ship.y then
			mousePos.y = -220 / cameraRatio + ship.y
		end
		graphics.draw_line({ x = - camera.w / 2 + ship.x, y = mousePos.y }, { x = mousePos.x - 20 / cameraRatio, y = mousePos.y }, 1.0, ClutColour(4, 8))
		graphics.draw_line({ x = camera.w / 2 + ship.x, y = mousePos.y }, { x = mousePos.x + 20 / cameraRatio, y = mousePos.y }, 1.0, ClutColour(4, 8))
		graphics.draw_line({ x = mousePos.x, y = -camera.h / 2 + ship.y }, { x = mousePos.x, y = mousePos.y - 20 / cameraRatio }, 1.0, ClutColour(4, 8))
		graphics.draw_line({ x = mousePos.x, y = camera.h / 2 + ship.y }, { x = mousePos.x, y = mousePos.y + 20 / cameraRatio }, 1.0, ClutColour(4, 8))
	end
end

function DrawMouse2()
	ship = scen.playerShip.physics.position
	mousePos = GetMouseCoords()
	if mode_manager.time() - mouseStart < 2.0 and mousePos.x < -260 / cameraRatio + ship.x then
		graphics.set_camera( -- should I have to do this? [ADAM, HACK]
			-scen.playerShip.physics.position.x + shipAdjust - (camera.w / 2.0),
			-scen.playerShip.physics.position.y - (camera.h / 2.0),
			-scen.playerShip.physics.position.x + shipAdjust + (camera.w / 2.0),
			-scen.playerShip.physics.position.y + (camera.h / 2.0))
	
		local cursor = graphics.sprite_dimensions("Misc/Cursor")
		graphics.draw_sprite("Misc/Cursor", mousePos, cursor, 0)
		
		if mode_manager.time() - mouseStart >= 2.0 then
			mouseMovement = false
		end
	end
end

function DrawArrow()
	local angle = scen.playerShip.physics.angle
	local pos = scen.playerShip.physics.position
	local c1 = {
		x = math.cos(arrowAlpha + angle) * arrowDist + pos.x,
		y = math.sin(arrowAlpha + angle) * arrowDist + pos.y
	}
	local c2 = {
		x = math.cos(angle - arrowAlpha) * arrowDist + pos.x,
		y = math.sin(angle - arrowAlpha) * arrowDist + pos.y
	}
	local c3 = {
		x = math.cos(angle) * (arrowLength + arrowVar) + pos.x,
		y = math.sin(angle) * (arrowLength + arrowVar) + pos.y
	}
	graphics.draw_line(c1, c2, 1.5, ClutColour(5, 1))
	graphics.draw_line(c2, c3, 1.5, ClutColour(5, 1))
	graphics.draw_line(c3, c1, 1.5, ClutColour(5, 1))
end

function DrawGrid()
	do
		local i = 0
		while i * GRID_DIST_BLUE - 10 < camera.w + 10 + GRID_DIST_BLUE do
			local grid_x = math.floor((i * GRID_DIST_BLUE + scen.playerShip.physics.position.x - (camera.w / 2.0)) / GRID_DIST_BLUE) * GRID_DIST_BLUE
			
			if grid_x % GRID_DIST_LIGHT_BLUE == 0 then
				if grid_x % GRID_DIST_GREEN == 0 then
					graphics.draw_line({ x = grid_x, y = scen.playerShip.physics.position.y - (camera.h / 2.0) }, { x = grid_x, y = scen.playerShip.physics.position.y + (camera.h / 2.0) }, 1, ClutColour(5, 1))
				else
					graphics.draw_line({ x = grid_x, y = scen.playerShip.physics.position.y - (camera.h / 2.0) }, { x = grid_x, y = scen.playerShip.physics.position.y + (camera.h / 2.0) }, 1, ClutColour(14, 9))
				end
			else
				if cameraRatio > 1 / 8 then
					graphics.draw_line({ x = grid_x, y = scen.playerShip.physics.position.y - (camera.h / 2.0) }, { x = grid_x, y = scen.playerShip.physics.position.y + (camera.h / 2.0) }, 1, ClutColour(4, 11))
				end
			end
			i = i + 1
		end
		
		i = 0
		while i * GRID_DIST_BLUE - 10 < camera.h + 10 + GRID_DIST_BLUE do
			local grid_y = math.floor((i * GRID_DIST_BLUE + scen.playerShip.physics.position.y - (camera.h / 2.0)) / GRID_DIST_BLUE) * GRID_DIST_BLUE
			if grid_y % GRID_DIST_LIGHT_BLUE == 0 then
				if grid_y % GRID_DIST_GREEN == 0 then
					graphics.draw_line({ x = scen.playerShip.physics.position.x - shipAdjust - (camera.w / 2.0), y = grid_y }, { x = scen.playerShip.physics.position.x - shipAdjust + (camera.w / 2.0), y = grid_y }, 1, ClutColour(5, 1))
				else
					graphics.draw_line({ x = scen.playerShip.physics.position.x - shipAdjust - (camera.w / 2.0), y = grid_y }, { x = scen.playerShip.physics.position.x - shipAdjust + (camera.w / 2.0), y = grid_y }, 1, ClutColour(14, 9))
				end
			else
				if cameraRatio > 1 / 8 then
					graphics.draw_line({ x = scen.playerShip.physics.position.x - shipAdjust - (camera.w / 2.0), y = grid_y }, { x = scen.playerShip.physics.position.x - shipAdjust + (camera.w / 2.0), y = grid_y }, 1, ClutColour(4, 11))
				end
			end
			i = i + 1
		end
	end
end



function DrawTargetBox(object, isControl)
	local off = isControl and 0 or 57

	graphics.draw_box(49 - off, -392, 40 - off, -297, 0, (isControl and ClutColour(9,6) or ClutColour(4, 3)))
	graphics.draw_text((isControl and "CONTROL" or "TARGET"), MAIN_FONT, "left", { x = -389, y = 44 - off }, 12, ClutColour(1, 17))

	graphics.draw_text(object.name, MAIN_FONT, "left", { x = -389, y = 35 - off}, 12)
	
	if object.ai.objectives.dest ~= nil then
		graphics.draw_text(object.ai.objectives.dest.name, MAIN_FONT, "left", { x = -389, y = 3 - off }, 12, ClutColour(1, 11))
	end
	
	if object.status.energy ~= nil then
		graphics.draw_line({ x = -357, y = 28 - off }, { x = -347, y = 28 - off }, 0.5, ClutColour(3, 7))
		graphics.draw_line({ x = -357, y = 27 - off }, { x = -357, y = 28 - off }, 0.5, ClutColour(3, 7))
		graphics.draw_line({ x = -347, y = 27 - off }, { x = -347, y = 28 - off }, 0.5, ClutColour(3, 7))
		graphics.draw_line({ x = -357, y = 9 - off }, { x = -347, y = 9 - off }, 0.5, ClutColour(3, 7))
		graphics.draw_line({ x = -357, y = 10 - off }, { x = -357, y = 9 - off }, 0.5, ClutColour(3, 7))
		graphics.draw_line({ x = -347, y = 10 - off }, { x = -347, y = 9 - off }, 0.5, ClutColour(3, 7))
		graphics.draw_box(27 - off, -356, 10 - off, -348, 0, ClutColour(3, 7))
		graphics.draw_box(17 * object.status.energy / object.status.energyMax + 10  - off, -356, 10 - off, -348, 0, ClutColour(9, 6))
	end

	if object.status.health ~= nil then
		graphics.draw_line({ x = -369, y = 28 - off }, { x = -359, y = 28 - off }, 0.5, ClutColour(4, 8))
		graphics.draw_line({ x = -369, y = 27 - off }, { x = -369, y = 28 - off }, 0.5, ClutColour(4, 8))
		graphics.draw_line({ x = -359, y = 27 - off }, { x = -359, y = 28 - off }, 0.5, ClutColour(4, 8))
		graphics.draw_line({ x = -369, y = 9 - off }, { x = -359, y = 9 - off }, 0.5, ClutColour(4, 8))
		graphics.draw_line({ x = -369, y = 10 - off }, { x = -369, y = 9 - off }, 0.5, ClutColour(4, 8))
		graphics.draw_line({ x = -359, y = 10 - off }, { x = -359, y = 9 - off }, 0.5, ClutColour(4, 8))
		graphics.draw_box(27 - off, -367.5, 10 - off, -360, 0, ClutColour(4, 8))
		graphics.draw_box(17 * object.status.health / object.status.healthMax + 10 - off, -367.5, 10 - off, -360, 0, ClutColour(4, 6))
	end

	if object.gfx.sprite ~= nil then
		graphics.draw_sprite(object.gfx.sprite, { x = -380, y = 19 - off }, { x = 17, y = 17 }, 3.14 / 2.0)
	end

	graphics.draw_line({ x = -387, y = 28 - off }, { x = -372, y = 28 - off }, 0.5, ClutColour(1, 1))
	graphics.draw_line({ x = -387, y = 27 - off }, { x = -387, y = 28 - off }, 0.5, ClutColour(1, 1))
	graphics.draw_line({ x = -372, y = 27 - off }, { x = -372, y = 28 - off }, 0.5, ClutColour(1, 1))
	graphics.draw_line({ x = -387, y = 9 - off }, { x = -372, y = 9 - off }, 0.5, ClutColour(1, 1))
	graphics.draw_line({ x = -372, y = 10 - off }, { x = -372, y = 9 - off }, 0.5, ClutColour(1, 1))
	graphics.draw_line({ x = -387, y = 10 - off }, { x = -387, y = 9 - off }, 0.5, ClutColour(1, 1))
end