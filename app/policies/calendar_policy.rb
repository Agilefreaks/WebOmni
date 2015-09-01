class CalendarPolicy < ApplicationPolicy
  attr_reader :user

  def access?
    @user.plan == PaymentPlan::PREMIUM
  end

  def show?
    @user.identity.scope.include? 'calendar.readonly'
  end
end
