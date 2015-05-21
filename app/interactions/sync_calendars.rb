class SyncCalendars
  def self.for(user)
    SyncCalendars.new(user).sync
  end

  def initialize(user)
    @user = user
    @google_api = GoogleApi.new
  end

  def sync
    remote_calendars = @google_api.calendars_for(@user)
    remove_old(remote_calendars)
    insert_or_update_existing(remote_calendars)
  end

  private

  def remove_old(remote_calendars)
    local_calendar_ids = @user.calendars.pluck(:google_id)
    remote_calendar_ids = remote_calendars.map(&:id)
    calendars_to_remove = local_calendar_ids - remote_calendar_ids
    calendars_to_remove.each do |id|
      @user.calendars.where(google_id: id).destroy
    end
  end

  def insert_or_update_existing(remote_calendars)
    remote_calendars.each do |item|
      criteria = Calendar.find_or_initialize_by(google_id: item['id'])
      criteria.summary = item['summary']
      criteria.user = @user

      criteria.save
    end
  end
end