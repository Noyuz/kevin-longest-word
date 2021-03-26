class PartiesController < ApplicationController
  def new
    @party = Party.new
    @grid = @party.create_grid
  end

  def create
    @party = Party.new(set_params)
    @party.game = current_user.number_of_parties < 5 ? current_user.game_in_progress : Game.new(user: current_user) #current_user.games.new
    if @party.save
      @party.update(score: @party.word.size)
      redirect_to party_path(@party)
    else
      flash[:notice] = @party.errors.full_messages.to_sentence
      @grid = params[:party][:ten_letters_list]
      render 'new'
    end
  end

  def show
    @party = Party.find(params[:id])
    @game_score = @party.game.score
    @top_ten = Dictionary.top_ten(@party.ten_letters_list)
  end

  private

  def set_params
    params.require(:party).permit(:word, :ten_letters_list)
  end
end


#refacto calcul score d'une game
