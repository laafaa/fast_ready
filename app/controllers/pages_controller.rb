class PagesController < ApplicationController

  def home
  end

  def game
    @users = User.all
    @games = (Game.order(:rate)).all  
  end

  def about
  end

  def contact
  end

  def add_player
    @game = Game.find_by(id: params[:id_game])
    if (current_user.balance)<(@game.rate)
      flash[:zero_balance] = "Пополните баланс!"
      redirect_to game_path
    else
      if (@game.users.count)<=9
        @proverka = @game.users.where('user_id = ?', current_user.id)
        if @proverka.count == 0
          @minus = User.find_by("id = ?", (current_user.id))
          @summa = (current_user.balance)-(@game.rate)
          @minus.update_attribute(:balance, @summa)
          @game.users.push current_user
          flash[:add] = "Вы зарегистрировались. Удачи!"
        else        
          flash[:not_add] = "Вы уже участвуете."
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
    @played_games = current_user.games.where('user_id = ?', current_user.id)
    @transactions = UserTransaction.where('user_id = ?', current_user.id)
    @games = Game.all
  end

end
