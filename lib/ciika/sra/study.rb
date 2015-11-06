# -*- coding: utf-8 -*-

module Ciika
  module SRA
    class Study
      def initialize(xml, id: :all)
        @studyset = Ciika::SRA::id_selector("STUDY", xml, id)
        raise NameError, "ID not found" if @studyset == []
      end

      def parse
        @studyset.map do |study|
          {
            accession:           study.attr("accession").to_s,
            alias:               study.attr("alias").to_s,
            center_name:         study.attr("center_name").to_s,
            center_project_name: study.css("CENTER_PROJECT_NAME").inner_text,
            study_title:         study.css("STUDY_TITLE").inner_text,
            study_type:          study.css("STUDY_TYPE").attr("existing_study_type").to_s,
            study_abstract:      study.css("STUDY_ABSTRACT").inner_text,
            study_description:   study.css("STUDY_DESCRIPTION").inner_text,

            url_link: study.css("URL_LINK").map{|node|
              {
                label: node.css("LABEL").inner_text,
                url:   node.css("URL").inner_text
              }
            },

            entrez_link: study.css("ENTREZ_LINK").map{|node|
              {
                db: node.css("DB").inner_text,
                id: node.css("ID").inner_text
              }
            },

            related_link: study.css("RELATED_LINK").map{|node|
              {
                db:    node.css("DB").inner_text,
                id:    node.css("ID").inner_text,
                label: node.css("LABEL").inner_text
              }
            },
          }
        end
      end
		end
	end
end
