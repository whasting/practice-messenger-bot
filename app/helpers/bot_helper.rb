module BotHelper
  def get_name_from_id(sender_id)
    # response = HTTParty.get(
    #   "https://graph.facebook.com/v2.6/me/#{sender_id}?access_token=#{ENV['FACEBOOK_PAGE_ACCESS_TOKEN']}",
    #   headers: {
    #     'Content-Type' => 'application/json'
    #   }
    # )
  end

  def parse_message(message)
    expressions = [

    ]
  end

  def generate_response(user_id, current_message)
    user_message_history = Message.find_by(user_id: user_id)

    if user_message_history
      user_messages = user_message_history.messages
      last_message = user_message_history.messages.last

      user_messages.push(current_message)
      user_message_history.update(messages: user_messages)
      user_message_history.save

      return_message = "Your last message was: #{last_message}, "
      return_message += "your current message is #{current_message}"
    else
      user_message_history = Message.new(user_id: user_id, messages: [current_message])
      user_message_history.save

      return_message = "Your first message is #{current_message}"
    end

    return_message
  end
end
