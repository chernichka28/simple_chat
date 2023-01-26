class ClientChannel < ApplicationCable::Channel
  def subscribed
    logger.info "User #{current_user.nickname} online from UserChannel"

    stream_from "user_channel"
    user_service = UserService.new(user: current_user)
    user_service.activate
    user_service.perform
  end

  def unsubscribed
    logger.info "User #{current_user.nickname} offline from UserChannel"

    if ActionCable.server.connections.select { |con| con.current_user == current_user }.length == 0
      stream_from "user_channel"
      user_service = UserService.new(user: current_user)
      user_service.deactivate
      user_service.perform
    end
  end
end
