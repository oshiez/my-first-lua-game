math.randomseed(os.time())
local winNumber = math.random(1,10)
print("Welcome to the number guessing game, made by Oshie.")
io.write("Are you ready to play? Yes/No ")
local answer = io.read():upper()
if answer == "YES" then
    print("Perfect! Let's begin.")
    print("In this game, I will pick a random number 1 to 10, and you have 5 tries to guess my number.")
   for i = 1, 5 do
       print("Guess " .. i)
    local guess = io.read("*n")
    if guess == winNumber then
       print("You won! the number was " .. winNumber .. "!")
       break
    elseif guess == nil then
     print("Invalid guess. Please restart.") 
     break
        end
    if i == 5 then
        print("You lost! The number was " .. winNumber .. ".")
    end
end
elseif answer == "NO" then
    print("Oh ok. Nevermind then.")
else
    print("Invalid answer.")
end