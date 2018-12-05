class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.get_by_classification("Catamaran")
  end

  def self.sailors
    self.get_by_classification("Sailboat")
  end

  def self.get_by_classification(classification)
    self.includes(:classifications).where(classifications: {name: classification}).uniq
  end

  def self.talented_seamen
    sailor_ids = self.sailors.pluck(:id)
    motorboat_ids = self.get_by_classification("Motorboat").pluck(:id)
    ids = sailor_ids & motorboat_ids
    where(id: ids)
  end

  def self.non_sailors
    sailor_ids = self.sailors.pluck(:id)
    where.not(id: sailor_ids)
  end

end
