class Classification < ActiveRecord::Base
  has_many :boat_classifications
  has_many :boats, through: :boat_classifications

  def self.my_all
    self.all
  end

  def self.longest
    longest_boat = Boat.longest[0].name
    self.joins(:boats).where(boats: {name: longest_boat})
  end
end
