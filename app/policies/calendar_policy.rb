class CalendarPolicy < ApplicationPolicy
  attr_reader :user, :calendar

  def access?
    @user.plan.to_sym == :premium if @user.plan
  end

  def show?
    @user.identity.scope.include? 'calendar.readonly'
  end
end
