class Store < ActiveRecord::Base
  has_and_belongs_to_many :shoes
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
  def kill_all
    self.shoes.delete_all
  end
end
