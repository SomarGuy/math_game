require_relative 'player'
require_relative 'question'
require_relative 'game_io'

class Game
  def initialize
    @player1 = Player.new("Player 1")
    @player2 = Player.new("Player 2")
    @current_player = @player1
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def display_scores
    GameIO.display("P1: #{@player1.lives}/3 vs P2: #{@player2.lives}/3")
  end

  def game_over?
    @player1.lives.zero? || @player2.lives.zero?
  end

  def play
    until game_over?
      question = Question.new
      GameIO.display("#{@current_player.name}: #{question}")

      answer = GameIO.get_input.to_i

      if answer == question.answer
        GameIO.display("#{@current_player.name}: YES! You are correct.")
      else
        GameIO.display("#{@current_player.name}: Seriously? No!")
        @current_player.lose_life
      end

      unless game_over?
        display_scores
        GameIO.display("----- NEW TURN -----")
        switch_player
      end
    end

    winner = @player1.lives.positive? ? @player1 : @player2
    GameIO.display("#{winner.name} wins with a score of #{winner.lives}/3")
    GameIO.display("------ GAME OVER ------")
    GameIO.display("Good bye!")
  end
end
