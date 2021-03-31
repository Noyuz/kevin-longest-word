class PartiesController < ApplicationController
  def new
    @party = Party.new
    @grid = @party.create_grid
    set_hints
  end

  def create
    @party = Party.new(set_params)
    @party.game!(current_user)
    if @party.save
      redirect_to party_path(@party)
    else
      flash[:notice] = @party.humanized_error
      @grid = params[:party][:ten_letters_list]
      set_hints
      render :new
    end
  end

  def show
    @party = Party.find(params[:id])
    @parties = @party.game.parties
    @number_of_games = current_user.number_of_games
    @best_score = current_user.best_score
    @game_score = @party.game.score
    @number_of_parties = @party.num_of_parties
    @ten_solutions = @party.solution_words
  end

  private

  def set_hints
    @hint = Dictionary.hint(@grid)
    @hint_word = Dictionary.hint_word(@grid)
    @hint_size = Dictionary.hint_size(@grid)
  end

  def set_params
    params.require(:party).permit(:word, :ten_letters_list, :score)
  end
end
