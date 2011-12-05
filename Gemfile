source "http://rubygems.org"

gem "rake", "0.9.3.beta.1"
gem "rake-pipeline"
gem "coffee-script"
gem "rack"
gem "thin"

group :production do
  gem "therubyracer"
end

if ENV["EXITED"] != "yes" && ENV["RACK_ENV"] == "production"
  at_exit do
    puts "Compiling assets..."
    Process.spawn("env EXITED=yes bundle exec rakep build")
    Process.waitall
    puts "Done"
  end
end
