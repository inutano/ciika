# -*- coding: utf-8 -*-

module Ciika
  module SRA
    class Run
      def initialize(xml, id: :all)
        @runset = Ciika::SRA::id_selector("RUN", xml, id)
        raise NameError, "ID not found" if @runset == []
      end

      def parse
        @runset.map do |run|
          {
            accession:         run.attr("accession").to_s,
            alias:             run.attr("alias").to_s,
            center_name:       run.attr("center_name").to_s,
            run_center:        run.attr("run_center").to_s,
            run_date:          run.attr("run_date").to_s,
            instrument_name:   run.attr("instrument_name").to_s,
            total_data_blocks: run.attr("total_data_blocks").to_s,

            pipeline: run.css("PIPE_SECTION").map{|node|
              {
                section_name:    node.attr("section_name").to_s,
                step_index:      node.css("STEP_INDEX").inner_text,
                prev_step_index: node.css("PREV_STEP_INDEX").inner_text,
                program:         node.css("PROGRAM").inner_text,
                version:         node.css("VERSION").inner_text,
              }
            },

            spot_information: {
              number_of_reads_per_spot: run.css("NUMBER_OF_READS_PER_SPOT").inner_text,
              spot_length:              run.css("SPOT_LENGTH").inner_text,
              read_spec: run.css("READ_SPEC").map{|node|
                {
                  read_index: node.css("READ_INDEX").inner_text,
                  read_class: node.css("READ_CLASS").inner_text,
                  read_type: node.css("READ_TYPE").inner_text,
                  base_coord: node.css("BASE_COORD").inner_text,
                }
              },
            },

            run_attr: run.css("RUN_ATTRIBUTE").map{|node|
              {
                tag:   node.css("TAG").inner_text,
                value: node.css("VALUE").inner_text,
              }
            }
          }
        end
      end
		end
	end
end
