# Sudoku Solver

This is a sample solution, which demonstrates how to decompose a Sudoku Board
from the various algorithms that solve Sudoku Boards. It uses websudoku.com to
fetch puzzles of varying difficulty to solve.

## Running

```` ruby sudoku.rb [solver] [puzzle] ````

puzzle difficulty – 1-4, this corresponds to Easy, Medium, Hard, and Evil on
websudoku.com's puzzle.

solver – (n)aive or (b)acktracking The "naive" algorithm which relies on the
puzzle only having a single solution. The "backtracking" solution can solve
puzzles with mutliple solutions – here it will find the first solution.

For example, the following will use the backtracking solver to solve a random
Evil puzzle:

```` ruby sudoku.rb b 4 ````

## Notes
1. The solver does a bit too much. E.g. it fetches puzzles from websudoku.com. I
   could make a SudokuFetcher class which would be responsible to fetching
   puzzles from various sources – E.g. the internet, local filesystem, stdin.

