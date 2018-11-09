class BotController < ApplicationController
  skip_before_action :verify_authenticity_token

  def webhook
    message = Message.new(params.permit!.to_h)

    client = Client.new(message.serviceUrl)

    client.create(
      message.conversation['id'],
      message.id,
      {
        text: message.text.reverse,
        type: "message",
        from: {
          id: message.recipient['id'],
          name: 'bot'
        },
        "attachments": [
          {
            "contentType": "application/vnd.microsoft.card.adaptive",
            "content": {
              "type": "AdaptiveCard",
              "version": "1.0",
            }.merge(CARD)
          }
        ]
      }
    )

    head :ok
  end

  def ping
    client = Client.new("https://smba.trafficmanager.net/apis/")
    client.ping(
      '29:1j4j_W4mqAxLVK-j50RahnXnTwsB3NSdzq4YTgiWbh_k',
      {
        text: 'you need to do something!!!',
        type: "message",
        from: {
          id: '28:b2c4981d-116c-457d-b3ce-4bcb7f371a16',
          name: 'bot'
        },
      }
    )
  end

  def pong
    client = Client.new("https://smba.trafficmanager.net/apis/")
    client.pong(
      {
        bot: {
          id: '28:b2c4981d-116c-457d-b3ce-4bcb7f371a16',
          name: 'bot'
        },
        isGroup: false,
        members: [
          {
            id: "29:1j4j_W4mqAxLVK-j50RahnXnTwsB3NSdzq4YTgiWbh_k",
            name: "Igor Kasyanchuk"
          }
        ],
        topicName: "This is a topic",
        activity: {
          text: 'you need to do something!!!',
          type: "message",
        }
      }
    )
  end
end
