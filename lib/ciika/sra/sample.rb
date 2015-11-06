# -*- coding: utf-8 -*-

module Ciika
  module SRA
    class Sample
			def initialize(xml, id: :all)
	      @sampleset = Ciika::SRA::id_selector("SAMPLE", xml, id)
	      raise NameError, "ID not found" if @sampleset == []
	    end

	    def parse
	      @sampleset.map do |sample|
	        {
	          accession:          sample.attr("accession").to_s,
	          alias:              sample.attr("alias").to_s,
	          title:              sample.css("TITLE").inner_text,
	          sample_description: sample.css("DESCRIPTION").inner_text,

	          organism_information: {
              taxon_id:        sample.css("TAXON_ID").inner_text,
              common_name:     sample.css("COMMON_NAME").inner_text,
              scientific_name: sample.css("SCIENTIFIC_NAME").inner_text,
              anonymized_name: sample.css("ANONYMIZED_NAME").inner_text,
              individual_name: sample.css("INDIVIDUAL_NAME").inner_text,
            },

	          sample_links: {
              url_link: sample.css("URL_LINK").map{|node|
	              {
	                label: node.css("LABEL").inner_text,
	                url:   node.css("URL").inner_text,
	              }
	            },

              entrez_link: sample.css("ENTREZ_LINK").map{|node|
                {
                  db: node.css("DB").inner_text,
                  id: node.css("ID").inner_text,
                }
              },
            },
	        }
	      end
	    end
		end
	end
end
