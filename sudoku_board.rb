class SudokuBoard
  attr_reader :board

  POSSIBLE_CELL_VALUES = (1..9).to_a.freeze

  def initialize(board)
    @board = board.dup
  end

  def initialize_copy(source)
    super
    @board = source.board.dup
  end

  def fill_in(index, value)
    self.dup.tap do |new_board|
      new_board.fill_in!(index, value)
    end
  end

  def fill_in!(index, value)
    board[index] = value
  end

  def solved?
    board.none? { |i| i == 0 }
  end

  def valid?
    empty_cells.none? do |cell|
      possibilities_for_cell(cell).empty?
    end
  end

  def to_s
    board.map{|e| e == 0 ? " " : e }.each_slice(9).map do |row|
      row.each_slice(3).map { |s| s.join(" ") }.join(" | ")
    end.each_slice(3).map { |s| s.join("\n") }.join("\n------+-------+------\n")
  end

  def first_empty_cell
    # empty_cells.first
    empty_cells.min_by { |cell| possibilities_for_cell(cell).length }
  end

  def empty_cells
    board.each_with_index \
         .select { |e, _| e == 0 } \
         .map    { |_, i| i }
  end

  def possibilities_for_cell(index)
    naive_possibilities = naive_possibilities_for_cell(index)
    row_possibilities = naive_possibilities - possibilities_for_cells(row_peers(index))
    box_possibilities = naive_possibilities - possibilities_for_cells(box_peers(index))
    col_possibilities = naive_possibilities - possibilities_for_cells(col_peers(index))

    if row_possibilities.length == 1
      row_possibilities
    elsif col_possibilities.length == 1
      col_possibilities
    elsif box_possibilities.length == 1
      box_possibilities
    else
      naive_possibilities
    end
  end

  def possibilities_for_cells(*cells)
    cells.map { |cell| naive_possibilities_for_cell(cell) }.reduce(&:+)
  end

  def naive_possibilities_for_cell(index)
    empty_cells.include?(index) ? POSSIBLE_CELL_VALUES - (row(index) + col(index) +  box(index)) : []
  end

  def row(index)
    board.each_slice(9).to_a[row_index(index)]
  end

  def col(index)
    board.each_slice(9).to_a.transpose[col_index(index)]
  end

  def box(index)
    box_index = box_index(index)
    board.each_with_index \
         .select { |e, cell_index| box_index == box_index(cell_index) } \
         .map    { |e, _| e }
  end

  def row_index(index)
    (index / 9)
  end

  def col_index(index)
    index % 9
  end

  def box_index(index)
    3 * (row_index(index)/3) + (col_index(index)/3)
  end

  def row_peers(index)
    row_index = row_index(index)
    all_indexes.select { |i| row_index(i) == row_index } - [index]
  end

  def col_peers(index)
    col_index = col_index(index)
    all_indexes.select { |i| col_index(i) == col_index } - [index]
  end

  def box_peers(index)
    box_index = box_index(index)
    all_indexes.select { |i| box_index(i) == box_index } - [index]
  end

  def all_indexes
    (0..80).to_a
  end
end
