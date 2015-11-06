require 'spec_helper'

describe Ciika do
  it 'has a version number' do
    expect(Ciika::VERSION).not_to be nil
  end

  describe Ciika::SRA do
    describe Ciika::SRA::Submission do
      describe '#parse' do
        it 'parses metadata and returns array' do
          xml = File.join(__dir__, "data", "example.submission.xml")
          data = Ciika::SRA::Submission.new(xml).parse
          expect(data).to be_instance_of(Array)
          expect(data).not_to be_empty
        end
      end
    end

    describe Ciika::SRA::Study do
      describe '#parse' do
        it 'parses metadata and returns array' do
          xml = File.join(__dir__, "data", "example.study.xml")
          data = Ciika::SRA::Study.new(xml).parse
          expect(data).to be_instance_of(Array)
          expect(data).not_to be_empty
        end
      end
    end

    describe Ciika::SRA::Experiment do
      describe '#parse' do
        it 'parses metadata and returns array' do
          xml = File.join(__dir__, "data", "example.experiment.xml")
          data = Ciika::SRA::Experiment.new(xml).parse
          expect(data).to be_instance_of(Array)
          expect(data).not_to be_empty
        end
      end
    end

    describe Ciika::SRA::Sample do
      describe '#parse' do
        it 'parses metadata and returns array' do
          xml = File.join(__dir__, "data", "example.sample.xml")
          data = Ciika::SRA::Sample.new(xml).parse
          expect(data).to be_instance_of(Array)
          expect(data).not_to be_empty
        end
      end
    end

    describe Ciika::SRA::Run do
      describe '#parse' do
        it 'parses metadata and returns array' do
          xml = File.join(__dir__, "data", "example.run.xml")
          data = Ciika::SRA::Run.new(xml).parse
          expect(data).to be_instance_of(Array)
          expect(data).not_to be_empty
        end
      end
    end
  end
end
