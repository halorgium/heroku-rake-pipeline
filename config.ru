require "rake-pipeline"
require "rake-pipeline/middleware"

root = File.expand_path("..", __FILE__)

app = lambda do |env|
  unless env["PATH_INFO"] == "/"
    next Rack::Response.new(["Not Found"], 404).finish
  end

  body = []
  body << root
  body << ""
  body += Dir.glob("#{root}/**/*")

  Rack::Response.new(body.join("\n"), 200, "Content-Type" => "text/plain").finish
end

if ENV["DEV_ASSETS"] == "yes"
  use Rake::Pipeline::Middleware, "Assetfile"
end
use Rack::Static, :root => "#{root}/public", :urls => ["/assets"]
run app
