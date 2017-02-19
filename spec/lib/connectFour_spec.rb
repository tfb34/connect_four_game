require './connect_four'

describe ConnectFour do

  let(:connectfour) {ConnectFour.new}

  it "can initialize a ConnectFour game" do
  	expect(connectfour).to be_a(ConnectFour)
  end
  it "initializes 'board' attribute" do
     expect(connectfour.board).to be_a(Array)
  end
  it "initializes 'player' atributes" do
  	expect(connectfour.players).to be_a(Array)
  end
  it "read access to coordinates of current location" do
  	expect{connectfour.curr_location = [3,4]}.to raise_error NoMethodError
  end

  context 'when building board' do
	  it "number of rows in board" do
	  	 expect(connectfour.board.length).to eq(7)
	  end
	  it "number of columns in board" do
	  	expect(connectfour.board[0].length).to eq(7)
	  end
	  it "cells in row 0" do
	  	value = connectfour.board[0].join
	  	expect(value).to eq("0123456")
	  end
	  it "Initially all cells in board " do
	  	expect(connectfour.board[3][5]).to eq("\u25A0")
	  end
   end

  describe '#gameOver?' do
	  	context "when there's a winner" do
	  		context ",vertical_win" do
	           it "connect 4 starting from base of board" do
			  	4.times {connectfour.enterValue(3,"\u263B")}
			    expect(connectfour.gameOver?).to be true
			  end
			  it "connect four on top of other player's token" do
			  	connectfour.enterValue(3,"\u263A")
			  	4.times {connectfour.enterValue(3,"\u263B")}
			  	expect(connectfour.gameOver?).to be true
			  end
	  		end
	  		context ",horizontal_win" do
		       it "connect four with last token placed far right" do
		          4.times { |i| connectfour.enterValue(i,"\u263A")}
		          expect(connectfour.gameOver?).to be true
		       end
		       it "connect four with last token placed far left" do
		           3.downto(0) {|i| connectfour.enterValue(i,"\u263A")}
		           expect(connectfour.gameOver?).to be true
		       end
		       it "connect four with last token placed in middle" do
		       	   1.upto(4) {|i| connectfour.enterValue(i,"\u263A") if i!=3}
		       	   connectfour.enterValue(3,"\u263A")
		       	   expect(connectfour.gameOver?).to be true
		       end
	  		end
	  		context "when diagonal_win" do
	 			context "that's upward," do
		 		    it "right side of current token" do
			   			n=1
			   			 3.upto(5) do |col| 
			   			  	n.times {connectfour.enterValue(col,"\u263A")}
			   			  	connectfour.enterValue(col,"\u263B")
			   			  	n+=1
			   			 end
		                connectfour.enterValue(2,"\u263B")
			   			expect(connectfour.gameOver?).to be true
			   		end
			   		it "left side of current token" do
			   			n=1
			   			connectfour.enterValue(2,"\u263B")
			   			 3.upto(5) do |col| 
			   			  	n.times {connectfour.enterValue(col,"\u263A")}
			   			  	connectfour.enterValue(col,"\u263B")
			   			  	n+=1
			   			 end
			   			expect(connectfour.gameOver?).to be true
			   		end
			   		it "token in middle of connect four" do
			   			n=0
			   			2.upto(5) do |col| 
			   			  n.times {connectfour.enterValue(col,"\u263A")}
			   			  connectfour.enterValue(col,"\u263B") if col!=4
			   			  n+=1
			   			 end
			   			 connectfour.enterValue(4,"\u263B")
			   			expect(connectfour.gameOver?).to be true
			   		end
	 			end
	 			context "that's downward," do
		               it 'connect four with winning token placed far right' do
			    		n=3
			            2.upto(4) do |col|
			           	 n.times{connectfour.enterValue(col,"\u263A")}
			           	 connectfour.enterValue(col,"\u263B")
			           	 n-=1
			           end
			           connectfour.enterValue(5,"\u263B")
			           expect(connectfour.gameOver?).to be true

			    	   end
			    	  it 'connect four with winning token placed far left' do
			           n=3
			           2.upto(4) do |col|
			           	 n.times{connectfour.enterValue(col,"\u263A")}
			           	 n-=1
			           end
			           connectfour.enterValue(3,"\u263B")
			           connectfour.enterValue(4,"\u263B")
			           connectfour.enterValue(5,"\u263B")
			           connectfour.enterValue(2,"\u263B")
			           expect(connectfour.gameOver?).to be true
			    	   end
			    	  it 'connect four with winning token placed in middle' do
			           n=3
			           2.upto(4) do |col|
			           	 n.times{connectfour.enterValue(col,"\u263A")}
			           	 n-=1
			           end
			           connectfour.enterValue(2,"\u263B")
			           connectfour.enterValue(4,"\u263B")
			           connectfour.enterValue(5,"\u263B")
			           connectfour.enterValue(3,"\u263B")
			           expect(connectfour.gameOver?).to be true

			    	  end        
	 			end
	  		end
	  	end
	    context "when no winner ;" do
	         it "no horizontal win with token wedged between different tokens" do
		       	 2.upto(4){|col| connectfour.enterValue(col,"\u263A") if col!=3}
		       	 connectfour.enterValue(3,"\u263B")
		       	 expect(connectfour.gameOver?).to be false
		     end	
		     it "no horizontal win with connect 3" do
		       	 3.times {|col| connectfour.enterValue(col,"\u263A")}
		       	 expect(connectfour.gameOver?).to be false
		     end
		     context "when no diagonal_win" do
		     	context 'upward' do
		   		    it "no win-bottom right corner " do
		   			connectfour.enterValue(6,"\u263A")
		   			expect(connectfour.gameOver?).to be false
		   		    end
		   		    it "no connect four" do
		   		    	n=0
		   		    	1.upto(4) do |col|
		   		    		n.times {connectfour.enterValue(col,"\u263A")}
	                        connectfour.enterValue(col,"\u263B") if col!=3
	                        n+=1
		   		    	end
		   		    	connectfour.enterValue(3,"\u263A")
		   		    	expect(connectfour.gameOver?).to be false
		   		    end
		     	end
	            context 'downward' do
					it 'one token bottom left corner' do
			    		connectfour.enterValue(0,"\u263A")
			    		expect(connectfour.gameOver?).to be false
			    	end
			    	it 'no connect four' do
			    		n=3
			           2.upto(4) do |col|
			           	 n.times{connectfour.enterValue(col,"\u263A")}
			           	 connectfour.enterValue(col,"\u263B") if col!=4
			           	 n-=1
			           end
			           connectfour.enterValue(4,"\u263A")
			           expect(connectfour.gameOver?).to be false
			    	end
	            end
		     end
	    end
	    
  end
  
  describe '#curr_location' do
	  it "entering token in unoccupied column" do
	  	 connectfour.enterValue(3,"\u263A")
	  	 expect(connectfour.curr_location).to eq([6,3])
	  end
	  it "entering token in occupied column" do
	  	connectfour.enterValue(3,"\u263A")
	  	connectfour.enterValue(3,"\u263B")
	  	expect(connectfour.curr_location).to eq([5,3])
	  end
  end


  
end
