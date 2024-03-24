WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

-- ?> TODO: Init Game
function love.load()
    love.window.setMode(WINDOW_WIDTH,WINDOW_HEIGHT, {
        fullscreen = false,
        resizeable = false,
        vsync = true
    })
end