math.randomseed(os.clock())
local tutorial = true
local playerInput 
local difficultyCounter = 1
local rooms = 0
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
    Health = 100,
    Attack = 7,
    Defense = 0
        },
    Goblin = {
    Name = "Goblin",
    Health = 125,
    Attack = 10,
    Defense = 5
    },
    SkeletonBomber = 
    {
    Name = "Skeleton Bomber",
    Health = 40,
    Attack = 40,
    Defense = 0
    },
    Orc = 
    {
    Name = "Orc",
    Health = 90,
    Attack = 18 ,
    Defense = 10
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
local activeEnemy
local function keepValue()
    randomEnemy(enemies)
    activeEnemy = randomEnemy(enemies)
end

    --when a battle is initiated
local function startBattle(enemy, hp, atk, def)
    hp = hp * difficultyCounter
    atk = atk * difficultyCounter
    local function endBattleWin()
        print("You won! You killed " .. enemy .. " sucessfully.")
        difficultyCounter = difficultyCounter + 0.025
        rooms = rooms + 1
        advance = true
        local healChance = math.random(1,2)
        if healChance == 2 then
            print("You looted the " .. enemy .. "'s body and found a Healing Potion!")
            player.Potions = player.Potions + 1
        end
    end

    local function endBattleLose()
        print("You lost! " .. enemy .. " killed you.")
        print("Highest rooms: " .. rooms)
        advance = false
    end

    print("Room " .. rooms .. "\n")
    while(hp > 0) do 
        --actions & stats
    print("Your HP: " .. player.Health)
    if player.Health < 1 then
    endBattleLose()
    break
    end
    print("Your ATK: " .. player.Attack)
    print("Your DEF: " .. player.Defense)
    print("Potions: " .. player.Potions)
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
        print("\n The " .. enemy .. " attacks you and deals " .. atk - player.Defense .. " damage! \n")
        player.Health = player.Health - atk * difficultyCounter + player.Defense
        print("Your HP: " .. player.Health .. "\n")
    end
    if playerInput == "ATTACK" or playerInput == "A" then
        Attack()
        if hp > 0 then
         enemyAttack()
        end
    elseif playerInput == "HEAL" or playerInput == "H" then
        if player.Potions > 0 then
            print("\n You heal and gain 40 hp!")
            player.Health = player.Health + 70 * difficultyCounter
            player.Potions = player.Potions - 1
        else
            print("Cannot heal. Not enough potions!")
        end
        enemyAttack()
    elseif playerInput == "RUN" or playerInput == "R" and tutorial == false then
        print("RUN NOT MADE YET")
    elseif playerInput == "RUN" or playerInput == "R" and tutorial == true then
        print("Can't run from this fight.")
    else
        print("Invalid Option")
    end

until playerInput == "ATTACK" or playerInput == "A" or playerInput == "RUN" or playerInput == "R" or playerInput == "HEAL" or playerInput == "H"
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
print("If you would like to read the game controls, type 'Help'. if not, type 'No'.")
playerInput = io.read():upper()
repeat
if playerInput == "HELP" then
    print("Very well then!")
    print("Attack/A      Attacks the enemy.")
    print("Heal/H        Heals the player.")
    print("Run/R         Runs away. (Not available yet.)")
elseif playerInput == "NO" then
    print("Alright then. Enjoy!")
end
until playerInput == "HELP" or playerInput == "NO"

print("You arrive at the dungeon. Go in?")

repeat
playerInput = io.read():upper()
if playerInput == "YES" then
    --when ur in the dungeon
    print(enterDialogue[math.random(1, #enterDialogue)])

    if tutorial == true then
        print("Welcome to the tutorial. I will be teaching you how to play. \n")
        print("\n Here is a skeleton. Your HP, attack, defense and potions are all at the top, while your enemies stats are at the bottom. \n You can heal by typing heal, attack by typing attack, and run by typing run (it isnt available yet)")
        startBattle(enemies.Skeleton.Name, enemies.Skeleton.Health, enemies.Skeleton.Attack, enemies.Skeleton.Defense)
        if advance == true then
        print("Congratulations on beating the tutorial! You get a free healing potion. The enemies only get harder from here.. \n")
        player.Potions = player.Potions + 1
        tutorial = false
        end
    end

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
        keepValue()
        print("You open the first door. There is a " .. activeEnemy.Name .. " with a sword!")
        startBattle(activeEnemy.Name, activeEnemy.Health, activeEnemy.Attack, activeEnemy.Defense)

    elseif playerInput == "TWO" then
        keepValue()
        print("You open the second door. There is a " .. activeEnemy.Name .. " with a sword!")
        startBattle(activeEnemy.Name, activeEnemy.Health, activeEnemy.Attack, activeEnemy.Defense)
        
    elseif playerInput == "THREE" then
        keepValue()
        print("You open the third door. There is a " .. activeEnemy.Name .. " with a sword!")
        startBattle(activeEnemy.Name, activeEnemy.Health, activeEnemy.Attack, activeEnemy.Defense)
        
    else
        print("Invalid choice.")
    end
    until playerInput == "ONE" or "TWO" or "THREE"
end
until player.Health == 0
else
    print("Stop messing around and enter!")
end
until playerInput == "YES"