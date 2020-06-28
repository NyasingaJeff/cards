class Card
    attr_accessor :value ,:shape
    # the card is thee most basic and the most important
    def initialize(value, shape)
        # Every card must have a shape and value
        @shape=shape
        @value=value
    end
   def show       
        puts "Value: #{@value} OF Shape:#{@shape} "
   end 
        
end
  