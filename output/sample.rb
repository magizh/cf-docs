require "rubygems"
require "sinatra"
require "newrelic_rpm"

get "/" do
  redirect("/docs/getting-started.html")
end

get %r{/tags/([^.]+)$} do|tag|
  redirect "/docs/tags/#{tag}.html"
end

get "/docs/tags" do
  redirect "/docs/tags/tags.html"
end
