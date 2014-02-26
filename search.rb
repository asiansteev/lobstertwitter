require 'twitter'
require 'yaml'

credentials = YAML.load_file('credentials.yml')
client = Twitter::REST::Client.new(credentials)

client.search('lobster for dinner', result_type: 'recent').
       take(1).each do |tweet|
    # without the @username in the tweet, the conversation doesn't appear
    # on twitter
    client.update "@#{tweet.user.screen_name} mmm... that sounds delicious",
                  in_reply_to_status_id: tweet.id.to_s
end
