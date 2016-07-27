require 'yaml'

if File.exists?("config.yml")
  data           = YAML.load(File.read("config.yml"))
  secret_config = data["secrets"]

  @wit_token = secret_config["wit_token"]
  @fb_token = secret_config["fb_token"]
  @fb_app_secret = secret_config["fb_app_secret"]
  @fb_verify_token = secret_config["fb_verify_token"]
else
  @wit_token = nil
  @fb_token = nil
  @fb_app_secret = nil
  @fb_verify_token = nil
end