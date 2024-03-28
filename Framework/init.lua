push = require 'push'

WINDOW_WIDTH = 1280 -- Draws the window width
WINDOW_HEIGHT = 720 -- Draws the window height
VIRTUAL_WIDTH = 432 --[[Draws the virtual width to scale]]
VIRTUAL_HEIGHT = 243 --[[Draws the virtual height to scale]]

-- ?> TODO: Init Game
function Init(start, filter, setup, display)
    start = love.load() -- Loads Love;
    filter = love.graphics.setDefaultFilter('nearest', 'nearest');
    setup = push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizeable = false,
        vsync = true,
    });
    -- defining window resolution below
    display = love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizeable = false,
        vsync = true, --syncing frames
    })
end
