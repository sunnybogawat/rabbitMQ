require 'bunny'

connection = Bunny.new
connection.start

#Creating a channel
channel  = connection.create_channel
exchange = channel.fanout("broker")

channel.queue("sunny",:auto_delete => true).bind(exchange).subscribe  do |info,metadata,payload|
    puts "#{payload} => sunny"
end

channel.queue("sandip",:auto_delete => true).bind(exchange).subscribe  do |info,metadata,payload|
    puts "#{payload} => sandip"
end

channel.queue("amit",:auto_delete => true).bind(exchange).subscribe  do |info,metadata,payload|
    puts "#{payload} => amit"
end

exchange.publish("first message").publish("second message")


sleep 1.0

connection.close
