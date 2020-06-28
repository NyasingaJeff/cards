require_relative 'card'
class PlayinStack < Card
       
    def initialize
        @@status=[[0,nil],0,0]
        @@game_status = 0
        @@playedturns=0
        @@handcount = Array.new
        @@stack = Array.new
        @@played=Array.new
        @@yelpers = Array.new
        shapes= ["Spades","Dias","Clubs","Hearts"]
        specials= ["King","Queen","Jump","A",8]
        #to make the regular cards 
        # make the playable cards
        for shape in shapes do
            i=4
            while i < 8
                card=i.to_s+shape
                card = Card.new(i,shape) 
                @@stack.push(card)               
                i+=1
            end 
            i=9
            while i < 12
                card=i.to_s+shape
                card = Card.new(i,shape) 
                @@stack.push(card)               
                i+=1
            end           
        end
        first = @@stack.sample
        @@played.push(first)
        @@stack.delete(first)
        # make the special cards 
        for shape in shapes do   
            i=2
            while i < 4
                card=i.to_s+shape
                card = Card.new(i,shape) 
                @@stack.push(card)               
                i+=1
            end
           
            
            for special in specials do
                card= Card.new(special,shape)
                @@stack.push(card)
            end
            
        end
        @@stack=@@stack.shuffle  
    end
    # to see last played card / top card  
    def played
        #  @@played.inspect
        index = @@played.length        
        puts @@played[index-1].show              
    end
    
    
    def distribute         
        a= @@stack.pop(2)  
         a
    end
    # to se the full stack
    def stackshow
        puts "#{@@stack.length} cards remaining"
        for card in @@stack do
            card.show
        end
    end
    
    def a_changer(status,shape)
        @@status[0][0]=status
        @@status[0][1]=shape
    end
    def a_checker
        if @@status[0][0] == 1
            return true
        else
            return false
        end
    end
    def checker(index)
        if @@status[index] ==1
            return true
        else
            return false
        end
    end
    def changer(index,value)
        @@status[index]=value
    end
    def game_status
        if $game_status == 1
            return true
        else
            return false
        end
    end
end
