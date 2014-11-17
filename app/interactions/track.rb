module Track
  extend TrackConfig

  def self.alias(email, mixpanel_distinct_id, user_properties)
    Service.new(build_tracker).alias(email, mixpanel_distinct_id, user_properties)
  end

  def self.windows_download(email)
    Service.new(build_tracker).windows_download(email)
  end

  def self.android_download(email)
    Service.new(build_tracker).android_download(email)
  end

  private

  def self.build_tracker
    @tracker = if Track.test_mode
                 NullObject.new
               else
                 Mixpanel::Tracker.new(Track.api_key)
               end
  end

  class NullObject
    def method_missing(*_args, &_block)
      self
    end
  end

  class Service
    attr_reader :tracker

    def initialize(tracker)
      @tracker = tracker
    end

    def alias(email, mixpanel_distinct_id, user_properties)
      @tracker.alias(email, mixpanel_distinct_id)

      @tracker.people.set(email, {
                                   '$first_name' => user_properties[:first_name],
                                   '$last_name' => user_properties[:last_name],
                                   '$email' => user_properties[:email],
                                   '$created' => Time.now.utc})
    end

    def windows_download(email)
      @tracker.track(email, EventTracking::DOWNLOAD, {client: EventTracking::WINDOWS_CLIENT})
    end

    def android_download(email)
      @tracker.track(email, EventTracking::DOWNLOAD, {client: EventTracking::ANDROID_CLIENT})
    end
  end
end