module MessageConcern
  extend ActiveSupport::Concern

  def get_messages
    if @receiver.class.name == "Group"
      return @receiver.messages
    else
      raise UnknownType
    end
  end
end
