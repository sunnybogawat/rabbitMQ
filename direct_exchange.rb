require 'bunny'

connection = Bunny.new
connection.start

#Creating a channel
channel  = connection.create_channel

queue1 = channel.queue("sunny",:auto_delete => true)
queue2 = channel.queue("sandip",:auto_delete => true)
queue3 = channel.queue("amit",:auto_delete => true)

exchange = channel.default_exchange

queue1.subscribe do |info,metadata,payload|
    puts "I am #{payload}"
end

queue2.subscribe do |info,metadata,payload|
    puts "I am #{payload}"
end

queue3.subscribe do |info,metadata,payload|
    puts "I am #{payload}"
end

exchange.publish("sunny bogawat",:routing_key => "sunny")
exchange.publish("sandip mondal",:routing_key => "sandip")
exchange.publish("amit gijare",:routing_key => "amit")

sleep 1.0

connection.close
