require 'json'
require 'open-uri'

def task_ids
  JSON.parse(`aws ecs list-tasks --cluster stock`)["taskArns"]
end

rspec_results = `bundle exec rspec`

if rspec_results.include?("Error")
  puts rspec_results
  exit
else
  puts rspec_results
  puts "--completed rspec"
end

`docker-compose build`
puts "--completed build-image"

`docker push keisukeh1016/stock-nginx`
puts "--completed push stock-nginx"

`docker push keisukeh1016/stock-rails`
puts "--completed push stock-rails"

task_ids.each do |task_id|
  `aws ecs stop-task --cluster stock --task #{task_id}`
  puts "--completed stop #{task_id}"
end

start_time = Time.now

`aws ecs run-task --cluster stock --task-definition stock`
puts "--completed run  #{task_ids[0]}"

loop do
  begin
    if URI.open("https://stock-app.net/").read.include?("株式")
      break
    end
  rescue Errno::ECONNREFUSED
    puts "--nginx container is being prepared"
  rescue OpenURI::HTTPError
    puts "--rails container is being prepared"
  end
  sleep 2
end

finish_time = Time.now

puts "--completed deploy in #{(finish_time - start_time).round(2)}s"
