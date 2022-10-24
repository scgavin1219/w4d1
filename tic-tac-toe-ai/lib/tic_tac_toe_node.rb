require_relative 'tic_tac_toe'
require 'byebug'
class TicTacToeNode
  attr_reader :board, :next_mover_mark, :child_nodes, :prev_move_pos

  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
    @child_nodes = []
  end


  def losing_node?(evaluator)
    # debugger
    if @board.over?
      winner = @board.winner
      return false if winner.nil?
      return false if winner == evaluator
      return true
    else
      our_turn = evaluator == @next_mover_mark
      if our_turn
        return self.children.all? { |node| node.losing_node?(evaluator) }
      else
        return self.children.any? { |node| node.losing_node?(evaluator) }
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      winner = @board.winner
      return true if winner == evaluator
      return false
    else
      our_turn = evaluator == @next_mover_mark
      if our_turn
        return self.children.any? {|node| node.winning_node?(evaluator)}
      else
        return self.children.all? {|node| node.winning_node?(evaluator)}
      end
    end
  end
  
  def swap_mark(mark)
    mark == :x ? :o : :x
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    (0...3).each do |row|
      (0...3).each do |col|
        if @board.empty?([row,col])
          new_board = @board.dup
          new_board[[row,col]] = @next_mover_mark
          @prev_move_pos = [row,col]
          new_mover_mark = swap_mark(@next_mover_mark)
          new_node = TicTacToeNode.new(new_board, new_mover_mark, @prev_move_pos)
          @child_nodes << new_node
        end
      end
    end
    return @child_nodes
  end


end
