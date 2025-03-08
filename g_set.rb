#!/usr/bin/env ruby

class GSetServer
  attr_reader :node
  def initialize
    @node = Node.new
    @lock = Mutex.new
    @set = Set.new

    @node.on "read" do |msg|
      @lock.synchronize do
        @node.reply! msg, type: "read_ok", value: @set.to_a
      end
    end

    @node.on "add" do |msg|
      @lock.synchronize do
        @set.add msg[:body][:element]
      end
      @node.reply! msg, type: "add_ok"
    end
  end
end

GSetServer.new.node.main!