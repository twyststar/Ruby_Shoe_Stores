class Shoe < ActiveRecord::Base
  has_and_belongs_to_many :stores
  before_destroy :kill_all

private
  def kill_all
    self.stores.delete_all
  end
end
