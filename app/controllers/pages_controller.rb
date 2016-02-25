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

  def about_game
    @game = Game.find_by(id: params[:game])  
  end

  def add_player
    if user_signed_in? 
      @game = Game.find_by(id: params[:id_game])
      if (@game.users.count)<=9
        @find_user = @game.users.where('user_id = ?', current_user.id)
        if @find_user.count == 0
          if (current_user.balance)<(@game.rate)
            flash[:zero_balance] = "Пополните баланс!"
            redirect_to game_path
          else
            @summa = (current_user.balance)-(@game.rate)
            current_user.update_attribute(:balance, @summa)
            if current_user.errors.empty?
              @game.users.push current_user
              flash[:add] = "Вы зарегистрировались. Удачи!"
            else
              flash[:errors] = "Ошибка обратитесь в службу поддержки"
            end
          end

          if (@game.users.count)==10
            @rand = (rand(1..10))-1
            @winner = User.find_by(id: (@game.user_ids[@rand]))
            @update = @game.update_attribute(:winner, @winner.id)
            @win_mon = ((@game.rate)*10) + (@winner.balance)
            @winner.update_attribute(:balance, @win_mon)
            Game.create(rate: @game.rate)
            UserTransaction.create(user_id: @winner.id, sum: @game.rate, satisfy: true, description: "пополнение с игры")
            redirect_to game_path 
          end
        else
          flash[:not_add] = "Вы уже участвуете."
          redirect_to game_path
        end
      else
        flash[:game_full] = "Повторите попытку позже"
        redirect_to game_path
      end
    else
      redirect_to game_path
    end
  end

  def profile
    if user_signed_in? 
      @played_games = current_user.games.where('user_id = ?', current_user.id)
      @transactions = UserTransaction.where('user_id = ?', current_user.id)
      @games = Game.all 
    end
  end
end
