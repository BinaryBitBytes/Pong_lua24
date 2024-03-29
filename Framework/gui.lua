-- --!Call Each Frane After Updating Drawing
function love.draw(window)
    window = love.graphics.printf(
        'Hello, Welcome to Pong!',
        0,
        WINDOW_HEIGHT / 2 - 6,
        WINDOW_WIDTH,
        'center')
end
