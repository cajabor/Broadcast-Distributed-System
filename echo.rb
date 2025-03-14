#!/usr/bin/env ruby
require 'json'

class EchoServer
  def initialize
    @node_id = nil
    @next_msg_id = 0
  end

  def reply! (request, body)
    id = @next_msg_id += 1
    body = body.merge msg_id: id, in_reply_to: request[:body][:msg_id]
    msg = {src: @node_id, dest: request[:src], body: body}
    JSON.dump msg, STDOUT
    STDOUT << "\n"
    STDOUT.flush
  end
  def main!
    while line = STDIN.gets
      req = JSON.parse line, symbolize_names: true
      STDERR.puts "Received #{req.inspect}"

      body = req[:body]
      case body[:type]
        # Initialize this node
        when "init"
          @node_id = body[:node_id]
          STDERR.puts "Initialized node #{@node_id} gracefully"
          reply! req, {type: "init_ok"}

        when "echo"
          STDERR.puts "Echoing #{body}"
          reply! req, body.merge({type: "echo_ok"})
      end
    end
  end
end

EchoServer.new.main!