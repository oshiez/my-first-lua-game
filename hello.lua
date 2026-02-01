math.randomseed(os.clock())
local tutorial = true
local playerInput 
local difficultyCounter = 1
local advance = false 
--creates player and its stats
local player = {
    Health = 200,
    Attack = 20,
    Defense = 5,
    Potions = 0
}
-- the enemies
 local enemies = {
    Skeleton = {
    Name = "Skeleton",
    Health = 100 * difficultyCounter,
    Attack = 7 * difficultyCounter,
    Defense = 0
        },
    Goblin = {
    Name = "Goblin",
    Health = 125 * difficultyCounter,
    Attack = 10 * difficultyCounter,
    Defense = 5
    }
}
--counts enemies
--current problem: enemies stats get randomized aswell idk why
local function randomEnemy(dict)
    local keys = {}
    for k, i in pairs(dict) do
        table.insert(keys, k)
    end
    local randomEnemy = math.random(1, #keys)
    local pickedEnemy = keys[randomEnemy]
    return dict[pickedEnemy]
end

    --when a battle is initiated
local function startBattle(enemy, hp, atk, def)

    local function endBattleWin()
        print("You won! You killed " .. enemy .. " sucessfully.")
        advance = true
        local healChance = math.random(1,3)
        if healChance == 2 then
            print("You looted the " .. enemy .. "'s body and found a Healing Potion!")
            player.Potions = player.Potions + 1
        end
    end

    local function endBattleLose()
        print("You lost! " .. enemy .. " killed you.")
    end


    while(hp > 0) do 
        --actions & stats
    print("Your HP: " .. player.Health)
    if player.Health < 1 then
    endBattleLose()
    break
    end
    print("Your ATK: " .. player.Attack)
    print("Your DEF: " .. player.Defense)
    print("---------------------")
    print(enemy .. " HP: " .. hp)
    print(enemy .. " ATK: " .. atk)
    print(enemy .. " DEF: " .. def)
    repeat
    print("\n What would you like to do?")
    print("      Attack  Heal  Run (Not Available Yet)")
    playerInput = io.read():upper()
    
    --attack function
    local function Attack()
    print("\n You attack the " .. enemy .. " and deal " .. player.Attack .. " damage.")
    hp = hp - player.Attack + def
    print(enemy .. " HP: " .. hp .. "\n")
    end

    --evil enemy attack function
    local function enemyAttack()
        print("\n The " .. enemy .. " attacks you and deals " .. atk - player.Defense .. " damage!")
        player.Health = player.Health - atk + player.Defense
        print("Your HP: " .. player.Health .. "\n")
    end
    if playerInput == "ATTACK" then
        Attack()
        if hp > 0 then
         enemyAttack()
        end
    elseif playerInput == "HEAL" then
        if player.Potions > 0 then
            player.Health = player.Health + 25
        else
            print("Cannot heal. Not enough potions!")
        end
        enemyAttack()
    elseif playerInput == "RUN" and tutorial == false then
        print("RUN NOT MADE YET")
    elseif playerInput == "RUN" and tutorial == true then
        print("Can't run from this fight.")
    else
        print("Invalid Option")
    end

until playerInput == "ATTACK" or playerInput == "RUN" or playerInput == "HEAL"
end

if player.Health > 0 then
    endBattleWin()
end
end
--automatically generates when u enter
local enterDialogue = {
    "You enter the dungeon and look around, the strange environment confuses you.",
    "You open the doors and are welcomed by a cold breeze, and the doors shut behind you.",
    "As you enter, the doors shut and you look around, observing the unnerving dungeon."
}

--when u enter the dungeon
print("Everything made by Oshie")
print("Welcome to The Dungeon! In this game, you fight off monsters and see how far you can get. \n Heres how to play: pick a door and you will encounter an enemy! Use Attack or Heal strategically to take them down!")
print("You arrive at the dungeon. Go in?")
repeat
playerInput = io.read():upper()
if playerInput == "YES" then
    --when ur in the dungeon
    print(enterDialogue[math.random(1, #enterDialogue)])
    repeat
        if tutorial == false then
            print("You wipe the dirt off you from the last fight and look at the new room you are in.")
        end
    print("There are three doors infront of you. Which one do you choose?")
    
    advance = false
    --enter a door
    while advance == false do
    repeat
    playerInput = io.read():upper()
    if playerInput == "ONE" then
        print("You open the first door. There is a " .. randomEnemy(enemies).Name .. " with a sword!")
        startBattle(randomEnemy(enemies).Name, randomEnemy(enemies).Health, randomEnemy(enemies).Attack, randomEnemy(enemies).Defense)

    elseif playerInput == "TWO" then
        print("You open the second door. There is a " .. randomEnemy(enemies).Name .. " with a sword!")
        startBattle(randomEnemy(enemies).Name, randomEnemy(enemies).Health, randomEnemy(enemies).Attack, randomEnemy(enemies).Defense)
        
    elseif playerInput == "THREE" then
        print("You open the third door. There is a " .. randomEnemy(enemies).Name .. " with a sword!")
        startBattle(randomEnemy(enemies).Name, randomEnemy(enemies).Health, randomEnemy(enemies).Attack, randomEnemy(enemies).Defense)
        
    else
        print("Invalid choice.")
    end
    until playerInput == "ONE" or "TWO" or "THREE"
end
    if tutorial == true and advance == true then
        print("Congratulations on beating the tutorial! You get a free healing potion. The enemies only get harder from here.. \n")
        player.Potions = player.Potions + 1
        tutorial = false
    elseif tutorial == false and advance == true then
        difficultyCounter = difficultyCounter + 100
    end
    
until player.Health == 0
else
    print("Stop messing around and enter!")
end
until playerInput == "YES"