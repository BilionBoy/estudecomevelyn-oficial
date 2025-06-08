class ServiceResult
  attr_reader :success, :message, :payload

  def initialize(success:, message:, payload: nil)
    @success = success
    @message = message
    @payload = payload
  end

  def success?
    success
  end
end
