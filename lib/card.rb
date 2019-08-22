class Card

    attr_reader :suit, :rank

    VALUES = {'2'=>2,'3'=>3,'4'=>4,'5'=>5,'6'=>6,
                '7'=>7,'8'=>8,'9'=>9,'10'=>10,
                'J'=>10,'Q'=>10,'K'=>10,'A'=>11}

    def initialize(suit, rank)
        @suit = suit
        @rank = rank
    end

    def read
        "#{self.rank} of #{self.suit}"
    end

    def value
        VALUES[self.rank] 
    end

end