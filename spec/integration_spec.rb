describe('Store',{:type => :feature}) do
  it('creates a new store') do
    visit('/stores')
    fill_in("name", :with => "footlocker")
    fill_in("desc", :with => "mall store")
    click_on("Add Store")
    expect(page).to have_content("Footlocker")
  end
  it('adds shoe and displays it to add shoe to store') do
    visit('/shoes')
    fill_in('name', :with => 'nike')
    fill_in('desc', :with => 'athletic')
    fill_in('cost', :with => '20')
    click_on("Add Shoe")
    visit('/stores')
    fill_in("name", :with => "footlocker")
    fill_in("desc", :with => "mall store")
    click_on("Add Store")
    click_on("Footlocker")
    expect(page).to have_content("Nike")
  end
end
