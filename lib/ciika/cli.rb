# -*- coding: utf-8 -*-

require 'thor'

module Ciika
  class CLI < Thor
    desc "retrieve [db] [id]", "Retrieve metadata from db with id in json format"
    def retrieve(db, id)
      puts "Got information from #{db} with identifier #{id}"
    end

    desc "parse [xml] [id]", "Parse xml metadata into json format"
    def parse(xml, id: :all)
      puts JSON.dump(Ciika::SRA::Experiment.new(xml, id).parse)
    end
  end
end
