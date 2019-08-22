# game flow

def welcome
    puts 'Welcome to Blackjack!'
end

def enough_funds?(player)
    if player.funds < 25
        puts 'You do not have enough funds to play.'
        return 'NO'
    end 
end     

def initial_round(player, dealer, deck)
    player_bet(player)
    deal_initial_hand(player, dealer, deck)
    show_initial_hand(player, dealer)
end

def check_blackjacks(player, dealer)
    if blackjack?(player)
        puts 'Since you have a blackjack, the dealer will reveal his full hand.'
        puts "The dealer's full hand is #{show_hand(dealer)} with a value of #{dealer.hand_value}."
        if blackjack?(dealer)
            puts 'The dealer also has a blackjack. Game ends as push.'
            puts "Your new funds: $#{player.funds}."
        else
            puts 'Since the dealer does not have a blackjack, you win.'
            puts 'Since you win with a blackjack, your payout is 1.5 to 1.'     
            player.funds += @player_bet * 1.5
            puts "Your new funds: $#{player.funds}."
        end
        return "YES"
    end
end

def player_turn(player, dealer, deck)
    player_action(player, deck)
end

def dealer_turn(player, dealer, deck)
    if !bust?(player)
        dealer_rules(dealer)
        dealer_action(dealer, deck)
    end 
end

def result(player, dealer, deck)
    if !bust?(player)
        if bust?(dealer)
            puts "The dealer's hand is a bust, so you win."
            player.funds += @player_bet 
            puts "Your new funds: $#{player.funds}."
        elsif player.hand_value < dealer.hand_value
            puts "Your hand is less than the dealer's hand, so you lose."
            player.funds -= @player_bet
            puts "Your new funds: $#{player.funds}." 
        end
        if blackjack?(dealer)
            puts "The dealer has a blackjack, so you lose."
            player.funds -= @player_bet
            puts "Your new funds: $#{player.funds}."
        elsif player.hand_value > dealer.hand_value 
            puts "Your hand is greater than the dealer's hand, so you win."
            player.funds += @player_bet
            puts "Your new funds: $#{player.funds}."
        end 
        if player.hand_value == dealer.hand_value
            puts "Your hand is equal to the dealer's hand. Game is a push."
            puts "Your new funds: $#{player.funds}."
        end 
    end
end

def play_again?(player, dealer)
    while true
        puts 'Would you like to play again? (Please choose a number)'
        puts '1. Yes'
        puts '2. No'
        user_answer = gets.chomp.to_i
        system('clear')
        if user_answer == 1 || user_answer == 2
            break
        else
            puts 'Invalid choice. Please try again.'
        end
    end
    if user_answer == 1
        player.hand.clear
        dealer.hand.clear
    elsif user_answer == 2
        return "NO"
    else
    end
end

def goodbye 
    puts 'Thank you for playing. Goodbye!'
end

# ___________________________________________________________ #

# helpers

def initial_bet(player)
    puts "You currently have $#{player.funds}."
    puts 'Please place a bet:'
    puts 'House minimum and maximum are $25 and $150, respectively.'
end

def player_bet(player)
    while true
        initial_bet(player)
        @player_bet = gets.chomp.to_i
        if @player_bet < 25 || @player_bet > 150 
            system('clear')
            puts 'Invalid bet for this table.'
            puts 'Please try again'
        elsif @player_bet > player.funds
            system('clear')
            puts 'You have insufficient funds.'
            puts 'Please try again'
        else
            break
        end
    end
    system('clear')
    puts "Your initial bet is: $#{@player_bet}."
    @player_bet
end

def deal_initial_hand(player, dealer, deck)
    2.times do
        hit(player, deck)
        hit(dealer, deck)
    end
end 

def show_initial_hand(player, dealer)
    puts "Your hand is: #{show_hand(player)} with a value of #{player.hand_value}."
    puts "The dealer's hand is: #{dealer_visible_hand(dealer)} with a value of #{dealer_visible_hand_value(dealer)}."
end

def dealer_visible_hand(dealer)
    visible_hand = []
    dealer_top_card = dealer.hand[0]
    visible_hand << dealer_top_card.read
    visible_hand << 'Hidden Card'
    visible_hand
end

def dealer_visible_hand_value(dealer)
    dealer_top_card = dealer.hand[0]
    dealer_top_card.value
end

def show_hand(player)
    player.hand.map{|card| card.read}
end

def prompt_player
    puts 'It is your turn.'
    puts 'Please choose an option number: '
    puts '1. Stay'
    puts '2. Hit'
end

def stay_player(player)
    system('clear')
    puts 'You chose to stay.'
    puts "Your hand is: #{show_hand(player)} with a value of #{player.hand_value}."
end

def hit_player(player, deck)
    system('clear')
    puts 'You chose to hit.'
    hit(player, deck)
    puts "Your hand is: #{show_hand(player)} with a value of #{player.hand_value}."
end

def bust_player(player)
    puts 'Your hand is a bust, so you lose the game.'
    player.funds -= @player_bet
    puts "Your new funds: $#{player.funds}."
end

def dealer_rules(dealer)
    system('clear')
    puts "It is now the dealer's turn."
    puts "The dealer will reveal his full hand."
    puts "The dealer's full hand is #{show_hand(dealer)} with a value of #{dealer.hand_value}."
    puts "If the dealer's hand total is 17 or more, then dealer must stand."
    puts "Otherwise, the dealer must hit."
end 

def player_action(player, deck)
    while true
        prompt_player
        player_choice = gets.chomp.to_i
        if player_choice == 2
            hit_player(player, deck)
            if bust?(player)
                bust_player(player)
                break
            end
        elsif player_choice == 1
            stay_player(player)
            break
        else
            system('clear')
            puts 'Invalid choice. Please try again.'
        end  
    end
end

def dealer_action(dealer, deck)
    puts "Please wait for dealer's turn to finish ..."
    while true
        if dealer.hand_value < 17
            hit(dealer, deck)
            if bust?(dealer)
                break
            end
        elsif dealer.hand_value >= 17
            break
        end 
    end
    puts "The dealer's turn is over."
    puts "The dealer's full hand is #{show_hand(dealer)} with a value of #{dealer.hand_value}."
end 

def hit(player, deck)
    player.hand << deck.cards.pop 
end

def bust?(player)
    player.hand_value > 21
end

def blackjack?(player)
    player.hand.length == 2 && player.hand_value == 21
end