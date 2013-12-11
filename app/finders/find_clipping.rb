module FindClipping
  def self.for(email)
    user = User.find_by(email: email)
    user.clippings.order_by(:created_at.asc).last
  end
end