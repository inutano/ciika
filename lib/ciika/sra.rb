# -*- coding: utf-8 -*-

require 'nokogiri'

module Ciika
  module SRA
    module_function
    def id_selector(type, xml, id)
      # return an array of nokogiri objects
      dataset = Nokogiri::XML(open(xml)).css(type)
      case id
      when :all
        dataset
      else
        dataset.select{|n| n.attr("accession") =~ /#{id}/ }
      end
    end
  end
end
