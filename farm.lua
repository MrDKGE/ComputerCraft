while true do
    -- Initialize variables
    local fieldLength = 18
    local fieldWidth = 18

    -- array of items with their full grown age
    local crops = {
        ["minecraft:wheat"] = 7,
        ["minecraft:potatoes"] = 7,
        ["minecraft:carrots"] = 7,
        ["minecraft:beetroots"] = 3,
        ["farmersdelight:cabbages"] = 7,
        ["farmersdelight:tomatoes"] = 3
    }

    -- Check if refuel is needed
    if turtle.getFuelLevel() < (fieldLength * fieldWidth) then
        print("Turtle needs to be refueled")
        print("Turtle has", turtle.getFuelLevel(), "Fuel")
        print("Turtle needs", (fieldLength * fieldWidth), "Fuel")
        print("Refueling...")
        -- check if there is fuel in the first slot, and if it is enough to refuel
        if turtle.getItemCount(1) < (fieldLength * fieldWidth) then
            print("Not enough fuel in slot 1")
            print("Turtle has", turtle.getItemCount(1), "Fuel")
            print("Turtle needs", (fieldLength * fieldWidth), "Fuel")
            print("Please add fuel to slot 1")
            print("Exiting...")
            sleep(5)
            os.reboot(1)
        end
        turtle.select(1)    
        turtle.refuel()
        print("Turtle refueled")
        print("Turtle has", turtle.getFuelLevel(), "Fuel")
        print("Starting...")
        sleep(1)
    else 
        print("Turtle has enough fuel")
        print("Turtle has", turtle.getFuelLevel(), "Fuel")
        print("Turtle needs", (fieldLength * fieldWidth), "Fuel")
        print("Starting...")
        sleep(1)
    end

    -- Main part of the script to farm the field
    turtle.select(2)
    turtle.forward(1)  -- Move the turtle onto the field to start

    for row = 1, fieldWidth do
        for i = 1, fieldLength do
            -- Inspect the block under the turtle
            local success, data = turtle.inspectDown()
            if success then
                -- compare the crop under the turtle to the crops array
                if crops[data.name] and data.state.age == crops[data.name] then
                    turtle.digDown()
                    turtle.placeDown()
                end
            end
            if i < fieldLength then
                turtle.forward(1)
            end
        end
        
        if row < fieldWidth then  -- Not the last row
            if row % 2 == 1 then
                turtle.turnRight()
                turtle.forward(1)
                turtle.turnRight()
            else
                turtle.turnLeft()
                turtle.forward(1)
                turtle.turnLeft()
            end
        else
            -- if the row is odd, turn around and move to the end of the field
            if row % 2 == 1 then
                turtle.turnLeft()
                turtle.turnLeft()
                for i = 1, fieldLength do
                    turtle.forward(1)
                end
                turtle.turnRight()
            else -- if the row is even, turn around and move to the end of the field
                turtle.forward(1)
                turtle.turnRight()
            end
        
            local adjustedFieldWidth = fieldWidth - 1
            for i = 1, adjustedFieldWidth do
                turtle.forward(1)
            end
            turtle.turnRight()
        
        end
    end

    -- Pause for 45 minutes before running again
    print("Sleeping for 45 minutes...")
    sleep(2700)

    -- exit the program
    -- return
end
