require('spec_helper')
describe(Store) do
  it("validates presence of description") do
    @store = Store.new({:description => ""})
    expect(@store.save()).to(eq(false))
  end
  it("does not allow certain words in name") do
    @store = Store.new({:name => "lout"})
    expect(@store.save()).to(eq(false))
  end
  it("title cases the name") do
    @store = Store.new({:name => "bob the builder", :description => "best store"})
    @store.save
    expect(@store.name()).to(eq("Bob the Builder"))
  end
    it("lists shoes not included in store") do
      store = Store.create({:name => "the one and only", :description => "best store"})
      store.save
      shoe1 = Shoe.new({:name => "the one", :description => "best shoe", :cost => "12"})
      shoe2 = Shoe.new({:name => "the two", :description => "best slipper", :cost => "12"})
      shoe1.save
      shoe2.save
      store.shoes.push(shoe1)
      expect(store.not_shoes()).to(eq([shoe2]))
    end


end
