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
      message_data = params[:entry].first[:messaging].first
      sender = message_data[:sender]
      send_message(sender, message_data)
    end
  end

  def send_message(sender_id, message_data)
    message = "Your message: #{message_data[:message][:text]}"

    body = {
      recipient: {
        id: sender_id
      },
      message: {
        text: message
      }
    }.to_json

    response = HTTParty.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=#{mysecretverifytoken}",
      body: body,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
  end
end
