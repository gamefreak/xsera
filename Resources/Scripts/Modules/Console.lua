consoleHistory = {}
line = 0
CONSOLE_MAX = 5

io.output("XseraOutput.txt")

function console_draw(fontsize)
	camera = { w = 640, h = 480 }
	graphics.set_camera(-camera.w / 2, -camera.h / 2, camera.w / 2, camera.h / 2)
	local i = 1
	while consoleHistory[i] ~= nil do
		if i <= CONSOLE_MAX then
			graphics.draw_text(consoleHistory[i], "CrystalClear", "left", -319, 234 - (i - 1) * fontsize + 1, fontsize)
			i = i + 1
		else
			return
		end
	end
end

function c_return()
	mode_manager.switch("MainMenu")
end

function c_load()
	
end

function sc_load_demo()
	mode_manager.switch("Demo2")
end

commands = {
			{ "return", c_return },
			{ "load demo", sc_load_demo } }

function console_add(text)
	table.insert(consoleHistory, text)
	if text ~= ">" then
		print("[Console] " .. text)
		io.write(text, "\n")
	end
	line = line + 1
end

function console_key (k)
	if k == "unhandled" then
		return
	end
	
	asciikey = string.byte(k, 1)
	if k == "return" then
		local i = 1
		io.write(consoleHistory[line], "\n")
		print("[Console] " .. consoleHistory[line])
		local string, error = loadstring(consoleHistory[line]:gsub("(>)(.)", "%2", 1))
		if error == nil then
			console_add(string)
		else
			console_add(error)
		end
		console_add(">")
	elseif k == "escape" then
		mode_manager.switch("MainMenu")
	elseif asciikey >= 97 and asciikey <= 122 then
		consoleHistory[line] = consoleHistory[line] .. k
	elseif asciikey >= 65 and asciikey <= 90 then
		consoleHistory[line] = consoleHistory[line] .. k
	elseif asciikey == 32 then
		consoleHistory[line] = consoleHistory[line] .. k
	end
end