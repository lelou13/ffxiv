module FFXIV
  class Application < Sinatra::Base
    set :root, Root.to_s
    use Rack::Session::Cookie, :secret => YAML.load_file(Root + "config" + "secret.yml").to_s

    opts = {:required => [], :optional => []}
    use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), opts
    use OmniAuth::Strategies::OpenID, OpenID::Store::Filesystem.new('/tmp'), opts.merge(:name => 'google', :identifier => 'https://www.google.com/accounts/o8/id')

    helpers do
      def authenticate!
        if current_user.nil?
          session['return_to'] = request.path_info
          redirect '/login'
        end
      end

      def current_user
        unless @current_user
          @current_user = session['user_id'] ? User[session['user_id']] : nil
        end
        @current_user
      end

      def error_messages_for(object)
        return ""   if object.nil? || object.errors.empty?

        retval = "<div class='errors'><h3>Errors detected:</h3><ul>"
        object.errors.each do |(attr, messages)|
          messages.each do |message|
            retval += "<li>"
            retval += attr.to_s.tr("_", " ").capitalize + " " if attr != :base
            retval += "#{message}</li>"
          end
        end
        retval += "</ul></div><div class='clear'></div>"

        retval
      end
    end

    get '/' do
      authenticate!
      @items = Item.all
      erb :index
    end

    get '/login' do
      if current_user
        redirect '/'
      else
        erb :login
      end
    end

    get '/signup' do
      redirect '/login' if !session['omniauth']

      @user = User.new
      @characters = [Character.new]
      erb :signup
    end

    post '/signup' do
      redirect '/login' if !session['omniauth']

      auth = session['omniauth']
      @user = User.new(params['user'])
      @user.provider = auth['provider']
      @user.uid = auth['uid']

      if @user.valid? && @user.save
        session.delete('omniauth')
        session['user_id'] = @user.id
        redirect '/'
      else
        @characters = @user.characters
        @characters = [Character.new] if @characters.empty?
        erb :signup
      end
    end

    post '/auth/:provider/callback' do
      auth = request.env['omniauth.auth']
      user = User[:provider => auth['provider'], :uid => auth['uid']]
      if user
        session['user_id'] = user.id
        redirect '/'
      else
        session['omniauth'] = auth
        redirect '/signup'
      end
    end
  end
end
