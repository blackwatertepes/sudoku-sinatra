get '/' do
  erb :index
end

post '/' do
  @board = solve params[:sudoku]
  erb :index
end

post '/js' do
  content_type :json
  p solve(params[:sudoku]).to_json
end

helpers do
  def solve(board)
    board = board.values.map { |row| row.values.map { |cell| cell == "" ? '0' : cell } }.flatten.join
    sudoku = Sudoku.new(board)
    sudoku.solve!
    sudoku.board
  end
end