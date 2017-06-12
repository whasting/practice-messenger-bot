class BotController < ApplicationController
  def webhook
    if params['hub.verify_token'] == "mysecretverifytoken"
     render text: params['hub.challenge']
   else
     render text: 'error'
   end
  end

  def receive_message
    if params[:entry]
      render text: params[:entry]
      # message = params['entry'].first['messaging']['message']['text']
      # render text: "Your message was: #{message}"
    end
  end
end
