class BadRequestError < StandardError
  include ActiveModel::Serialization

  attr_reader :message_id
  attr_reader :message

  def initialize(message_id, message = nil)
    @message_id = message_id.to_sym
    @message = message
  end

  def message
    @message.presence || I18n.t("exceptions.#{self.class.name.demodulize.underscore}.#{@message_id}")
  end

  def inspect
    "#<#{self.class.name}: #{message}>"
  end
end