class Connector
  attr_reader :app_id, :app_secret

  def initialize
    @app_id = MS_APP_ID
    @app_secret = MS_PASSWORD
  end

  def client
    OAuth2::Client.new(app_id, app_secret,
                       authorize_url: 'botframework.com/oauth2/v2.0/authorize',
                       token_url: 'botframework.com/oauth2/v2.0/token',
                       raise_errors: true,
                       site: 'https://login.microsoftonline.com')
  end

  def token
    @token = nil if @token && @token.expired?
    @token ||= get_token
    @token
  end

  def get_token
    client.client_credentials.get_token(scope: 'https://api.botframework.com/.default', token_method: :post)
  end
end
