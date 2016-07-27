require 'httpclient'
require 'json'
require 'active_support'
require 'active_support/core_ext'

def get_products(cat,color,price)
  uri = URI('http://mesabackend-yantra-834313990.ap-southeast-1.elb.amazonaws.com/v1/filter/apply_product_filters')

  request_data = {:data => {:path => "/women", :options => {:product_type => [cat], :color => [color], :price => {:min => "0",:max => price}}}}
  #request_data = {:data => {:path => "/women/ethnic-wear", :options => {:product_type => ["kurtas"], :color => ["red"], :price => {:min => "0",:max => "1200"}}}}

  client = HTTPClient.new
  client.receive_timeout = 5
  client.default_header["Content-Type"] = "application/json"
  client.default_header["accept"] = "application/json"
  puts "Fething products"
  res = client.post(uri, request_data.to_json)
  data = JSON.parse(res.body)
  elements = []
  puts "Got #{data["data"].count} matching products"
  if data["data"].count == 0
    return
  end
  puts "Iterating data"
  if data["data"].count > 10
    products = data["data"].first(10)
    puts "taking only first 10"
  else
    products = data["data"]
  end
  products.each do |p|
    puts "Items in elements: #{elements.count}"
    elements <<   {
    title: p["label"],
    image_url:p["image"]["path"],
    subtitle:p["product_dmrp_price"],
    buttons:[
      {
        type:"web_url",
        url:"http://www.styletag.com"+p["path"],
        title:"View On Styletag.com"
      },
      {
        type:"postback",
        title:"Add to Wishlist",
        payload:"USER_DEFINED_PAYLOAD"
      }              
    ]
  }
  end
  return elements
end