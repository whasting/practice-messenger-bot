module BotHelper
  def parse_command(message)
    expressions = [
      "LIST",
      "ADD",
      "DONE",
      "COMPLETE",
      "HELP"
    ]

    regex = Regexp.new(expressions.join('|'), true)
    command = regex.match(message).to_s.downcase
  end

  def determine_response(command, user_id, message)
    if command == "list"
      response = list_todo_items(user_id)

    elsif command == "add"
      response = add_todo_item(user_id, message)

    elsif command == "done"
      response = mark_todo_item_done(user_id, message)

    elsif command == "complete"
      response = list_completed_todo_items(user_id)

    elsif command == "help"
      response = "Available commands:\n"
      response += "LIST\nADD clean room\n#1 DONE\nCOMPLETE\n"

    else
      response = "Sorry, I didn't understand your command :( \n"
      response += "Please format your message like so:\n"
      response += "LIST\nADD clean room\n#1 DONE\nCOMPLETE\n"
      response += "use HELP to see these commands again"

    end

    response
  end

  def list_todo_items(user_id)
    todo_items = TodoList.find_by(user_id: user_id).todo_list_items.where(complete: false).to_a

    if todo_items.length > 0
      response = "You have #{todo_items.length} todo item(s):\n"
    else
      response = "You have no todo items. Use ADD to add a todo item (e.g. ADD clean room)."
    end

    todo_items.each_with_index do |todo_item, idx|
      response += "##{idx + 1}: #{todo_item.body}\n"
    end

    response
  end

  def add_todo_item(user_id, message)
    regex = Regexp.new('\b(?!ADD)\b.*', true)
    todo_list_body = regex.match(message).to_s.strip.capitalize
    todo_list_id = TodoList.find_by(user_id: user_id).id

    todo_list_item =
      TodoListItem.new(
        todo_list_id: todo_list_id,
        body: todo_list_body
      )

    if todo_list_item.save
      response = "'#{todo_list_body}' has been added to your todo list!"
    else
      response = "Oops! Something went wrong, try entering your item again."
    end

    response
  end

  def mark_todo_item_done(user_id, message)
    regex = Regexp.new('[-]?\d+')
    todo_item_number = regex.match(message).to_s.to_i - 1

    if todo_item_number >= 0
      todo_list_item =
        TodoList
          .find_by(user_id: user_id)
          .todo_list_items
          .where(complete: false)
          .to_a[todo_item_number]

      if todo_list_item
        todo_list_item.complete = true

        if todo_list_item.save
          response = "'#{todo_list_item.body}' has been marked complete :D!"
        else
          response = "Oops! Something went wrong, try entering the item completed again."
        end
      else
        response = "Oops! Todo item doens't exist :("
      end
    else
      response = "Oops! Please enter a valid number."
    end

    response
  end

  def list_completed_todo_items(user_id)
    todo_items = TodoList.find_by(user_id: user_id).todo_list_items.where(complete: true).to_a

    if todo_items.length > 0
      response = "You have #{todo_items.length} completed todo item(s):\n"
    else
      response = "You have no completed todo items. List the todo item number + DONE to complete a todo item (e.g. #1 DONE)."
    end

    todo_items.each_with_index do |todo_item, idx|
      response += "DONE ##{idx + 1}: #{todo_item.body}\n"
    end

    response
  end

  def generate_response(user_id, message)
    if user_exist?(user_id)
      command = parse_command(message)
      response = determine_response(command, user_id, message)
    else
      response = "Welcome! Thanks for using Wade's Todo App!\n"
      command = parse_command(message)

      unless command.empty?
        response += determine_response(command, user_id, message)
      end
    end

    response
  end

  def user_exist?(user_id)
    user = User.find_by(id: user_id)

    unless user
      user = User.new(id: user_id)
      default_todo_list = TodoList.new(user_id: user_id)

      unless user.save && default_todo_list.save
        render plain: "ERROR: #{user.errors.full_messages}, #{default_todo_list.errors.full_messages}"
      end

      return false
    end
    return true
  end
end
