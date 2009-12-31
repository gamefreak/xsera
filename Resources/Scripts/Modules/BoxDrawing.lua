import('PrintRecursive')

function DrawInterfaceBox(box, col_mod_all, col_mod_click)
	if box.underbox ~= nil then
		graphics.draw_box(box.yCoord + 18, box.xCoord, box.underbox, box.xCoord + box.length, 0, ClutColour(1, 17))
	else
		graphics.draw_box(box.yCoord + 18, box.xCoord, box.yCoord, box.xCoord + box.length, 0, ClutColour(1, 17))
	end
	if box.special ~= "disabled" then
		if box.text == "nodraw" then
			txtlength = (box.length - 22) / 2
		elseif ((box.length - 20) / 3.5) < graphics.text_length(box.letter, "CrystalClear", 14) then
			txtlength = (graphics.text_length(box.letter, "CrystalClear", 14) + 20) / 2
		else
			txtlength = (box.length - 20) / 7
		end
	else
		txtlength = (box.length - 20) / 7
	end
	-- inner box and details
	if (box.text ~= " ") and (box.text ~= "nodraw") then
		graphics.draw_box(box.yCoord + 14, box.xCoord + 11, box.yCoord + 4, box.xCoord + 10 + txtlength * 2, 0, ClutLighten(box.boxColour, col_mod_all + 1))
		graphics.draw_box(box.yCoord + 14, box.xCoord + 11 + txtlength * 2, box.yCoord + 4, box.xCoord + box.length - 11, 0, ClutLighten(box.boxColour, col_mod_click - 1))
		graphics.draw_text(box.text, "CrystalClear", "center", { x = box.xCoord + 11 + txtlength * 9 / 2, y = box.yCoord + 9 }, 14 , ClutLighten(box.boxColour, col_mod_all + 1)) 
	else
		graphics.draw_box(box.yCoord + 14, box.xCoord + 11, box.yCoord + 4, box.xCoord + 10 + txtlength * 2, 0, ClutLighten(box.boxColour, col_mod_all - 1))
		graphics.draw_box(box.yCoord + 14, box.xCoord + 11 + txtlength * 2, box.yCoord + 4, box.xCoord + box.length - 11, 0, ClutLighten(box.boxColour, col_mod_all + 1))
	end
	if box.special ~= "disabled" then
		graphics.draw_text(box.letter, "CrystalClear", "center", { x = box.xCoord + 11 + txtlength, y = box.yCoord + 9 }, 14) 
	end
	if box.radio == "off" then
		graphics.draw_box(box.yCoord + 13, box.xCoord - 2, box.yCoord + 4, box.xCoord + 5, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 15, box.xCoord - 5, box.yCoord + 3, box.xCoord - 3, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 15, box.xCoord - 15, box.yCoord + 3, box.xCoord - 13, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 15, box.xCoord - 15, box.yCoord + 13, box.xCoord - 3, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 5, box.xCoord - 15, box.yCoord + 3, box.xCoord - 3, 0, ClutLighten(box.boxColour, col_mod_all))
	elseif box.radio == "on" then
		graphics.draw_box(box.yCoord + 13, box.xCoord - 2, box.yCoord + 4, box.xCoord + 5, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 15, box.xCoord - 5, box.yCoord + 3, box.xCoord - 3, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 15, box.xCoord - 15, box.yCoord + 3, box.xCoord - 13, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 15, box.xCoord - 15, box.yCoord + 13, box.xCoord - 3, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 5, box.xCoord - 15, box.yCoord + 3, box.xCoord - 3, 0, ClutLighten(box.boxColour, col_mod_all))
		graphics.draw_box(box.yCoord + 11, box.xCoord - 11, box.yCoord + 7, box.xCoord - 7, 0, ClutLighten(box.boxColour, col_mod_all))
	end
	-- frame boxes
	graphics.draw_box(box.yCoord + 3, box.xCoord, box.yCoord + 2, box.xCoord + 10, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 3, box.xCoord + box.length - 10, box.yCoord + 2, box.xCoord + box.length, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 2, box.xCoord, box.yCoord, box.xCoord + box.length, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 16, box.xCoord, box.yCoord + 14, box.xCoord + 10, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 16, box.xCoord + box.length - 10, box.yCoord + 14, box.xCoord + box.length, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 18, box.xCoord, box.yCoord + 16, box.xCoord + box.length, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 13, box.xCoord, box.yCoord + 4, box.xCoord + 10, 0, ClutLighten(box.boxColour, col_mod_all))
	graphics.draw_box(box.yCoord + 13, box.xCoord + box.length - 10, box.yCoord + 4, box.xCoord + box.length, 0, ClutLighten(box.boxColour, col_mod_all))
	-- under box, if it exists
	if box.underbox ~= nil then
		-- left side
		graphics.draw_box(box.yCoord + 1, box.xCoord, box.yCoord - 1, box.xCoord + 10, 0, box.boxColour)
		graphics.draw_box(box.yCoord - 2, box.xCoord, (box.yCoord + box.underbox + 4) / 2, box.xCoord + 10, 0, box.boxColour)
		graphics.draw_box((box.yCoord + box.underbox + 2) / 2, box.xCoord, box.underbox + 6, box.xCoord + 10, 0, ClutDarken(box.boxColour))
		graphics.draw_box(box.underbox + 5, box.xCoord, box.underbox, box.xCoord + 10, 0, box.boxColour)
		-- right side
		graphics.draw_box(box.yCoord + 1, box.xCoord + box.length - 10, box.yCoord - 1, box.xCoord + box.length, 0, box.boxColour)
		graphics.draw_box(box.yCoord - 2, box.xCoord + box.length - 10, (box.yCoord + box.underbox + 4) / 2, box.xCoord + box.length, 0, box.boxColour)
		graphics.draw_box((box.yCoord + box.underbox + 2) / 2, box.xCoord + box.length - 10, box.underbox + 6, box.xCoord + box.length, 0, ClutDarken(box.boxColour))
		graphics.draw_box(box.underbox + 5, box.xCoord + box.length - 10, box.underbox, box.xCoord + box.length, 0, box.boxColour)
		-- bottom
		graphics.draw_box(box.underbox + 3, box.xCoord, box.underbox, box.xCoord + box.length, 0, box.boxColour)
		if box.uboxText ~= nil then
			graphics.draw_text(box.uboxText, "CrystalClear", "left", { x = box.xCoord + 12, y = box.yCoord - 6 }, 14)
		end
	end
end

function DrawBoxWithSidecar(box)
	DrawInterfaceBox(box, 0, 0)
	-- sidecar: a box of a particular size that surrounds a particular object
	-- box itself
	graphics.draw_line({ x = box.sidecar.x, y = box.sidecar.y + box.sidecar.size.y }, { x = box.sidecar.x + box.sidecar.size.x, y = box.sidecar.y + box.sidecar.size.y }, 1, box.boxColour)
	graphics.draw_line(box.sidecar, { x = box.sidecar.x + box.sidecar.size.x, y = box.sidecar.y }, 1, box.boxColour)
	graphics.draw_line(box.sidecar, { x = box.sidecar.x, y = box.sidecar.y + box.sidecar.size.y }, 1, box.boxColour)
	graphics.draw_line({ x = box.sidecar.x + box.sidecar.size.x, y = box.sidecar.y }, { x = box.sidecar.x + box.sidecar.size.x, y = box.sidecar.y + box.sidecar.size.y }, 1, box.boxColour)
	-- connecting lines - differ if box is on the left or the right
	if box.sidecar.x > box.xCoord then
		graphics.draw_line({ x = box.sidecar.x, y = box.sidecar.y + box.sidecar.size.y }, { x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.sidecar.y + box.sidecar.size.y }, 1, box.boxColour)
		graphics.draw_line({ x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.sidecar.y + box.sidecar.size.y }, { x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.yCoord + 17 }, 1, box.boxColour)
		graphics.draw_line({ x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.yCoord + 17 }, { x = box.xCoord + box.length, y = box.yCoord + 17 }, 1, box.boxColour)
		graphics.draw_line(box.sidecar, { x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.sidecar.y }, 1, box.boxColour)
		graphics.draw_line({ x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.underbox + 1 }, { x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.sidecar.y }, 1, box.boxColour)
		graphics.draw_line({ x = box.xCoord + box.length, y = box.underbox + 1 }, { x = (box.sidecar.x + box.xCoord + box.length) / 2, y = box.underbox + 1 }, 1, box.boxColour)
	else
		graphics.draw_line({ x = box.xCoord, y = box.yCoord + 17 }, { x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.yCoord + 17 }, 1, box.boxColour)
		graphics.draw_line({ x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.yCoord + 17 }, { x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.sidecar.y + box.sidecar.size.y }, 1, box.boxColour)
		graphics.draw_line({ x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.sidecar.y + box.sidecar.size.y }, { x = box.sidecar.x + box.sidecar.size.x, y = box.sidecar.y + box.sidecar.size.y }, 1, box.boxColour)
		graphics.draw_line({ x = box.sidecar.x + box.sidecar.size.x, y = box.sidecar.y }, { x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.sidecar.y }, 1, box.boxColour)
		graphics.draw_line({ x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.sidecar.y }, { x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.underbox + 1 }, 1, box.boxColour)
		graphics.draw_line({ x = (box.xCoord + box.sidecar.x + box.sidecar.size.x) / 2, y = box.underbox + 1 }, { x = box.xCoord, y = box.underbox + 1 }, 1, box.boxColour)
	end
end

function DrawSmallBox(box)
	local backgroundCol = ClutColour(1, 17)
	if box.background ~= nil then
		backgroundCol = box.background
	end
	graphics.draw_box(box.top, box.left, box.bottom, box.right, 0, backgroundCol)
	graphics.draw_box(box.top, box.left, box.top - 3, box.right, 0, box.boxColour)
	graphics.draw_box(box.top, box.left, box.top - 4, box.left + 3, 0, box.boxColour)
	graphics.draw_box(box.top, box.right - 3, box.top - 4, box.right, 0, box.boxColour)
	graphics.draw_box(box.top - 5, box.left, (box.top + box.bottom) / 2, box.left + 3, 0, ClutLighten(box.boxColour))
	graphics.draw_box((box.top + box.bottom) / 2 - 1, box.left, box.bottom + 5, box.left + 3, 0, ClutDarken(box.boxColour))
	graphics.draw_box(box.bottom + 3, box.left, box.bottom, box.right, 0, box.boxColour)
	graphics.draw_box(box.bottom + 4, box.left, box.bottom, box.left + 3, 0, box.boxColour)
	graphics.draw_box(box.bottom + 4, box.right - 3, box.bottom, box.right, 0, box.boxColour)
	graphics.draw_box(box.top - 5, box.right - 3, (box.top + box.bottom) / 2, box.right, 0, ClutLighten(box.boxColour))
	graphics.draw_box((box.top + box.bottom) / 2 - 1, box.right - 3, box.bottom + 5, box.right, 0, ClutDarken(box.boxColour))
	if box.title ~= nil then
		graphics.draw_box(box.top - 5, box.left + 4, box.top - 25, box.right - 4, 0, ClutLighten(box.boxColour, 3))
		graphics.draw_text(box.title, "CrystalClear", "left", { x = box.left + 10, y = box.top - 15 }, 18, ClutColour(1, 17))
	end
	if box.subtitle ~= nil then
		graphics.draw_text(box.subtitle, "CrystalClear", "left", { x = box.left + 10, y = box.top - 35 }, 18, ClutColour(1, 17))
	end
--	graphics.draw_text(box.desc, "CrystalClear", "left", { x = box.left + 10, y = box.top - 55 }, 18, ClutColour(1, 17)) [TEXTFIX] re-enable when text colours are added
end

function SwitchBox(box)
	if box.text ~= nil and box.letter ~= nil then
		local col_mix = { r = 0.0, g = 0.0, b = 0.0, a = 1.0 }
		if box.special ~= nil then
			if box.special == "click" then
				DrawInterfaceBox(box, 0, 1)
			elseif box.special == "disabled" then
				DrawInterfaceBox(box, -3, -3)
			elseif box.special == "sidecar" then
				DrawBoxWithSidecar(box)
			end
		else
			DrawInterfaceBox(box, 0, 0)
		end
	else
		DrawSmallBox(box)
	end
end

function ChangeSpecial(k, set, table)
	local num = 1
	while table[num] ~= nil do
		if table[num].letter == k then
			table[num].special = set
		end
		num = num + 1
	end
end --