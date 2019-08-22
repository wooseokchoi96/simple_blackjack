class Player

    attr_reader :hand
    attr_accessor :funds
    
    def initialize
        @hand = []
        @funds
    end

    def hand_value
        sum = 0
        self.hand.each do |card|
            sum += card.value
            if sum > 21
                if card.rank == 'A'
                    sum -= 10
                end
            end
        end
        sum
    end

end