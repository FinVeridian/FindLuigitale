functions = {}

function functions:gencharacters(texture, count)
    for i = 1, count do  
        local char = {}
        char.texture = texture
        char.dy = 0
        char.isJumping = false

        if level == 0 then
            char.x = love.graphics.getWidth() / 2
            char.y = love.graphics.getHeight() / 2 + 200
        end
        if level == 9 then
            if texture == mario then
                char.x = math.random(0, love.graphics.getWidth() / 4)
                char.y = math.random(0, love.graphics.getHeight() / 4)
            elseif texture == wario then
                char.x = math.random(0, love.graphics.getWidth() / 4)
                char.y = math.random(0, love.graphics.getHeight() / 4)
            elseif texture == yoshi then
                char.x = math.random(0, love.graphics.getWidth() / 4)
                char.y = math.random(0, love.graphics.getHeight() / 4)
            elseif texture == luigi then
                char.x = math.random(0, love.graphics.getWidth() / 4)
                char.y = math.random(0, love.graphics.getHeight() / 4)
            end
        elseif level == 20 then
            if texture == mario then
                char.x = math.random(0, love.graphics.getWidth() / 5)
                char.y = math.random(0, love.graphics.getHeight() / 5)
            elseif texture == wario then
                char.x = math.random(0, love.graphics.getWidth() / 5)
                char.y = math.random(0, love.graphics.getHeight() / 5)
            elseif texture == yoshi then
                char.x = math.random(0, love.graphics.getWidth() / 5)
                char.y = math.random(0, love.graphics.getHeight() / 5)
            elseif texture == luigi then
                char.x = math.random(0, love.graphics.getWidth() / 5)
                char.y = math.random(0, love.graphics.getHeight() / 5)
            end
        elseif level == 25 then
            char.x = math.random(0, love.graphics.getWidth() - texture:getWidth())
            char.y = love.graphics.getHeight() - texture:getHeight()
        elseif level > 0 then
            if texture == mario then
                char.x = math.random(0, love.graphics.getWidth() - marioW)
                char.y = math.random(0, love.graphics.getHeight() - marioH)
            elseif texture == wario then
                char.x = math.random(0, love.graphics.getWidth() - warioW)
                char.y = math.random(0, love.graphics.getHeight() - warioH)
            elseif texture == yoshi then
                char.x = math.random(0, love.graphics.getWidth() - yoshiW)
                char.y = math.random(0, love.graphics.getHeight() - yoshiH)
            elseif texture == luigi then
                char.x = math.random(0, love.graphics.getWidth() - luigiW)
                char.y = math.random(0, love.graphics.getHeight() - luigiH)
            end
        end
        if level == 0 then -- only luigi
            char.dx = 0
            char.dy = 0
        elseif level == 1 then -- 5 each
            char.dx = 2.5
            char.dy = 2.5
        elseif level == 2 then -- 
            char.dx = 2.7
            char.dy = 2.2
        elseif level == 3 then
            char.dx = 2.8
            char.dy = 3.2
        elseif level == 4 then
            char.dx = 2
            char.dy = 2
        elseif level == 5 then -- 1 of each
            char.dx = 9
            char.dy = 9
        elseif level == 6 then
            char.dx = 0
            char.dy = 0
        elseif level == 7 then
            char.dx = math.random(2, 3)
            char.dy = math.random(3, 3)
        elseif level == 8 then
            char.dx = math.random(1, 2)
            char.dy = math.random(1, 3)
        elseif level == 9 then
            if char.texture == luigi then
                char.dx = 1.6
                char.dy = 1.6
            else
                char.dx = 1.5
                char.dy = 1.5
            end
        elseif level == 10 then
            char.dx = math.random(1, 3)
            char.dy = math.random(1, 3)
        elseif level > 10 and level < 20 then
            char.dx = math.random(1, 4)
            char.dy = math.random(1, 4)
        elseif level == 20 then
            if char.texture == luigi then
                char.dx = 1.23
                char.dy = 2.43
            else
                char.dx = 1.2
                char.dy = 2.4
            end
        elseif level > 20 and level < 25 then
            char.dx = math.random(2, 5)
            char.dy = math.random(2, 5)
        elseif level == 25 then
            char.dx = math.random(1, 3)
            char.dy = math.random(2, 8)
        end
        table.insert(characters, char)
    end
end

function functions:checkCollision(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 < x2 + w2 and x1 + w1 > x2 and y1 < y2 + h2 and y1 + h1 > y2
end

function functions:updateLevel()
    if level == 0 then
        numMario = 0
        numWario = 0
        numYoshi = 0
        numLuigi = 1
    elseif level == 1 then
        numMario = 5
        numWario = 5
        numYoshi = 5
        numLuigi = 1
    elseif level == 2 then
        numMario = 7
        numWario = 9
        numYoshi = 8
        numLuigi = 1
    elseif level == 3 then
        numMario = 10
        numWario = 9
        numYoshi = 13
        numLuigi = 1
    elseif level == 4 then
        numMario = 0
        numWario = 0
        numYoshi = 70
        numLuigi = 1
    elseif level == 5 then
        numMario = 1
        numWario = 1
        numYoshi = 1
        numLuigi = 1
    elseif level == 6 then
        numMario = 60
        numWario = 60
        numYoshi = 60
        numLuigi = 1
    elseif level == 7 then
        numMario = 15
        numWario = 15
        numYoshi = 15
        numLuigi = 1
    elseif level == 8 then
        numMario = 90
        numWario = 0
        numYoshi = 0
        numLuigi = 1
    elseif level == 9 then
        numMario = 70
        numWario = 40
        numYoshi = 60
        numLuigi = 1
    elseif level == 10 then
        numMario = math.random(4, 50)
        numWario = math.random(4, 50)
        numYoshi = math.random(4, 50)
        numLuigi = 1
    elseif level > 10 then
        numMario = math.random(1, 50)
        numWario = math.random(1, 60)
        numYoshi = math.random(1, 60)
        numLuigi = 1
    elseif level == 20 then
        numMario = 80
        numWario = 70
        numYoshi = 90
        numLuigi = 1
    elseif level > 20 then
        numMario = math.random(1, 70)
        numWario = math.random(1, 65)
        numYoshi = math.random(1, 70)
        numLuigi = 1
    elseif level == 25 then
        numMario = math.random(1, 50)
        numWario = math.random(1, 60)
        numYoshi = math.random(1, 45)
        numLuigi = 1
    end
end

return functions