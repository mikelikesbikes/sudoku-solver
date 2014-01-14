require 'sudoku_solver'

class SudokuSolverNaive < SudokuSolver
  # takes a board as input, and solves that board,
  # returning a new board that represents the solution attempt
  def solve(board)
    board = board.dup

    until board.solved?
      yield board if block_given?

      modified = false
      board.empty_cells.each { |cell|
        possibilities = board.possibilities_for_cell(cell)
        if possibilities.length == 1
          board.fill_in!(cell, possibilities.first)
          modified = true
        end
      }

      break unless modified
    end

    board
  end
end
