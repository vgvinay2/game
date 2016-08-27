require "game/version"

module Game
  # Your code goes here...



  # Snake and Ladder Game.
# Design and develop game snake and ladders board game. (more details about game: https://en.wikipedia.org/wiki/Snakes_and_Ladders)
# The system should accept input of board size(i.e. number of cells), snakes, ladders, dice-value  and users
# Read inputs from standard input.
# Implement the above game in ruby language
# Provide proper instructions to run the game.
# Use proper data structure. 
# Snakes_N_Ladders_Game  final solution 

class Snakes_N_Ladders_Game
  #instence creation time set value for player dice snakes ladders and board size
  def initialize(players,dice,snakes, ladders, board_size=100)
    @players = players
    @board_size = board_size
    @snakes_ladders = random_board(snakes,ladders, board_size)#get snake and ladder in hash format and based on movement will happen
    @dice = dice
  end
  
  # after create instance call this method to get winner name
  def play
  	 #p "Game started with #{@players}  --------"
     players_starting_positions = @players.map{0} #empty array basedon user  
     starting_player = rand(@players.length) # 0,1,2
     winner = move(players_starting_positions, starting_player)
     puts "Game started between these #{@players} players  ----and---- #{@players[winner]} is winner!"
   end

   private
   # get dynammic dice value it can be any thing between 1 to 6 in my case no limit of dice also
   def throw_dice dice
     dice = dice.to_i
     return 1 + rand(dice)
   end

# key method if problem how player will move and get value to move to know how its working check move method and uncommentfallowing line
   def move(players, player_turn)
     #p players 
     #p  player_turn 
     #p "-----------------"
     p "#{@snakes_ladders} i am Combination of snakes and ladders !:)"
     new_position = players[player_turn] + throw_dice(@dice)
     #p "__#{new_position}___"
     new_position = @snakes_ladders[new_position] if @snakes_ladders.has_key?(new_position)
     return player_turn if new_position >= @board_size 
     players[player_turn] = new_position
     next_player = (player_turn + 1) % players.length
     move(players, next_player)
   end

 # set sanake and ladder in hash format so that based on movement will happen  while creating instance!!
   def random_board(snakes,ladders, board_size)
    snakes = snakes.to_i
    ladders = ladders.to_i
    get_max = snakes + ladders # ? snakes : ladders 
    snakes_ladders = {}
    my_hash = {}
    until snakes_ladders.count == get_max
      new_ele = snake_or_ladder(board_size)
      get = new_ele.inject(0){|sum,key| sum = sum+key.inject(:-)} > 0 ? "snakes" : "ladders" 
      global_ladder_snake = get=="snakes" ? snakes : ladders
      if (my_hash[get].to_s.to_sym <= get.to_sym )&& ( (my_hash[get].nil? ? 0 : my_hash[get] ) < global_ladder_snake )
         snakes_ladders = snakes_ladders.merge(new_ele)
         get_snake_ladder(snakes_ladders,my_hash)
      end 
      p my_hash
    end
    snakes_ladders
  end

  #set snake and ladder in hash format
  def snake_or_ladder(board_size)
  	start = random_cell_value(board_size)
    ending = random_cell_value(board_size)
    return {start=>ending} unless start == ending
    snake_or_ladder(board_size) 
  end

#adding one becouse in some case rand will give 0
  def random_cell_value(board_size)
    1 + rand(board_size - 1)
  end

#get how  many snake and ladder in our game
  def get_snake_ladder(snakes_ladders,my_hash)
    my_hash["snakes"]  = snakes_ladders.inject([]){|k,v| k << (v[0]-v[-1])}.select {|x| x > 0}.count
    my_hash["ladders"] = snakes_ladders.inject([]){|k,v| k << (v[0]-v[-1])}.select {|x| x < 0}.count
    return my_hash
  end
end

players = ["Tiger", "Jhon"]    
                                # players,dice,snakes, ladders, board_size=100)
easy_game = Snakes_N_Ladders_Game.new(players,6,2,3,50)
easy_game.play
end
