class Store < ActiveRecord::Base
  has_and_belongs_to_many :shoes

  validates_uniqueness_of :name, :case_sensitive => false
  validates :name, {:presence => true, :length => { :maximum => 100 }}
  validates :description, presence: true
  validates :name, :exclusion => { :in => %w(lout),
    :message => ": The word %{value} offends the owner." }
  validates :name, :exclusion => { :in => %w(curmudgeon),
    :message => ": The word %{value} offends the owner." }
  validates :name, :exclusion => { :in => %w(clodhopper),
    :message => ": The word %{value} offends the owner." }

  before_save :title_case
  before_save :cap_desc
  before_destroy :kill_all


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

  def cap_desc
    desc = self.description.split('. ')
    desc.each do |part|
      part.capitalize!
    end
    self.description = desc.join('. ')
  end

  def kill_all
    self.shoes.delete_all
  end
end
