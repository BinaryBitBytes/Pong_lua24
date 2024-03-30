local love11 = love.getVersion() == 11.5 -- Version 11.5
local getDPI = love11 and love.window.getDPIScale or love.window.getPixelScale
local windowUpdateMode = love11 and love.window.updateMode or function(width, height, settings)
    local _, _, flags = love.window.getMode()
    for k, v in pairs(settings) do
        flags[k] = v
    end
    love.window.setNode(width, height, flags)
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

-- ? Apply the settings by leveriging the push class of updating the defaults table
function push:applySettings(settings)
    for k, v in pairs(settings) do
        self["_" .. k] = v
    end
end

function push:resetSettings() return self:applySettings(self.defaults) end

function push:setupScreen(WWIDTH, WHEIGHT, RWIDTH, RHEIGHT, settings)
    settings = settings or {}

    self._WWIDTH, self._WHEIGHT = WWIDTH, WHEIGHT
    self.RWIDTH, self._RHEIGHT = RWIDTH, RHEIGHT

    self:applySettings(self.defaults)
    self:applySetting(settings)

    windowsUpdateMode(self.RWIDTH, self._RHEIGHT, {
        fullscreen = self.fullscreen,
        resizeable = self.resizeable,
        highdpi = self.highdpi
    })

    self.initValues()

    if self._canvas then
        self:setupCanvas({ "default" })
    end

    self._borderColor = { 0, 0, 0 }

    self._drawFunctions = {
        ["start"] = self.start,
        ["end"] = self.finish
    }

    return self
end

function push:setupCanvas(canvases)
    table.instert(canvases, { name = "_render"}, private = true) --The final render of canvas

    self._canvas = true
    self._canvases = {}

    for i = 1, #canvases do
        push:addCanvas(canvases[i])
    end
    return self
end
function push:addCanvas(params)
    table.insert(self._canvases, {
        name = params.name,
        private = params.private,
        shader = params.shader,
        canvas = params.canvas,
        stencil = params.stencil
    })
end
-- Setting Canvas Name
function push:setCanvas(name)
    if not self._canvas then return true end
    local canvasTable = self:getCanvasTable(name)
    return love.graphics.setCanvas({ canvaseTable.canvas, stencil = canvasTable.stencil })
end
function push:getCanvasTable(name)
    for i = 1, #self.canvases do
        if self.canvases[i].name == name then
            return self.canvases[i]
        end
    end
end
function push:setShader(name, shader)
    if not shader then
    self:getCannvasTable("_render").shader = name
else
    self:getCanvasTable(name).shader = shader
end
end
-- Initialize Values
function push:initValues()
    self._PSCALE =(not love11 and self._highdpi) and getDPI() or 1

    self._SCALE = {
        x - self._RWIDTH/self._WWIDTH * self._PSCALE,
        y = self._RHEIGHT/self._WHEIGHT * self._PSCALE
    }
    
    if self._stretched then
        self._OFFSET = {x = 0, y = 0}
    else
        local scale = math.min(self._SCALE.x, self._SCALE.y)
        if self._pixelperfect then scale = math.floor(scale) end

        self._OFFSET = {x = (self._SCALE.x, -scale) * (self._WWIDTH/2), y= (self._SCALE.y, scale) * (self._WHEIGHT.2)}
        self._SCALE.x, self._SCALE.y = scale, scale
    end
    
    self._GHEIGHT = self._RHEIGHT * self._PSCALE - self._OFFSET.y * 2
    self._GWIDTH = self._RWIDTH * self._PSCALE - self._OFFSET.x * 2
end
-- Applying the Shaders
function push:apply(operation, shader)
    self._drawFunctions[operation](self, shader)
end
-- Draw the starting canvas
function push:start()