require 'pry'

require 'require_all'
require_all 'lib'

# creating player and dealer
player = Player.new
player.funds = 100
dealer = Player.new

system('clear')

welcome

# play a game with a new deck each time
while true
    deck = Deck.new
    break if enough_funds?(player) == 'NO'
    initial_round(player, dealer, deck)
    if check_blackjacks(player, dealer) == 'YES'
        break if play_again?(player, dealer) == 'NO'
    else
        player_turn(player, dealer, deck)
        dealer_turn(player, dealer, deck)
        result(player, dealer, deck)
        break if play_again?(player, dealer) == 'NO'
    end
end

goodbye