functions = require("functions")

function love.load()
    luigi = love.graphics.newImage('images/LUIGI_WANTED.png')
    mario = love.graphics.newImage('images/MARIO_WANTED.png')
    wario = love.graphics.newImage('images/WARIO_WANTED.png')
    yoshi = love.graphics.newImage('images/YOSHI_WANTED.png')
    soul = love.graphics.newImage('images/UT_SOUL.png')
    hurtsoul = love.graphics.newImage('images/UT_SOUL_HURT.png')
    deadsoul = love.graphics.newImage('images/UT_SOUL_BREAK.png')

    love.window.setMode(1000, 1000, {resizable = true})

    titleX = love.graphics.getWidth() / 2
    titleY = love.graphics.getHeight() / 2

    soulX = 500
    soulY = 500
    soulW = soul:getWidth()
    soulH = soul:getHeight()
    soulSpeed = 5
    health = 100
    damageTimer = 0

    charX = 0
    charY = 0
    marioW = mario:getWidth()
    marioH = mario:getHeight()

    warioW = wario:getWidth()
    warioH = wario:getHeight()

    yoshiW = yoshi:getWidth()
    yoshiH = yoshi:getHeight()

    luigiW = luigi:getWidth()
    luigiH = luigi:getHeight()

    title = true
    game = false
    dead = false
    win = false
    level = 25

    timer = 0

    isHurt = false
    hurtTimer = 0


    characters = {}
    functions:updateLevel()
    functions:gencharacters(luigi, numLuigi)
    functions:gencharacters(mario, numMario)
    functions:gencharacters(wario, numWario)
    functions:gencharacters(yoshi, numYoshi)

    hurtsound = love.audio.newSource('sounds/snd_hurt1.wav', "stream")
    deadsound = love.audio.newSource('sounds/snd_break1.wav', "stream")
    healsound = love.audio.newSource('sounds/snd_heal1.mp3', "stream")

    music = love.audio.newSource('sounds/mus_hopesanddreams.mp3', "stream")
    music:setLooping(true)
end

local groundY = love.graphics.getHeight() + love.graphics.getHeight()
local jumpStrength = -15
local gravity = 0.5

function love.update(dt)
    if game == true then
        timer = timer + dt
        love.audio.play(music)
        damageTimer = damageTimer + dt
        if love.keyboard.isDown('up') then
            soulY = soulY - soulSpeed
            if soulY <= 0 then
                soulY = soulY + soulSpeed
            end
        end
        if love.keyboard.isDown('down') then
            soulY = soulY + soulSpeed
            if soulY + soulH >= love.graphics.getHeight() then
                soulY = soulY - soulSpeed
            end
        end
        if love.keyboard.isDown('left') then
            soulX = soulX - soulSpeed
            if soulX <= 0 then
                soulX = soulX + soulSpeed
            end
        end
        if love.keyboard.isDown('right') then
            soulX = soulX + soulSpeed
            if soulX + soulW >= love.graphics.getWidth() then
                soulX = soulX - soulSpeed
            end
        end
       
        for _, char in ipairs(characters) do
            if level == 25 then
                if char.y + char.texture:getHeight() < groundY then
                    char.dy = char.dy + gravity  -- Falling
                else
                    char.dy = 0
                    char.y = groundY - char.texture:getHeight()  -- Ensure the character is on the ground
                    char.isJumping = false  -- The character is not jumping when on the ground
                end

                if char.isJumping == false then
                    char.dy = jumpStrength  -- Apply upward force for jump
                    char.isJumping = true
                end
            end

            char.x = char.x + char.dx
            char.y = char.y + char.dy
            
            if char.texture == mario then
                if char.x <= 0 or char.x + marioW >= love.graphics.getWidth() then
                    char.dx = -char.dx  
                end
                if char.y <= 0 or char.y + marioH >= love.graphics.getHeight() then
                    char.dy = -char.dy  
                end
            end
            if char.texture == wario then
                if char.x <= 0 or char.x + warioW >= love.graphics.getWidth() then
                    char.dx = -char.dx  
                end
                if char.y <= 0 or char.y + warioH >= love.graphics.getHeight() then
                    char.dy = -char.dy  
                end
            end
            if char.texture == yoshi then
                if char.x <= 0 or char.x + yoshiW >= love.graphics.getWidth() then
                    char.dx = -char.dx 
                end
                if char.y <= 0 or char.y + yoshiH >= love.graphics.getHeight() then
                    char.dy = -char.dy 
                end
            end
            if char.texture == luigi then
                if char.x <= 0 or char.x + luigiW >= love.graphics.getWidth() then
                    char.dx = -char.dx  
                end
                if char.y <= 0 or char.y + luigiH >= love.graphics.getHeight() then
                    char.dy = -char.dy  
                end
            end

            if damageTimer > 1 then
                if char.texture == luigi then
                    if functions:checkCollision(char.x, char.y, luigiW, luigiH, soulX, soulY, soulW, soulH) then
                        damageTimer = 0
                        if health >= 90 then
                            health = 100
                        else
                            health = health + 20
                        end
                        level = level + 1
                        functions:updateLevel()  
                        characters = {}  
                        functions:gencharacters(luigi, numLuigi)
                        functions:gencharacters(mario, numMario)  
                        functions:gencharacters(wario, numWario)
                        functions:gencharacters(yoshi, numYoshi)
                        love.audio.play(healsound)
                    end
                elseif char.texture == wario then
                    if functions:checkCollision(char.x, char.y, warioW, warioH, soulX, soulY, soulW, soulH) then
                        health = math.max(health - 10, 0)
                        damageTimer = 0
                        love.audio.play(hurtsound)
                        isHurt = true
                        hurtTimer = hurtTimer + dt
                    end
                elseif char.texture == yoshi then
                    if functions:checkCollision(char.x, char.y, yoshiW, yoshiH, soulX, soulY, soulW, soulH) then
                        health = math.max(health - 10, 0)
                        damageTimer = 0
                        love.audio.play(hurtsound)
                        isHurt = true
                        hurtTimer = hurtTimer + dt
                    end
                elseif char.texture == mario then
                    if functions:checkCollision(char.x, char.y, marioW, marioH, soulX, soulY, soulW, soulH) then
                        health = math.max(health - 10, 0)
                        damageTimer = 0
                        love.audio.play(hurtsound)
                        isHurt = true
                        hurtTimer = hurtTimer + dt
                    end
                end
            end
            if damageTimer >= 1.5 then
                isHurt = false
            end
        end

        if health == 0 then
            game = false
            dead = true
            love.audio.pause(music)
            love.audio.play(deadsound)
        end
        --if level > 8 then
            --game = false
            --love.audio.pause(music)
            --win = true
        --end
    end
end

function love.draw()
    if title == true then
        love.graphics.print('Find Luigi', titleX, titleY)
    end
    if game == true then
        love.graphics.clear()
        love.graphics.print(level, love.graphics.getWidth() - 100, love.graphics.getHeight() - 100)

        if isHurt == true then
            -- Use math.floor to divide the damageTimer into intervals
            local flashInterval = math.floor(damageTimer * 10) % 2  -- This will alternate between 0 and 1 in intervals of 0.2 seconds
        
            if flashInterval == 0 then
                love.graphics.draw(soul, soulX, soulY)  -- Draw normal soul
            else
                love.graphics.draw(hurtsoul, soulX, soulY)  -- Draw hurt soul
            end
        else
            -- If not hurt, draw the normal soul
            love.graphics.draw(soul, soulX, soulY)
        end

        for _, char in ipairs(characters) do
            love.graphics.draw(char.texture, char.x, char.y)
        end
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() - 100, 200, 50)
        love.graphics.setColor(1, 1, 0)  
        love.graphics.rectangle("fill", love.graphics.getWidth() / 2 - 100, love.graphics.getHeight() - 100, health * 2, 50)
        love.graphics.setColor(1, 1, 1)
    end
    if dead == true then
        love.graphics.draw(deadsoul, soulX, soulY)
        love.graphics.print("you got to level " .. level, love.graphics.getWidth() / 2, love.graphics.getHeight() / 2)
        love.graphics.print("you survived for " .. timer .. " seconds", love.graphics.getWidth() / 2, love.graphics.getHeight() / 2 + 50)
    end
    if win == true then
        love.graphics.draw(soul, soulX, soulY)
        love.graphics.print('you found Luigi', titleX, titleY)
    end
end

function love.keypressed(key, scancode)
    if title == true then
        if key == 'return' then
            title = false
            game = true
        end
    end
    if dead == true then
        if key == 'return' then
            dead = false
            game = true
            level = 0
            timer = 0
            health = 100  
            damageTimer = 0
            functions:updateLevel() 
            characters = {}  
            functions:gencharacters(luigi, numLuigi)
            functions:gencharacters(mario, numMario)
            functions:gencharacters(wario, numWario)
            functions:gencharacters(yoshi, numYoshi)
            love.audio.play(healsound)
            music:seek(0, 'seconds')
        end
    end

    if key == 'escape' then
        love.event.quit()
    end
end