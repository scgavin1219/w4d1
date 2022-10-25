require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    node = TicTacToeNode.new(game.board, mark)
    children = node.children
    node = children.find { |child| child.winning_node?(mark)} 
    return node.prev_move_pos if node
    node = children.find { |child| !child.losing_node?(mark)}
    return node.prev_move_pos if node
    # non_losers = children.select {|child| !child.losing_node?(mark)}
    # return non_losers[0].prev_move_pos unless non_losers.empty?

    raise "could not find a winning move"
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
