--[[-------------------------
    --{{-----------------
        Colour Tables
    -----------------}}--
-------------------------]]--

-- CLUT VALUES
CLUT = {    { r = 1.0, g = 1.0, b = 1.0, a = 1.0 }, -- white
            { r = 1.0, g = 0.5, b = 0.0, a = 1.0 }, -- orange
            { r = 1.0, g = 1.0, b = 0.0, a = 1.0 }, -- yellow
            { r = 0.0, g = 0.0, b = 1.0, a = 1.0 }, -- blue
            { r = 0.0, g = 1.0, b = 0.0, a = 1.0 }, -- green
            { r = 0.5, g = 0.0, b = 1.0, a = 1.0 }, -- purple
            { r = 0.5, g = 0.5, b = 1.0, a = 1.0 }, -- grey-blue
            { r = 1.0, g = 0.5, b = 0.5, a = 1.0 }, -- rose
            { r = 1.0, g = 1.0, b = 0.5, a = 1.0 }, -- light-yellow
            { r = 0.0, g = 1.0, b = 1.0, a = 1.0 }, -- teal
            { r = 1.0, g = 0.0, b = 0.5, a = 1.0 }, -- hot-pink
            { r = 0.5, g = 1.0, b = 0.5, a = 1.0 }, -- light-green
            { r = 1.0, g = 0.5, b = 1.0, a = 1.0 }, -- light-pink
            { r = 0.0, g = 0.5, b = 1.0, a = 1.0 }, -- aqua-marine
            { r = 1.0, g = 1.0, b = 0.8, a = 1.0 }, -- peach
            { r = 1.0, g = 0.0, b = 0.0, a = 1.0 }  -- red
       }

modifier = { 1.0, 0.941, 0.878, 0.816, 0.753, 0.690, 0.627, 0.565, 0.502, 0.439, 0.376, 0.251, 0.188, 0.125, 0.063, 0.031, 0.0 }

function ClutColour(clutNum, modNum)
    if modNum == nil then
    clutNum, modNum = math.floor(clutNum/16)+1,clutNum%16+1
    end
    return { r = CLUT[clutNum].r * modifier[modNum], g = CLUT[clutNum].g * modifier[modNum], b = CLUT[clutNum].b * modifier[modNum], a = 1.0, c = clutNum, m = modNum }
end

function ClutLighten(colour, lightness)
    local newColour = colour.m
    
    if lightness == nil then
        lightness = 1
    end
    
    if colour.m + lightness > 17 then
        newColour = 17
    elseif colour.m + lightness < 1 then
        newColour = 1
    else
        newColour = colour.m + lightness
    end
    
    return { r = CLUT[colour.c].r * modifier[newColour], g = CLUT[colour.c].g * modifier[newColour], b = CLUT[colour.c].b * modifier[newColour], a = 1.0, c = colour.c, m = colour.m }
end

function ClutDarken(colour, darkness)
    return ClutLighten(colour, -(darkness or 1))
end

function ClutDisplay()
    local i = 1
    while CLUT[i] ~= nil do
        local j = 1
        while modifier[j] ~= nil do
            graphics.draw_box(i * -10 + 150, j * 10 + 10, i * -10 + 160, j * 10, 0, ClutColour(i, j))
            j = j + 1
        end
        i = i + 1
    end
end

-- NON-COLOUR VALUES
cClear = { r = 0.0, g = 0.0, b = 0.0, a = 0.0 }
cHalfClear = { r = 0.0, g = 0.0, b = 0.0, a = 0.5 }

--[[-------------------------------
    --{{-----------------------
        Colour Manipulation
    -----------------------}}--
-------------------------------]]--

function FixColour(colour)
    if colour.r > 1 then
        colour.r = 1
    elseif colour.r < 0 then
        colour.r = 0
    end
    if colour.g > 1 then
        colour.g = 1
    elseif colour.g < 0 then
        colour.g = 0
    end
    if colour.b > 1 then
        colour.b = 1
    elseif colour.b < 0 then
        colour.b = 0
    end
    if colour.a > 1 then
        colour.a = 1
    elseif colour.a < 0 then
        colour.a = 0
    end
    return colour
end