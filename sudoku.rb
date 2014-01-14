$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sudoku_solver_naive'
require 'sudoku_solver_backtracker'
require 'screen_utils'

stuff = Hash.new { |h, k| [SudokuSolverNaive, 0.4] }
stuff["b"] = [SudokuSolverBacktracker, 0.00]

solver_class, @sleep_time = stuff[ARGV[0]]
level = ARGV[1] || 1

def print_game(game)
  clear_screen!
  move_to_home!
  reputs game.to_s
  sleep(@sleep_time)
end

# game = solver_class.random_puzzle(level)
game = solver_class.new("0" * 81)
game.solve! do |game|
  print_game(game)
end

print_game(game)
