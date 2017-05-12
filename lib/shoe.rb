class Shoe < ActiveRecord::Base
  has_and_belongs_to_many :stores

  validates_uniqueness_of :name
  validates :name, {:presence => true, :length => { :maximum => 100 }}
  validates :cost, presence: true
  validates :description, presence: true



  before_destroy :kill_all
  before_save :make_money
  before_save :title_case

  def not_stores
    all_stores = Store.all()
    shoe_stores = self.stores()
    not_stores = all_stores - shoe_stores
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

  def kill_all
    self.stores.delete_all
  end

  def cap_name
    name = self.name.split
      name.each do |word|
        word.capitalize!
      end
    name = name.join(' ')
    self.name = name
  end

  def make_money
    self.cost = "$"+"%.2f" % cost
  end

end
