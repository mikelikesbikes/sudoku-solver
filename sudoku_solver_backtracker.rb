require 'sudoku_solver'

class SudokuSolverBacktracker < SudokuSolver
  def solve(board, &block)
    yield board if block_given?

    return board if board.solved?
    return nil unless board.valid?

    cell = board.first_empty_cell

    board.possibilities_for_cell(cell).shuffle.each do |possibility|
      solution = solve(board.fill_in(cell, possibility), &block)
      return solution unless solution.nil?
    end

    return nil
  end
end
