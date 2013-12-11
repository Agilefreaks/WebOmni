class CreateClipping
  def self.with(params)
    CreateClipping.new(params['channel'], params['content']).create
  end

  attr_reader :channel, :content
  attr_accessor :clipping_factory, :notification_service

  def initialize(channel, content)
    @channel = channel
    @content = content
  end

  def create
    @clipping_factory ||= ClippingFactory.new
    @notification_service ||= NotificationService.new

    clipping = @clipping_factory.create(@channel, @content)
    @notification_service.notify(clipping)

    clipping
  end
end