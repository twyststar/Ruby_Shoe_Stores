class Store < ActiveRecord::Base
  has_and_belongs_to_many :shoes
  before_save :title_case
  before_destroy :kill_all

  validates_uniqueness_of :name
  validates :name, {:presence => true, :length => { :maximum => 100 }}
  validates :description, presence: true

  def not_shoes
    all_shoes = Shoe.all()
    store_shoes = self.shoes()
    not_shoes = all_shoes - store_shoes
  end

private
def title_case
  ignores = ['is', 'of', 'to', 'the', 'a', 'or', 'at', 'an', 'it', 'and']
  split_sentence = self.name.split
  split_sentence[0].capitalize!()
  split_sentence.each do |word|
    if ignores.include?(word) == false
    word.capitalize!()
    end
  end
  self.name = split_sentence.join(" ")
end
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
