class Deck

    attr_reader :cards

    def initialize
        @cards = []
        @suits = ['♦', '♣', '♥', '♠']
        @ranks = [*('2'..'10'), 'J', 'Q', 'K', 'A']
        @suits.each do |suit|
            @ranks.each do |rank|
                @cards << Card.new(suit, rank)
            end
        end
        @cards.shuffle!
    end

end