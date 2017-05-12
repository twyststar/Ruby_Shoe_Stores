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

get '/stores' do
  @stores = Store.all()
  erb :stores
end

post '/store' do
  store = Store.new({:name => params[:name], :description => params[:desc]})
  store.save
  redirect '/stores'
end
