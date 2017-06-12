class BotController < ApplicationController
  def show
    @message = 1234
    render 'bot/show'
  end
end
