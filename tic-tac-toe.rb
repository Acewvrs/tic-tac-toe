class Board
  public
  def get_occupied_positions()
    @occupied_positions
  end

  def place_mark(mark, position)
    #mark: O or X
    #position: where the marks go on board
    @board[position] = mark
  end

  def display()
    for idx in [0,3,6] do  #run three times
      puts "-------------------"
      puts "|  #{@board[idx]}  |  #{@board[idx + 1]}  |  #{@board[idx + 2]}  |"
    end
    puts "-------------------"
  end

  def someone_won?()
    for idx in [0,1,2] do 
      if @board[idx] != ' ' && @board[idx] == @board[idx + 3] && @board[idx] ==  @board[idx + 6] 
        return true 
      end
    end
    for idx in [0,3,6] do 
      if @board[idx] != ' ' && @board[idx] == @board[idx + 1] && @board[idx] == @board[idx + 2] 
        return true 
      end
    end

    if @board[0] != ' ' && @board[0] == @board[4] && @board[0] == @board[8] 
      return true
    end
    if @board[2] != ' ' && @board[2] == @board[4] && @board[2] == @board[6] 
      return true
    end
    
    false
  end

  def ended?() 
    if tie? || someone_won? 
      return true
    end
    false
  end

  def reset()
    @board.fill(' ')
    @occupied_positions.clear()
  end

  private
  def initialize() 
    @board = Array.new(9, ' ')
    @occupied_positions = Array.new(9)
  end

  def tie?()
    for idx in 0..8 do
      if @board[idx] == ' '
        return false
      end
    end
    true
  end
end

playing = true
game_board = Board.new

player_turn = 1

#play game
while(playing) 
  puts "Player #{player_turn}, make your move (press q to quit): "
  
  #take input
  user_move = gets.chomp!
   
  #evaluate user input
  if user_move == 'q' 
    playing = false
  elsif game_board.get_occupied_positions.include?(user_move) 
    #duplicate postions
    game_board.display()
    puts "You can't place there! Try again"
  elsif user_move.to_i >= 1 && user_move.to_i <= 9
    #valid input, update board
    if player_turn == 1
      game_board.place_mark('O', user_move.to_i - 1)
      game_board.get_occupied_positions.push(user_move)
    else
      game_board.place_mark('X', user_move.to_i - 1)
      game_board.get_occupied_positions.push(user_move)
    end
    game_board.display()

    #check for end condition
    if game_board.ended?
        if game_board.someone_won? 
        puts "Player #{player_turn} won!"
        else
        puts "It's a tie!"
        end

        puts "resetting the game. . . "
        game_board.reset()
        game_board.display()
    end

    #swith turns
    if player_turn == 1 
        player_turn = 2
    else 
        player_turn = 1
    end

  else
    #something invalid has been entered by user
    game_board.display()
    puts "Not a valid input. Try again"
  end
end

puts "game ended"