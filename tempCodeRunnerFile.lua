math.randomseed(os.time())
local playerInput 
--creates player and its stats
local player = {
    Health = 100,
    Attack = 20,
    Defense = 5
}
-- the enemies
 local enemies = {
    Skeleton = {
    Name = "Skeleton",
    Health = 100,
    Attack = 5,
    Defense = 0
        }
    }



    --when a battle is initiated
local function startBattle(enemy, hp, atk, def)
    while(hp ~= 0) do 
    print("Your HP: " .. player.Health)
    print("Your ATK: " .. player.Attack)
    print("Your DEF: " .. player.Defense)
    print("---------------------")
    print(enemy .. " HP: " .. hp)
    print(enemy .. " ATK: " .. atk)
    print(enemy .. " DEF: " .. def)
    repeat
    print("\n What would you like to do?")
    print("Attack   Run (Not Available Yet)")
    playerInput = io.read():upper()
    

    local function Attack()
    
    print("You attack the " .. enemy .. " and deal " .. player.Attack .. " damage.")
    hp = hp - player.Attack
    print(enemy .. " HP: " .. hp .. "\n")
    end

    if playerInput == "ATTACK" then
        Attack()
    else
        print("Invalid Option")
    end
until playerInput == "ATTACK" or playerInput == "RUN"
end
end

--when you enter the dungeon at the start
local enterDialogue = {
    "You enter the dungeon and look around, the strange environment confuses you.",
    "You open the doors and are welcomed by a cold breeze, and the doors shut behind you.",
    "As you enter, the doors shut and you look around, observing the unnerving dungeon."
}
print("You arrive at the dungeon. Go in?")
repeat
playerInput = io.read():upper()
if playerInput == "YES" then
    print(enterDialogue[math.random(1, #enterDialogue)])
    print("There are three doors infront of you. Which one do you choose?")
    repeat
    playerInput = io.read():upper()
    if playerInput == "ONE" then
        print("You open the first door. There is a skeleton with a sword!")
        startBattle(enemies.Skeleton.Name, enemies.Skeleton.Health, enemies.Skeleton.Attack, enemies.Skeleton.Defense)
    else
         print("This isnt a valid option. Right now, there is only one door, so please say 'one'.")
    end
    until playerInput == "ONE"
else
    print("Stop messing around and enter!")
end
until playerInput == "YES"