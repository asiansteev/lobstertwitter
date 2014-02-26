require 'twitter'
require 'yaml'

credentials = YAML.load_file('credentials.yml')
client = Twitter::REST::Client.new(credentials)

def already_replied? client, tweet
  client.user_timeline("crustasianwill").any?{|my_tweet|
    my_tweet.id == tweet.id
  }
end

def random_phrase
  ['mmm... that sounds delicious!',
   'bring me some!',
   'i\'m salivating...',
   'hook it up!',
   'that\'s my favorite.'
  ].sample
end

# -rt excludes retweets
client.search('lobster for dinner -rt', result_type: 'recent').
       take(1).each do |tweet|
  unless tweet.retweeted == 'true' || already_replied?(client, tweet)
    # without the @username in the tweet, the conversation doesn't appear
    # on twitter
    client.update "@#{tweet.user.screen_name} #{random_phrase}",
                  in_reply_to_status_id: tweet.id.to_s
  end
end
