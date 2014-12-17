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

  def self.sign_up(email)
    Service.new(build_tracker).sign_up(email)
  end

  def self.create_authorization_code(email)
    Service.new(build_tracker).create_authorization_code(email)
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
    DOWNLOADED_WINDOWS = 'Downloaded Windows'
    DOWNLOADED_ANDROID = 'Downloaded Android'

    attr_reader :tracker

    def initialize(tracker)
      @tracker = tracker
    end

    def alias(email, mixpanel_distinct_id, user_properties)
      @tracker.alias(email, mixpanel_distinct_id)

      @tracker.people.set(email, {
                                 '$first_name' => user_properties[:first_name],
                                 '$last_name' => user_properties[:last_name],
                                 '$email' => email,
                                 '$created' => Time.now.utc },
                          ip = user_properties[:remote_ip])
    end

    def windows_download(email)
      @tracker.track(email, EventTracking::DOWNLOAD, { client: EventTracking::WINDOWS_CLIENT, email: email }, ip=0)
      @tracker.people.set_once(email, { DOWNLOADED_WINDOWS => true }, ip=0)
    end

    def android_download(email)
      @tracker.track(email, EventTracking::DOWNLOAD, { client: EventTracking::ANDROID_CLIENT, email: email }, ip=0)
      @tracker.people.set_once(email, { DOWNLOADED_ANDROID => true }, ip=0)
    end

    def sign_up(email)
      @tracker.track(email, EventTracking::SIGN_UP, { email: email }, ip=0)
    end

    def create_authorization_code(email)
      @tracker.track(email, EventTracking::CREATE_AUTHORIZATION_CODE, { email: email }, ip=0)
    end
  end
end