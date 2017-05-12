class Store < ActiveRecord::Base
  has_and_belongs_to_many :shoes
  before_save :cap_name
  before_destroy :kill_all

  validates_uniqueness_of :name
  validates :name, presence: true
  validates :description, presence: true

  def not_shoes
    all_shoes = Shoe.all()
    store_shoes = self.shoes()
    not_shoes = all_shoes - store_shoes
  end

private

  def cap_name
    name = self.name.split
      name.each do |word|
        word.capitalize!
      end
    name = name.join(' ')
    self.name = name
  end

  def kill_all
    self.shoes.delete_all
  end
end
