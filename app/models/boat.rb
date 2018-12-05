class Boat < ActiveRecord::Base
  belongs_to  :captain
  has_many    :boat_classifications
  has_many    :classifications, through: :boat_classifications

  def self.first_five
    limit(5)
  end

  def self.dinghy
    where("length < '20'")
  end

  def self.ship
    where("length >= '20'")
  end

  def self.last_three_alphabetically
    order(name: :desc).limit(3)
  end

  def self.without_a_captain
    where(captain_id: nil)
  end

  def self.sailboats
    self.get_boat_type('Sailboat')
  end

  def self.motorboats
    self.get_boat_type('Motorboat')
  end

  def self.with_three_classifications
    self.joins(:boat_classifications).group('boat_id').having('count(boat_id) > 2')
  end

  def self.longest
    self.order(:length => :desc).limit(1)
  end

  def self.get_boat_type(boat_type)
    self.joins(:classifications).where('classifications.name = ?', boat_type).references(:classifications)
  end

end
