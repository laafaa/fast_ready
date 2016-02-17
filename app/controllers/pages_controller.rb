class PagesController < ApplicationController

  #skip_before_filter :verify_authenticity_token, :only => [:proverka]

  def home
  end

  def game
  	@games = Game.all
  end

  def about
  end

  def contact
  end

  def add_player
    @game = Game.find_by(id: params[:id_game])
    if (current_user.balance)<(@game.rate)
      flash[:zero_balance] = "Popolnite balans"
      redirect_to game_path
    else
      if (@game.users.count)<=9
        @proverka = @game.users.where('user_id = ?', current_user.id)
        if @proverka.count == 0
          @game.users.push current_user
          flash[:add] = "Vi zaregalis"
        else        
          flash[:not_add] = "Vi uze uchavsvuete"
        end
      end
      if (@game.users.count)==10
        @rand = (rand(1..10))-1
        @winner = User.find_by(id: (@game.user_ids[@rand]))
        @update = @game.update_attributes(winner: @winner.login)
        @winner.update_attributes(balance: (@game.rate)*10)
        Game.create(rate: @game.rate)
        redirect_to game_path  
      else
        redirect_to game_path
      end
    end    
  end

  def profile
  	@user = User.all
  end

  #private
  #  def add_player_params
  #    params.require[].permit[:id]      
  #  end
end
