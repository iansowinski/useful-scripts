require 'telegram/bot'
require 'koala'
require 'json'
require 'net/http'

config_json = JSON.parse(File.read('config.json'))

token = config_json['telegram']['token']

Koala.configure do |config|
   config.app_id = config_json['facebook']['app_id']
   config.app_access_token = config_json['facebook']['app_access_token']
   config.app_secret = config_json['facebook']['app_secret']
   config.access_token = config_json['facebook']['access_token']
end


x = 0
@graph = Koala::Facebook::API.new()
Telegram::Bot::Client.run(token) do |bot|
  msg = nil
  loop do
    a = @graph.get_connection('meetjspl', 'posts', {
      limit: 1,
      fields: ['message', 'id', 'from', 'type', 'picture', 'link', 'created_time', 'updated_time']
      })
    bot.api.send_message(chat_id: 52777787, text: a[0]['message']) if a[0]['message'] != msg
    msg = a[0]['message']
    # sleep 60
    puts x
    x = x+1
  end
end