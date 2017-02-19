require './connect_four.rb'

connectfour = ConnectFour.new

       puts "Connect 4 Game"
	   puts "To win: connect 4 tokens in a row, column, or diagonally"
	   print "Enter player 1's name: "
	   connectfour.players[0].set_name(gets.chomp)
	   #connectfour.set_player1_name(gets.chomp)
	   print "\nEnter player 2's name: "
	   connectfour.players[1].set_name(gets.chomp)

	   i = 0
	   while(connectfour.vacancy?)
	   	 connectfour.display_board
	   	 column = connectfour.get_player_move(i)
	   	 connectfour.enterValue(column,connectfour.players[i].token)
	   	 if connectfour.gameOver?
	   	 	puts "\n    #{connectfour.players[i].username} WINS!"
	   	 	connectfour.display_board
	   	 	exit
	   	 end
	   	 i == 0 ?  (i = 1) : (i = 0)
	   end
       puts "\n    It's a Draw!"
       connectfour.display_board


      #make sure to refactor player code and to reask players for valid input.
      #valid? column is full, value not in range 0 to 6

