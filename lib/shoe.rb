class Shoe < ActiveRecord::Base
  has_and_belongs_to_many :stores

  validates_uniqueness_of :name
  validates :name, presence: true
  validates :cost, presence: true
  validates :description, presence: true

  before_destroy :kill_all
  before_save :make_money

  def not_stores
    all_stores = Store.all()
    shoe_stores = self.stores()
    not_stores = all_stores - shoe_stores
  end

private

  def kill_all
    self.stores.delete_all
  end

  def make_money
    self.cost = "$"+"%.2f" % cost
  end

end
