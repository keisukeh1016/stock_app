require 'json'
require 'open-uri'

def task_id
  JSON.parse(`aws ecs list-tasks --cluster stock`)["taskArns"][0]
end

`docker-compose build`
puts "--complete build-image"

`docker push keisukeh1016/stock-nginx`
puts "--complete push stock-nginx"

`docker push keisukeh1016/stock-rails`
puts "--complete push stock-rails"

task_id_deleted = task_id
`aws ecs stop-task --cluster stock --task #{task_id}` unless task_id.nil?
puts "--complete stop #{task_id_deleted}"

`aws ecs run-task --cluster stock --task-definition stock`
puts "--complete run  #{task_id}"

loop do
  begin
    if URI.open("https://stock-app.net/").read.include?("株式")
      puts "--complete deploy"
      break
    end
  rescue Errno::ECONNREFUSED
    puts "--nginx container is being prepared"
  rescue OpenURI::HTTPError
    puts "--rails container is being prepared"
  end
  sleep 2
end

