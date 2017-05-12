require("bundler/setup")
Bundler.require(:default)
also_reload('lib/**/*.rb')

Dir[File.dirname(__FILE__) + '/lib/*.rb'].each { |file| require file }

get '/' do
  erb :index
end

get '/shoes' do
  @shoes = Shoe.all
  erb :shoes
end

post '/shoe' do
  shoe = Shoe.new({:name => params[:name], :cost => params[:cost], :description => params[:desc]})
  shoe.save
  redirect '/shoes'
end

get '/shoe/:id' do
  @shoe = Shoe.find(params[:id])
  erb :shoe
end

patch '/shoe/:id/store' do
  shoe = Shoe.find(params[:id])
  store_ids = params[:store_ids]
  store_ids.each do |id|
    shoe.stores.push(Store.find(id))
  end
  redirect ('/shoe/' + params[:id])
end


get '/stores' do
  @stores = Store.all()
  erb :stores
end

post '/store' do
  store = Store.new({:name => params[:name], :description => params[:desc]})
  store.save
  redirect '/stores'
end

get '/store/:id' do
  @store = Store.find(params[:id])
  erb :store
end

patch '/store/:id/shoe' do
  store = Store.find(params[:id])
  shoe_ids = params[:shoe_ids]
  shoe_ids.each do |id|
    store.shoes.push(Shoe.find(id))
  end
  redirect ('/store/' + params[:id])
end

patch '/store/name/:id' do
  store = Store.find(params[:id])
  store.update({:name => params[:name]})
  redirect ('/store/' + params[:id])
end

patch '/store/desc/:id' do
  store = Store.find(params[:id])
  store.update({:description => params[:desc]})
  redirect ('/store/' + params[:id])
end

delete '/store/edit/:id/shoe' do
  store = Store.find(params[:id])
  shoe_ids = params[:shoe_ids]
  shoe_ids.each() do |id|
    shoe = Shoe.find(id)
    store.shoes.destroy(shoe)
  end
  redirect ('/store/' + params[:id])
end

delete '/store/delete/:id' do
  store = Store.find(params[:id])
  store.destroy
  redirect '/stores'
end
