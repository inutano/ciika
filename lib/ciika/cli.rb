# -*- coding: utf-8 -*-

require 'thor'

module Ciika
  class CLI < Thor
    desc "retrieve [db] [id]", "Retrieve metadata from db with id in json format"
    def retrieve(db, id)
      puts "Got information from #{db} with identifier #{id}"
    end
  end
end
