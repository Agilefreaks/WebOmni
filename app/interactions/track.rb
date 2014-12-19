module Track
  extend TrackConfig

  def self.user_created(email, user_properties)
    Service.new(build_tracker).user_created(email, user_properties)
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

    def user_created(email, user_properties)
      set_people(email,
                 { '$first_name' => user_properties[:first_name],
                   '$last_name' => user_properties[:last_name],
                   '$email' => email,
                   '$created' => Time.now.utc },
                 user_properties[:remote_ip])
    end

    def windows_download(email)
      @tracker.track(email, EventTracking::DOWNLOAD, { client: EventTracking::WINDOWS_CLIENT, email: email }, ip=0)
      set_people(email, { DOWNLOADED_WINDOWS => true })
    end

    def android_download(email)
      @tracker.track(email, EventTracking::DOWNLOAD, { client: EventTracking::ANDROID_CLIENT, email: email }, ip=0)
      set_people(email, { DOWNLOADED_ANDROID => true })
    end

    def sign_up(email)
      @tracker.track(email, EventTracking::SIGN_UP, { email: email }, ip=0)
    end

    def create_authorization_code(email)
      @tracker.track(email, EventTracking::CREATE_AUTHORIZATION_CODE, { email: email }, ip=0)
    end

    private

    def set_people(email, params, remote_ip = 0)
      user = User.where(email: email).first
      return unless user

      set_alias(email, user.mixpanel_distinct_id) unless user.aliased?
      @tracker.people.set(email, params, ip = remote_ip)
    end

    def set_alias(email, mixpanel_distinct_id)
      return if mixpanel_distinct_id.blank?

      @tracker.alias(email, mixpanel_distinct_id)
      user = User.find_by(email: email)
      user.set(aliased: true)
    end
  end
end