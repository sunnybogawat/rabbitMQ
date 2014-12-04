require 'bunny'

class RequestController < ApplicationController
	def index
	end

	# Opens a client connection to the RabbitMQ service, if one isn't
	# already open. 
	def self.client
		unless @client
			c = Bunny.new()
			c.start
			@client = c
		end
		@client
	end
    
	# Return the "report_job_topic"
    def self.report_job_topic_exchange
		@report_job_topic ||= client.exchange('report.job.topic')
	end
    
    # Return the "report_status_topic"
    def self.report_status_topic_exchange
		@report_status_topic ||= client.exchange('report.status.topic')
	end
    
	# Return a queue named "messages". This will create the queue on
	# the server, if it did not already exist.
	def self.messages_queue
		@messages_queue ||= client.queue("messages")
	end
    
    # The action for our publish message.
	def publish
		# Send the message to the "messages"
		# queue, via the report_job_topic exchange. The name of the queue to
		# publish to is specified in the routing key.
        HomeController.report_job_topic_exchange.publish @req_object.to_json,
			:content_type => "application/json",
			:key => "messages"
		
        # Notify the user that we published.
		flash[:published] = true
		redirect_to home_index_path
	end
end 
	
