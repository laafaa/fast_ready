class PagesController < ApplicationController

  before_filter :find_games, :only => [:profile, :game]

  def home
  end

  def game
    @users = User.all
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
          @minus = User.find_by("id = ?", (current_user.id))
          @summa = (current_user.balance)-(@game.rate)
          @minus.update_attribute(:balance, @summa)
          @game.users.push current_user
          flash[:add] = "Vi zaregalis"
        else        
          flash[:not_add] = "Vi uze uchavsvuete"
        end
      end
      if (@game.users.count)==10
        @rand = (rand(1..10))-1
        @winner = User.find_by(id: (@game.user_ids[@rand]))
        @update = @game.update_attribute(:winner, @winner.id)
        @win_mon = ((@game.rate)*10) + (@winner.balance)
        @winner.update_attribute(:balance, @win_mon)
        Game.create(rate: @game.rate)
        redirect_to game_path  
      else
        redirect_to game_path
      end
    end    
  end

  def profile
    @played_games = current_user.games.where('winner = ?', current_user.id)
    #@games.users.where('winner = ?', current_user.id)
    @transactions = UserTransaction.all
  end

  private

    def find_games
      @games = Game.all      
    end

end
