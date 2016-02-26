require 'tumblr_client'

puts "tumblr update ... "

TUMBLR = 'dkhamsing.tumblr.com'
FILE = 'index.html'

puts "configuring ..."

configuration = {}
configuration['consumer_key'] = ENV['TBLR_C_KEY']
configuration['consumer_secret'] = ENV['TBLR_C_SECRET']
configuration['oauth_token'] = ENV['TBLR_TKN']
configuration['oauth_token_secret'] = ENV['TBLR_TKN_SECRET']

Tumblr.configure do |config|
  Tumblr::Config::VALID_OPTIONS_KEYS.each do |key|
    config.send(:"#{key}=", configuration[key.to_s])
  end
end

begin
  client = Tumblr::Client.new
rescue => e
  puts "client error: exception #{e}"
  exit 1
end

post = client.posts(TUMBLR, :limit => 1)

begin
  post_id = post['posts'][0]['id']
  puts "deleting post #{post_id} ..."
  client.delete TUMBLR, post_id
rescue => e
  puts "delete error: #{e}"
end

puts "reading file"
html = File.read FILE
puts html

puts "creating a new text post ..."
type = :text
options = { :body => html,
            :slug => 'hi'
          }
client.create_post type, TUMBLR, options

puts 'tumblr update done'
