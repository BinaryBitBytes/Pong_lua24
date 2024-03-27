
<Head className=`Title` style='color:red'>Lesson 1 Notes: Pong</Head>
<Header className=`Contributors`>
By: BinaryBitBytes
</Header>
<Body>
<Section>

># Love2d 
>> [Love2d Framework Boilerplate](https://love2d.org/wiki/love#:~:text=%2D%2D%20Load%20some%20default,h)
>>>```lua
>>>-- Load some default values for our rectangle.
>>>function love.load()
>>>   x, y, w, h = 20, 20, 60, 20
>>>end
>>>-- Increase the size of the rectangle every frame.
>>>function love.update(dt)
>>>   w = w + 1
>>>   h = h + 1
>>>end
>>>-- Draw a coloured rectangle.
>>>function love.draw()
>>>    -- In versions prior to 11.0, color component values are (0, 102, 102)
>>>   love.graphics.setColor(0, 0.4, 0.4)
>>>   love.graphics.rectangle("fill", x, y, w, h)
>>>end
>>>```
>> [How to Run Lua Game in Love2D](https://love2d.org/wiki/Getting_Started#:~:text=easiest%20way%20to%20run%20the%20game%20is%20to%20drag%20the%20folder%20onto%20either%20love.exe%20or%20a%20shortcut%20to%20love.exe.%20Remember%20to%20drag%20the%20folder%20containing%20main.lua%2C%20and%20not%20main.lua%20itself.)
</Section>
<Section>

># Lua Notes
> [Env & Global Variables](https://www.lua.org/manual/5.4/manual.html#:~:text=2.2%20–%20Environments%20and%20the%20Global%20Environment)
> [Types](https://www.lua.org/manual/5.4/manual.html#:~:text=2.1%20%E2%80%93%20Values%20and%20Types)
>> ```There are eight basic types in Lua:```
>>> 1. nil
>>> 2. boolean
>>> 3. number
>>> 4. string
>>> 5. function
>>> 6. userdata
>>> 7. thread
>>> 8. table

</Section>
</Body>