class Client
  attr_reader :service_url

  def initialize(service_url)
    @service_url = service_url
  end

  def create(conversation_id, activity_id, attributes)
    uri = "/v3/conversations/#{conversation_id}/activities/#{activity_id}"

    puts uri
    puts uri
    puts uri

    api_post(uri, attributes)
  end

  def ping(conversation_id, attributes)
    uri = "/v3/conversations/#{conversation_id}/activities"
    puts uri
    api_post(uri, attributes)
  end

  def pong(attributes)
    uri = "/v3/conversations"
    puts uri
    api_post(uri, attributes)
  end

  def api_post(local_uri, opts)
    uri = URI.join(service_url, URI.escape(local_uri))
    Connector.new.token.post(uri, body: opts.to_json,
                              headers: { 'Content-Type' => 'application/json' })
  end

end