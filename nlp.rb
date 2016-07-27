require 'wit'
require_relative 'load_configs'

def do_nlp(message)
  client = Wit.new(access_token: @wit_token)
  puts "Doing Natural Language Processing..."
  rsp = client.message(message)
  cat = ""
  price = ""
  color = ""
  cat = rsp["entities"]["category"].first["value"] unless rsp["entities"]["category"].nil?
  price = rsp["entities"]["price"].first["value"] unless rsp["entities"]["price"].nil?
  color = rsp["entities"]["color"].first["value"] unless rsp["entities"]["color"].nil?
  puts "Got NLP with #{color}, #{cat}, #{price}"
  entities = {:cat => cat, :color => color, :price=> price}
end