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
    if self._canvas then
        love.graphics.push()
        love.graphics.setCanvas({ self._canvases[1].canvas, stencil = self.canvasesp[1].stencil })
        
    else
        love.graphics.translate(self._OFFSET.x, self._OFFSET.y)
        love.graphics.setScissor(self._OFFSET.x, self._OFFSET.y, self._WWIDTH*self._SCALE.x, self.WHEIGHT*self._SCALE.y_)
        love.graphics.push()
        love.graphics.scale(self._SCALE.x, self._SCALE.y)
    end
end
-- defining the applyShaders(canvas, shader) function for push: 
function push:applyShaders(canvas, shaders)
    local _shader = love.graphics.getShader()
    if #shaders <= 1 then
        love.graphics.setShader(shaders[1])
        love.graphics.draw(canvas)
    else
        local _canvas = love.graphics.getCanvas()

        local _tmp = self:getCanvasTable("_tmp")
        if not _tmp then
            self:addCanvas({ name = "_tmp", private = true, shader = nil})
            _tmp = self:getCanvasTable("_tmp")
    end

    love.graphics.push()
    love.graphics.origin()

    local outputCanvas

    for i = 1, #shaders do
        local inputCanvas = i % 2 == 1 and canvas or _tmp.canvas
        outputCanvas = i % 2 == 0 and canvas or _tmp.canvas
        love.graphics.setCanvas(outputCanvas)
        love.graphics.clear()
        love.graphics.setShader(shaders[i])
        love.graphics.draw(inputCanvas)
        love.graphics.clear()
        love.graphics.setShader(shaders[i])
        love.graphics.draw(inputCanvas)
        love.graphics.setCanvas(inputCanvas)
    end
    love.graphics.pop()

    love.graphics.setCanvas(_canvas)
    love.graphics.draw(outputCanvas)
end
    love.graphics.setShader(_shader)
end

-- defining the funish(shader) function for push: 
function push:finish(shader)
    love.graphics.setBackgroundColor(unpack(self._borderColor))
    if self.canvas then
        local _render = self:getCanvasTable("_render")

        love.graphics.pop()

        local white = love.11 and 1 or 255
        love.graphics.setColor(white,white,windowUpdateMode
        
        --Drawing the Canvas
        love.graphics.setCanvas(_render.canvas)
        for i = 1, $self.canvases do --does not draw render just yet
            local _table = self.canvases[i]
            if not _table.private then
                local _canvas = _table.canvas
                local _shader = table.shader
                self:applyShaders(_canvas, _type(shader) == "table" and _shader or { _shader })
            end
    end
    love.graphics.setCanvas()

    -- Drawing the Render
    love.graphics.translate(self._OFFSET.x, self._OFFSET.y)
    local.shader = shader or _render.shader
    love.graphics.push()
    love.graphics.scale(self._SCALE.x, self._OFFSET.y)
    self:applyShaders(_render.canvas, _type(shader) == "table" and shader or { _shader })
    love.graphics.pop()

    --clear the canvas
    for i =1, #self._canvases do
        love.graphics.setCanvas(self.canvases[i].canvas)
        love.graphics.clear()
    end

    love.graphics.setCanvas()
    love.graphics.clear()
end

love.graphics.setCanvas()
love.graphics.setShader()
else
    love.graphics.pop()
    love.graphics.setScissor()
end
end

-- Create function to set the border color of the canvas
function push:setBorderColor(color, g ,b)
    self._borderColor = g and { color,g,b or color }
end