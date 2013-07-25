require 'spec_helper'

describe FullTextExtractor do

  let(:object_with_full_text) { double  }

  let(:object_without_full_text) { double  }
  describe '#call' do
    context 'with full text' do
      subject { FullTextExtractor.new(object_with_full_text) }
      it 'should response to extract content' do
        object_with_full_text.should_receive(:respond_to?).with(:extract_content).and_return(true)
        object_with_full_text.should_receive(:extract_content)
        subject.call
      end
    end

    context 'without full_text' do
      subject { FullTextExtractor.new(object_without_full_text) }
      it 'should not response to extract content' do
        object_without_full_text.should_receive(:respond_to?).with(:extract_content).and_return(false)
        object_without_full_text.should_not_receive(:extract_content)
        subject.call
      end
    end
  end
end