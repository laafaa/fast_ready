class PagesController < ApplicationController
  def home
  end

  def game
  	@games = Game.all
  end

  def about
  end

  def contact
  end

  def profile
  	@user = User.all
  end
end
