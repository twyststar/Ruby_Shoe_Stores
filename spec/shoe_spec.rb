require('spec_helper')
describe(Store) do
  it("formats cost to money string") do
    shoe1 = Shoe.new({:name => "the one", :description => "best shoe", :cost => "12"})
    shoe1.save
    expect(shoe1.cost()).to(eq("$12.00"))
  end
  it("capitalizes the first word in each correctly written sentance in the desctription") do
    shoe1 = Shoe.new({:name => "the one", :description => "this is the best shoe. it is awesome. great.", :cost => "12"})
    shoe1.save
    expect(shoe1.description()).to(eq("This is the best shoe. It is awesome. Great."))
  end
end
