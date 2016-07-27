require_relative 'load_configs'
require_relative 'nlp'
require_relative 'styletag_api'


Facebook::Messenger.configure do |config|
  config.access_token = @fb_token
  config.app_secret = @fb_app_secret
  config.verify_token = @fb_verify_token
end

include Facebook::Messenger

def send_products(recepient, products)
  Bot.deliver(
    recipient: recepient,
     message:{
       attachment:{
         type:"template",
         payload:{
           template_type:"generic",
           elements: products
         }
       }
     }
  )
end

def send_message(recepient, message)
  Bot.deliver(
    recipient: recepient,
    message: {
      text: message
      })
end


Bot.on :message do |message|
  puts "Message received: #{message.text}, processing...."
  entities = do_nlp(message.text)
  elements = get_products(entities[:cat], entities[:color], entities[:price])
  if elements.blank?
    send_message(message.sender, "Sorry, No Products Found")
  else
    send_products(message.sender,elements)
  end
end