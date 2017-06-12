class BotController < ApplicationController
  def show
    @message = params
    render 'bot/show'
  end
end
