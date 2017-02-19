require './player.rb'

class ConnectFour
 attr_reader :board, :curr_location, :numOfTurns
 attr_accessor :players
 def initialize
 	@board = Array.new(7){Array.new(7,"\u25A0")}
 	@players = []
    @players << Player.new("\u263A")
    @players << Player.new("\u263B")
    @numOfTurns = 42
 	fill_row_0
 end
 
 def fill_row_0
 	7.times { |i| @board[0][i] = i}
 end
 
 def enterValue(col, token)
 	6.downto(1) do |i|
 	  if @board[i][col] == "\u25A0" #default value,empty
        @board[i][col] = token
        @curr_location = [i,col]
        @numOfTurns-=1
        break
 	  end
 	end
 end
 
 def gameOver?
 	#check for winner
    return true if vertical_win? || horizontal_win? || diagonal_win?
    false
 end
 
 def display_board
    7.times do |row|
       print "\n #{@board[row].join(" ")}"
    end
    print "\n"
 end

	def vacancy?
		 return true if @numOfTurns>0
		 false
	 end

	def get_player_move(i)
	  puts "#{@players[i].username}'s turn #{@players[i].token} :"
	  n = 100
	  while(n>0)
	    input = gets.chomp
	    if input.length == 1
	       m = /[0-6]/.match(input)
	       return m[0].to_i if !m.nil? && vacant?(m[0].to_i)
	    end
	    n-=1
	  end
    end

  private
  
    def vacant?(col)
	    return true if @board[1][col] == "\u25A0"
	    false
    end

	 def diagonal_win?
		   return true if upward_diagonal_win? || downward_diagonal_win?
		   false
	 end
 
	 def upward_diagonal_win?
		  purse = 1
		  row = @curr_location.first
		  col = @curr_location.last
		  token = @board[row][col]
		  #upward ; right side of current token
		  1.upto(3) do |i|
		  	break if (row-i)<1 || (col+1) >6
		  	@board[row-i][col+i] == token ? (purse+=1) : break
		  end
		  
		  return true if purse == 4
		  #upward ; left side of current token
		  1.upto(3) do |i|
		  	break if (row+i)>6 || (col-i)<0
		  	@board[row+i][col-i] == token ? (purse+=1) : break
		  end
		  return true if purse >=4
		  #checked whole upward diagonal
		  false
	 end

	 def downward_diagonal_win?
		  purse = 1
		  row = @curr_location.first
		  col = @curr_location.last
		  token = @board[row][col]
		  #downward ; right side of current token
		  1.upto(3) do |i|
		  	break if (row+i)>6 || (col+1) >6
		  	@board[row+i][col+i] == token ? (purse+=1) : break
		  end
		  
		  return true if purse == 4
		  #upward ; left side of current token
		  1.upto(3) do |i|
		  	break if (row-i)<1 || (col-i)<0
		  	@board[row-i][col-i] == token ? (purse+=1) : break
		  end
		  return true if purse >=4
		  #checked whole upward diagonal
		  false
	 end

	 def vertical_win?
		   #vertical
		   purse = 1
		   #extract coordinates of current location
		   row = @curr_location.first
		   col = @curr_location.last
		   token = @board[row][col]
		   #walk the board and collect
		   3.times do 
		   	  break if (row+1) > 6
		      purse+=1 if @board[row+1][col] == token
		      row+=1
		   end
		   return true if purse == 4
		   false
	 end

	 def horizontal_win?
		 	purse = 1
		 	row = @curr_location.first
		 	col = @curr_location.last
		 	token = @board[row][col]
		 	#check left side first; 
		 	1.upto(3) do |i| 
		 	  break if (col-i) < 0
		 	  @board[row][col-i] == token ? (purse+=1) : break #different token is met
		 	end
		 	return true if purse == 4
		 	#check right side
		    1.upto(3) do |i|
		    	break if (col+i) > 6
		    	@board[row][col+i] == token ? (purse+=1) : break#different token is met
		    end
		    return true if purse >=4
		    false
	 end

     



end
 