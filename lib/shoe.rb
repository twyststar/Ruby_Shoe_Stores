class Shoe < ActiveRecord::Base
  has_and_belongs_to_many :stores

  validates_uniqueness_of :name
  validates :name, {:presence => true, :length => { :maximum => 100 }}
  validates :cost, presence: true
  validates :description, presence: true
  validates :name, :exclusion => { :in => %w(lout),
    :message => ": The word %{value} offends the owner." }
  validates :name, :exclusion => { :in => %w(curmudgeon),
    :message => ": The word %{value} offends the owner." }
  validates :name, :exclusion => { :in => %w(clodhopper),
    :message => ": The word %{value} offends the owner." }

  before_destroy :kill_all
  before_save :make_money
  before_save :title_case
  before_save :cap_desc

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

  def cap_desc
    desc = self.description.split('. ')
    desc.each do |part|
      part.capitalize!
    end
    self.description = desc.join('. ')
  end


  def kill_all
    self.stores.delete_all
  end

  def make_money
    now = self.cost.split("")
    if now[0] == "$"
    now.shift
    end
    if now.length > 1
     now = now.join()
    end
    self.cost = "$"+"%.2f" % now
  end

end
