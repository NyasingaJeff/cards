 #!/usr/bin/ruby
require_relative  'player'


def gamestart
    #initiate the stack  to get the actual deck of cards to play
    stack= PlayinStack.new    
    # initialize an array that will be used to hold the players
    players=Array.new
    # prompt get the player names accordingly
    puts ('enter number of players:')
    #get the actual input
    input = gets.chomp()
    i=0
    while (i + 1)<= (input.to_i)       
     
        puts ("enter player #{i+1}'s name")
        name=gets.chomp().capitalize
        # make a hand of cards that the user will use
        hand=stack.distribute
        # initiate the player  and also peana majina plus respective cards plus turn number that will help in the game play
        name =Player.new(name,hand,i)
        # now pushing or storing the particular players in memory
        players.push(name)
	    i += 1
    end 
    # topcard= stack.played
    # to show played card
    loop do
        for player in players do
            puts "#{stack.game_status}"
            if (stack.game_status == true ) then
                breaker = true
                return
            else 
               player.play
               if (stack.game_status == true ) then
                breaker = true
                return
               end
            end                    
        end 
        if (breaker==true) then
            break
        end           
    end
    
            
    
#    return puts stack.played
end

gamestart

