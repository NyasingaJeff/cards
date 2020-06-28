require_relative 'playinstack'
class Player < PlayinStack
    attr_accessor :name,:hand, :turn_number
    def initialize(name, hand,turn)
       @name=name   
       @hand=hand
       @turn_number= turn
       @@handcount << @hand.length
       @@yelpers << 0
    end 
     
    def showhand
        index = 0          
       for card in @hand do 
            index += 1
           puts "Card number: #{index.to_s}:" 
           puts "#{card.show}"         
       end
    end
    def cardchecker(input)
        
        input=input.to_f 
        
        if input < 1.0 ||  @hand[input - 1] == nil
            puts "!!!!!!!!!!_------------------invalid input-------------------------!!!!!!!!!!!!!!!!! "
            self.play
        else
        card = @hand[input - 1]
        return card
        end
    end
    def yelper_not
        @@yelpers[@turn_number] = 0         
    end
    def yelper
        specials= ["King","Queen","Jump","A",8,2,3]
        if specials.include?(@hand[0].value) == false
            puts "Tumeona uko Kardi.... Tuite.. Press enter to sema!!! 'KARDIIII'?"
            input = gets.chomp()
            if input == ""
                @@yelpers[@turn_number] = 1
                puts "#{self.name} ako kardi"                
            else
                # siko kardi
                puts "Haujaita..."
                nextplayer()
            end
        else
            nextplayer()
        end                      
    end
    def nextplayer
        # we will chek if it will realy save the changes
        $preveouscount = @@handcount.clone
        $game_status = @@game_status.clone
        return 
    end
  
    def a_played(card)
        puts "itisha: H :: Hearts , C :: Clubs, S :: Spades, D :: Dias"
        called= gets.chomp().capitalize
        case called
        when "H"
            a_changer(1,"Hearts")
            place(card)
            
        when "C"
            a_changer(1,"Clubs")
            place(card)
            
        when "S"
            a_changer(1,"Spades")
            place(card)
            
        when "D"
            a_changer(1,"Dias")
            place(card)
            
        else
            puts "inavalid input....."
            self.play
        end
        
        
    end
    def j_played(card)
        changer(1,1)
        place(card)
                
    end
    def twoOrthree_played(card)
        changer(2,1)
        place(card)
                
    end

    #this funcing finction id no saving the 
    def question_played(card)
        place(card)
        puts "          -----------==========Play again=========---------------------- "
        puts "          -----------==========#{self.name.capitalize} Play again #{@@played[-1].value} of #{@@played[-1].shape} is on top =========---------------------- "
        self.showhand
        puts "          -----------=========we gonna need that answer============---------"
        input = gets.chomp()
        if input == ""
            self.pick(1)
        else
            answer = cardchecker(input)
            lowercard(answer)
            puts "#{self.name} has answered with ---===  #{answer.value} OF #{answer.shape} ===---   "
            nextplayer()
        end
    end
    def lowercard (card) 
        puts "You have Selected #{card.value} of #{card.shape} enter any key to canel or enter to proced"
        input= gets.chomp()
        if input == ""
         pokerchecker(card)                              
        else
         self.play
        end
    end
    def pokerchecker (card)
        if card.value == @@played[@@played.length-1].value        
            confirmedlower(card)
        elsif card.shape == @@played[@@played.length-1].shape
            confirmedlower(card)
        elsif card.value == "A"
            confirmedlower(card)
        else
            puts "Nice try pewa tano "
            self.pick(5)
            nextplayer()         
        end       
    end
    def confirmedlower(card)
        if card.value == "A"
            a_played(card)
        elsif card.value == "Queen"
           question_played(card)
        elsif card.value == 8
            question_played(card)
        elsif card.value == "Jump"
            j_played(card)
        elsif card.value ==2  
            twoOrthree_played(card)
        elsif card.value == 3
            twoOrthree_played(card)                     
        else
        place(card)
        
        end       
    end
    def place(card)
        @@played << card 
        @hand.delete(card)
        alter_hand()
        finisher()
        broker()
        nextplayer()
    end
    def alter_hand
         @@handcount[@turn_number] = @hand.length
         
    end
    def hand
        return @@handcount[@turn_number]
    end
    def pick(x)
        x.to_i
        pick= @@stack.pop(x)
        for card in pick do
            @hand << card
            alter_hand()
            broker()
        end
        puts "Cards Picked:"
        for kard in pick do
          print "#{kard.value} Of #{kard.shape}"  
        end
            
    end
    # how ton finish a game kama A imitwa
   
    # shida iko apa
    def finisher
        if @@yelpers[@turn_number] == 1 && @hand.length == 0            
          if  $preveouscount.include?(0) == true
            yelper_not()
            puts "kuna Msee hana cardi... Haitaisha leo"
            nextplayer()
          else
            @@game_status = 1
              puts " Enter any key to finish ..."
              
                 
                  puts "                Congrats #{@name}                   "
                  puts 
                  puts
                  puts "The Wining card is... #{@@played[-1].value} of #{@@played[-1].shape}"
                  puts 
                  puts
                  puts "-----------------------------------------------------"
                  input = gets.chomp()
                #   indicate the game is over
                  @@game_status = 1
                #   nextplayer()
                win()
            
          end
        else
            yelper_not()
        end    
    end
    def broker
        if @hand.length ==1
            yelper()
        else
            nextplayer()
        end
    end
    # to chek if the game is oveer
    
   
    def play     
        puts "------------=================showing  #{hand()}    cards==========================--------------------------"
        # we chek  the player was jumped or Lishwad ,, i may...
        if a_checker() == true #atesst
            puts "                          -----#{self.name}'s turn    ----------------          '"
            puts "........#{@@status[0][1]} is the legal shape.....play or enter..... "
            self.showhand
            input= gets.chomp()
            if input == ""
                self.pick(1)
                                                    
            else
                input.to_i
                card = cardchecker(input) #compare called card ana ile anpea
                if card.value == "A" #akiangusha A pia 
                    a_played(card) 
                    
                elsif  card.shape ==  @@status[0][1]
                    a_changer(0,nil) 
                    confirmedlower(card)                                 
                else          
                   puts "Poker!!"
                   self.pick(5)
                end 
            end
        elsif checker(1) == true #jumptest
            puts "------#{@name.capitalize}----------------------Umerukwa -------------------------------"
            self.showhand
            puts '-----------select the Appropriate card------ or Press Enter------------------------'
            input = gets.chomp()
            if input == ""
                changer(1,0)                
            else
                input.to_i
                # get the card
                card=cardchecker(input)
                if card.value == "Jump"
                    j_played(card)
                     
                else
                    puts "Poker"
                    self.pick(5)
                    changer(1,0)
                    
                end  
            end
        elsif checker(2) == true#picktest
            puts "------#{@name.capitalize}----------------------Umelishwa -------------------------------"
            self.showhand
            puts '-----------select the Appropriate card------ or Press Enter------------------------'
            input= gets.chomp()
            if input == ""
                changer(2,0)
                self.pick( @@played[-1].value)          
            else
                input.to_i
                card=cardchecker(input)
                if card.value == @@played[-1].value
                   lowercard(card)
                elsif card.value == "A"
                    changer(2,0)
                    place(card)
                    
                else 
                 puts "Poker!! Pewa zako "
                 self.pick(@@played[-1].value+5)
                 changer(2,0)
                 
                end            
            end 
        else 
            
            puts "-------------------------Top-------------------------------------------------"
            puts "                          #{@@played[-1].value} OF #{@@played[-1].shape.capitalize}                                             " 
            puts "-----------------------------------------------------------------------------"           
            puts "-----------------------#{@name}'s Turn ------------------------------"    # first the player checks out hand
            self.showhand
            puts "===============================Please select the card to play OR Enter to pick=========================================="
            # get the input from the user
            input = gets.chomp().capitalize
            # chek kama aliamiua kupik
            if input == "" #not equal to p 
                    puts "You have resorted to pick .. press any button to cancell.. enter to procceed"
                    input2=gets.chomp()
                    if input2 == ""
                       self.pick(1)
                       puts "------------------#{@name} HAS PICKED A CARD ..............................."
                       
                    else
                        self.play
                    end              
                             
            else                    
                # chek  the input  validty .. ie  card exists under that index-1  not throw invalid input and try again
                input=input.to_i
                card = cardchecker(input) 
                lowercard(card)            
            end
              
        end                     
    end
    def win
         puts "#{@name} has won the game!!!!!!"
         @@game_status = 1
         return
    end
        
end
