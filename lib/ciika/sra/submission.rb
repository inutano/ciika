# -*- coding: utf-8 -*-

module Ciika
  module SRA
    class Submission
      def initialize(xml, id: :all)
        @submissionset = Ciika::SRA::id_selector("SUBMISSION", xml, id)
        raise NameError, "ID not found" if @submission == []
      end

      def parse
        @submissionset.map do |submission|
          {
            alias:              submission.attr("alias").to_s,
            accession:          submission.attr("accession").to_s,
            submission_comment: submission.attr("submission_comment").to_s,
            center_name:        submission.attr("center_name").to_s,
            lab_name:           submission.attr("lab_name").to_s,
            submission_date:    submission.attr("submission_date").to_s
          }
        end
      end
		end
	end
end
