class Sudoku
  attr_reader :board

  def initialize(board)
    @board = board.split('').map { |n| n.to_i }
  end

  def clone
    Sudoku.new @board.join('')
  end

  def check_row(i)
    row_index = i / 9
    cell_start = row_index * 9
    cell_end = cell_start + 9
    @board[cell_start...cell_end]
  end

  def check_col(i)
    col_index = i%9
    column = []
    (0...9).each do |col|
      cell_index = col_index + col * 9
      column << @board[cell_index]
    end
    column
  end

  def check_sq(i)
    col_index = i%9 / 3
    row_index = i / 9 / 3
    # sq_index = col + row * 3
    sq = []
    (0...3).each do |row|
      cell_start = row_index * 27 + row * 9 + col_index * 3
      cell_end = cell_start + 3
      sq << @board[cell_start...cell_end]
    end
    sq
  end

  def solve!(guesses = 1, guess = 0)
    stumped = false

    while !stumped
      stumped = true
      @board.each_with_index do |cell, cell_index|
        if cell == 0
          row = check_row(cell_index)
          col = check_col(cell_index)
          sq = check_sq(cell_index).flatten

          possible = (1..9).to_a - row - col - sq

          if possible.length == guesses
            @board[cell_index] = possible[guess]
            stumped = false
            guesses = 1
            guess = 0
          end
        end
      end
    end

    return "Solved" if solved?
    return guess(guesses + 1) if guesses < 2
    return "Stumped"
  end

  def solved?
    !@board.include? 0
  end

  def guess(guesses)
    # puts "Guessing possibilities of #{guesses}"
    guesses.times do |guess|
      game = clone
      game.solve!(guesses, guess)

      if (game.solved?)
        @board = game.board
        return "Solved"
      end
    end
    return "Stumped"
  end

  def to_s
    board_width = 21
    board_string = '-' * board_width << "\n"
    @board.each_slice(27) do |third|
      third.each_slice(9) do |row|
        row.each_slice(3) do |sec|
          board_string << sec.join(' ') << " | "
        end
        board_string.slice!(-3..-1)
        board_string << "\n"
      end
      board_string << '-' * board_width << "\n"
    end
    board_string
  end
end