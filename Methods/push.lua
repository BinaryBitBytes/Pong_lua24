local love11 = love.getVersion() == 11.5 -- Version 11.5
local getDPI = love11 and love.window.getDPIScale or love.window.getPixelScale
local windowUpdateMode = love11 and love.window.updateMode or function(width, height, settings)
    local _, _, flags = love.window.getMode()
    for k, v in pairs(settings) do
        flags[k] = v
    end
end

local push = {

    defaults = {
        fullscreen = false,
        resizeable = false,
        pixelperfect = false,
        highdpi = true,
        canvas = true,
        stencil = true
    }
}
setmetatable(push, push)
