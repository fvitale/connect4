class GamesController < ApplicationController

  before_filter :set_up_game

  def show
    set_up_game

    @player = params[:id]
    respond_to { |format| format.html }
  end

  def play
    player = params[:id].to_i
    column = params[:col].to_i

    p "----------------player-turn---------------"
    p player
    p @@turn

    if player == @@turn
      row_played = update_board(player, column)
      if !row_played.nil?
        render json: {row_played: row_played, col_played: column, player_played: player, status: "ok"}
      else
        render json: {status: "error"}
      end
    else
      render json: {message: "not your turn", status: "ok"}
    end

  end

  def get_board
    render json: {board: @@board, turn: @@turn}
  end

  helper_method :turn, :board

  def turn
    @@turn
  end

  def board
    @@board
  end

  private

  def set_up_game
    @@board ||= Game::BOARD
    @@turn ||= 1
  end

  def update_board(player, column)
    played = false
    row_played = nil
    5.downto(0) do |i|
      if @@board[i][column] == 0 && !played
        @@board[i][column] = @@turn
        played = true
        row_played = i
      end
    end
    #TO-DO check if we have a winner here!
    @@turn = (player == 1 ? 2 : 1) if played
    p "New board status"
    p @@board
    row_played
  end
end
