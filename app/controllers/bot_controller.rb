class BotController < ApplicationController
  include BotHelper

  def webhook
    if params['hub.verify_token'] == "mysecretverifytoken"
      render plain: params['hub.challenge']
    else
      render plain: 'error'
    end
  end

  def receive_message
    if params[:entry]
      message_data = params[:entry].first[:messaging].first

      if (message_data[:message] && message_data[:message][:text])
        sender = message_data[:sender][:id]
        message = message_data[:message][:text]
        response = generate_response(sender, message)

        send_message(sender, response)
      end
    end
  end

  def send_message(sender_id, message)
    # TODO: Add different response types, i.e. buttons
    # body = {
    #   recipient: {
    #     id: sender_id
    #   },
    #   message: {
    #     attachment: {
    #       type: "template",
    #       payload: {
    #         template_type: "button",
    #         text: message,
    #         buttons: [{
    #           type: "postback",
    #           title: "Start Chatting",
    #           payload: "USER_DEFINED_PAYLOAD"
    #         }]
    #       }
    #     }
    #   }
    # }.to_json

    body = {
      recipient: {
        id: sender_id
      },
      message: {
        text: message
      }
    }.to_json

    response = HTTParty.post(
      "https://graph.facebook.com/v2.6/me/messages?access_token=#{ENV['FACEBOOK_PAGE_ACCESS_TOKEN']}",
      body: body,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
  end
end
