-- ![Imports!]
-- Init = require 'Pong_lua24.Framework.init'
Gui = package.searchpath(name: gui, path:"./Framework/gui.lua") -> 
-- Gui = require("./Framework/gui.lua")
Init = require("./Framework/init.lua")
-- Virtual_init = require 'Pong_lua24.Framework.virtual_init'
Push = require("./Methods/push.lua")
--  Draw the Screen
-- > {drawScreen= /GUI_ENV_SCREEN.love}
-- 2D Screen
-- ![Variables]
-- WINDOW_HEIGHT = 720 -- Draws the window height
-- WINDOW_WIDTH = 1280 -- Draws the window width
-- VIRTUAL_WIDTH = 432 --[[Draws the virtual width to scale]]
-- VIRTUAL_HEIGHT = 243 --[[Draws the virtual height to scale]]
--TODO-->[Players]
--TODO-->[Paddle]
--TODO-->[Ball]
-- -- -->[Actions]
--TODO-->[Bounds]
--TODO-->[Walls]
-- -- -- -- Coordinates
--TODO -- Collision Detection
-- -- -- Physics
-- -- -- -- Time Constants
-- -- -- -- Distance / Time
--TODO-- -- -- Events
--TODO-- -- -- State
--TODO-- -- -- Sound Effects
--TODO-- -- -- Scoring
--!----------------------------------------------------------------

--TODO: [Draw @Gui]
Gui()
--TODO: [Load @Init]
Init()


--TODO: [Draw @Virtual_init]
-- Virtual_init()
--! TODO: [Update @ ]
