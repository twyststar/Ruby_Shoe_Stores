class Store < ActiveRecord::Base
  has_and_belongs_to_many :shoes
  before_destroy :kill_all

private
  def kill_all
    self.shoes.delete_all
  end
end
