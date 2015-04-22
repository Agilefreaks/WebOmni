class CalendarPolicy < ApplicationPolicy
  attr_reader :user, :calendar

  def access?
    @user.plan == :premium
  end

  def show?
    @user.identity.scope.include? 'calendar.readonly'
  end
end