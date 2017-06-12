class BotController < ApplicationController
  def webhook
    if params['hub.verify_token'] == "mysecretverifytoken"
     render text: params['hub.challenge']
   else
     render text: 'error'
   end
  end
end
