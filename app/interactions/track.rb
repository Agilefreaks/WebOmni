module Track
  extend TrackConfig

  def self.user_created(email, user_properties)
    Service.new.user_created(email, user_properties)
  end

  def self.windows_download(email)
    Service.new.windows_download(email)
  end

  def self.android_download(email)
    Service.new.android_download(email)
  end

  def self.sign_up(email)
    Service.new.sign_up(email)
  end

  def self.create_authorization_code(email)
    Service.new.create_authorization_code(email)
  end

  private

  class Service
    DOWNLOADED_WINDOWS = 'Downloaded Windows'
    DOWNLOADED_ANDROID = 'Downloaded Android'

    attr_reader :tracker

    def user_created(email, user_properties)
      set_people(email,
                 { '$first_name' => user_properties[:first_name],
                   '$last_name' => user_properties[:last_name],
                   '$email' => email,
                   '$created' => Time.now.utc },
                 user_properties[:remote_ip])
    end

    def windows_download(email)
      OmniKiq::Trackers::MixpanelEvents.perform_async(email, EventTracking::DOWNLOAD, { client: EventTracking::WINDOWS_CLIENT, email: email })
      set_people(email, { DOWNLOADED_WINDOWS => true })
    end

    def android_download(email)
      OmniKiq::Trackers::MixpanelEvents.perform_async(email, EventTracking::DOWNLOAD, { client: EventTracking::ANDROID_CLIENT, email: email })
      set_people(email, { DOWNLOADED_ANDROID => true })
    end

    def sign_up(email)
      OmniKiq::Trackers::MixpanelEvents.perform_async(email, EventTracking::SIGN_UP, { email: email })
    end

    def create_authorization_code(email)
      OmniKiq::Trackers::MixpanelEvents.perform_async(email, EventTracking::CREATE_AUTHORIZATION_CODE, { email: email })
    end

    private

    def set_people(email, params, remote_ip = 0)
      user = User.where(email: email).first
      return unless user

      if user.aliased?
        OmniKiq::Trackers::MixpanelPeople.perform_async(email, params, remote_ip)
      else
        OmniKiq::Trackers::MixpanelPeople.perform_async(user.mixpanel_distinct_id, params, remote_ip)
        set_alias(email, user.mixpanel_distinct_id)
      end
    end

    def set_alias(email, mixpanel_distinct_id)
      return if mixpanel_distinct_id.blank?

      OmniKiq::Trackers::MixpanelAlias.perform_async(email, mixpanel_distinct_id)
      user = User.find_by(email: email)
      user.set(aliased: true)
    end
  end
end