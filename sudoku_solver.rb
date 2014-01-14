require 'nokogiri'
require 'open-uri'
require 'sudoku_board'

class SudokuSolver
  attr_reader :board, :solution, :url

  def self.random_puzzle(level = 1)
    doc = Nokogiri::HTML(open("http://show.websudoku.com/?level=#{level}"))
    puzzle = doc.css("[name='board'] td") \
       .map { |e| e.children.first.attributes["value"] } \
       .map { |e| e ? e.value : 0 } \
       .join
    url = doc.css("[title='Copy link for this puzzle']").first.attributes["href"].value
    new(*[puzzle, url])
  end

  def initialize(string, url = nil)
    @board = SudokuBoard.new(string.chars.map(&:to_i))
    @url = url
  end

  def solve!(&block)
    @board = solve(board) do |board|
      block.call(self.to_s(board)) if block_given?
    end
  end

  def solve(board)
    raise NotImplemented
  end

  def to_s(board = self.board)
    board.to_s +  "\n\n#{board.solved? ? "SOLVED" : "UNSOLVED"}\n#{url}"
  end
end