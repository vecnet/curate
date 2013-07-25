require 'spec_helper'
require 'ostruct'

class FullText < ActiveFedora::Base
  include CurationConcern::WithFullText
  has_file_datastream :name => "content", :type => FileContentDatastream, :control_group => 'M'
end

describe CurationConcern::WithFullText do
  let(:model) {
    Class.new(ActiveFedora::Base) {
      include CurationConcern::WithFullText
    }
  }

  subject { model.new }

  describe 'extract full text' do
    it 'is should have fulltext datastream' do
      subject.datastreams.keys.should include 'full_text'
    end

    it 'is respond to extract content' do
      subject.should respond_to(:extract_content)
    end
  end

  describe 'extract text from object' do
     before do
       #@object = FullText.new
       @object = GenericFile.new
       @object.add_file_datastream(File.new(Rails.root.join('../support/files/HelloWorldSample.pdf')), :dsid=>'content')
       @object.save
     end
     #after do
     #  @object.delete
     #end
     it "should create new datastream with extracted text" do
       @object.should_receive(:mime_type).and_return('application/pdf')
       @object.extract_content
       @object.full_text.content.should include('Hello World')
     end

     #let(:user) { FactoryGirl.create(:user) }
     #let(:file) { Rack::Test::UploadedFile.new(Rails.root.join('../support/files/HelloWorldSample.pdf'), 'text/plain', false) }
     #let(:persisted_generic_file) {
     #  FactoryGirl.create_generic_file(:mock_curation_concern, user, file)
     #}
     #
     #it 'has file_name as its title to display' do
     #  expect(persisted_generic_file.to_s).to eq(File.basename(Rails.root.join('../support/files/HelloWorldSample.pdf')))
     #end
     #
     #it "should create new datastream with extracted text" do
     #  persisted_generic_file.full_text.content.should == 'Hello World'
     #end
  end
end
