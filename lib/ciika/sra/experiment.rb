# -*- coding: utf-8 -*-

module Ciika
  module SRA
    class Experiment
      def initialize(xml, id: :all)
        @experimentset = Ciika::SRA::id_selector("EXPERIMENT", xml, id)
        raise NameError, "ID not found" if @studyset == []
      end

      def parse
        @experimentset.map do |experiment|
          layout = experiment.css("LIBRARY_LAYOUT").first.children[1]
          {
            accession:          experiment.attr("accession").to_s,
            alias:              experiment.attr("alias").to_s,
            center_name:        experiment.attr("center_name").to_s,
            title:              experiment.css("TITLE").inner_text,
            study_accession:    experiment.css("STUDY_REF").attr("accession").to_s,
            study_refname:      experiment.css("STUDY_REF").attr("refname").to_s,
            design_description: experiment.css("DESIGN_DESCRIPTION").inner_text,
            sample_accession:   experiment.css("SAMPLE_DESCRIPTOR").first.attr("accession").to_s,
            sample_refname:     experiment.css("SAMPLE_DESCRIPTOR").first.attr("refname").to_s,

            library_description: {
              library_name:                  experiment.css("LIBRARY_NAME").inner_text,
              library_strategy:              experiment.css("LIBRARY_STRATEGY").inner_text,
              library_source:                experiment.css("LIBRARY_SOURCE").inner_text,
              library_selection:             experiment.css("LIBRARY_SELECTION").inner_text,
              library_layout:                experiment.css("LIBRARY_LAYOUT").first.children[1].name,
              library_orientation:           layout.attr("ORIENTATION").to_s,
              library_nominal_length:        layout.attr("NOMINAL_LENGTH").to_s,
              library_nominal_sdev:          layout.attr("NOMINAL_SDEV").to_s,
              library_construction_protocol: experiment.css("LIBRARY_CONSTRUCTION_PROTOCOL").inner_text,
            },

            platform_information:   {
              platform:         experiment.css("PLATFORM").first.children[1].name,
              instrument_model: experiment.css("INSTRUMENT_MODEL").inner_text,
              cycle_sequence:   experiment.css("CYCLE_SEQUENCE").inner_text,
              cycle_count:      experiment.css("CYCLE_COUNT").inner_text,
              flow_sequence:    experiment.css("FLOW_SEQUENCE").inner_text,
              flow_count:       experiment.css("FLOW_COUNT").inner_text,
              key_sequence:     experiment.css("KEY_SEQUENCE").inner_text,
            },

            processing_information: {
              base_calls: {
                sequence_space: experiment.css("SEQUENCE_SPACE").inner_text,
                base_caller:    experiment.css("BASE_CALLER").inner_text,
              },

              quality_scores: experiment.css("QUALITY_SCORES").map{|node|
                {
                  quality_type:    node.attr("qtype").to_s,
                  quality_scorer:  node.css("QUALITY_SCORER").inner_text,
                  number_of_level: node.css("NUMBER_OF_LEVELS").inner_text,
                  multiplier:      node.css("MULTIPLIER").inner_text
                }
              },

              pipe_section:   experiment.css("PIPE_SECTION").map{|node|
                {
                  step_index:      node.css("STEP_INDEX").inner_text,
                  prev_step_index: node.css("PREV_STEP_INDEX").inner_text,
                  program:         node.css("PROGRAM").inner_text,
                  version:         node.css("VERSION").inner_text,
                }
              },
            },

            spot_information: {
              number_of_reads_per_spot: experiment.css("NUMBER_OF_READS_PER_SPOT").inner_text,
              spot_length:              experiment.css("SPOT_LENGTH").inner_text,
            },

            read_spec: experiment.css("READ_SPEC").map{|node|
              {
                read_index: node.css("READ_INDEX").inner_text,
                read_class: node.css("READ_CLASS").inner_text,
                read_type: node.css("READ_TYPE").inner_text,
                base_coord: node.css("BASE_COORD").inner_text,
              }
            },
          }
        end
      end
    end
  end
end
