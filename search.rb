require 'twitter'
require 'yaml'

credentials = YAML.load_file('credentials.yml')
client = Twitter::REST::Client.new(credentials)

client.search("lobster for dinner", result_type: "recent").
       take(3).each do |tweet|
    puts tweet.text
end
