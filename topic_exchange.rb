require 'bunny'

connection = Bunny.new
connection.start

#Creating a channel
channel  = connection.create_channel
exchange = channel.topic("newbroker",:auto_delete => true)

channel.queue("",:exclusive => true).bind(exchange,:routing_key => "pune.city.#").subscribe  do |info,metadata,payload|
    puts "On the topic of pune city,#{payload},:routing_key => #{info.routing_key}"
end

channel.queue("",:exclusive => true).bind(exchange,:routing_key => "#.rubyonrails").subscribe  do |info,metadata,payload|
    puts "On the topic of rubyonrails,#{payload},:routing_key => #{info.routing_key}"
end

channel.queue("",:exclusive => true).bind(exchange,:routing_key => "usa.annapolice.*").subscribe  do |info,metadata,payload|
    puts "On the topic of usa.annapolice,#{payload},:routing_key => #{info.routing_key}"
end

exchange.publish("first message",:routing_key => "pune.city.sungard").publish("second message",:routing_key => "usa.annapolice.temrature")


sleep 1.0

connection.close
