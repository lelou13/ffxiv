module FFXIV
  class Application < Sinatra::Base
    set :root, Root.to_s

    get '/' do
      @items = Item.all
      erb :index
    end
  end
end
