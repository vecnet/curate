module CurationConcern
  module WithFullText
    extend ActiveSupport::Concern

    included do
      has_file_datastream "full_text", versionable: false
    end

    def extract_content
      puts "begin content extraction"
      #begin
        url = Blacklight.solr_config[:url] ? Blacklight.solr_config[:url] : Blacklight.solr_config["url"] ? Blacklight.solr_config["url"] : Blacklight.solr_config[:fulltext] ? Blacklight.solr_config[:fulltext]["url"] : Blacklight.solr_config[:default]["url"]
        uri = URI(url+'/update/extract?extractOnly=true&wt=ruby&extractFormat=text')
        puts "Uri: #{uri.inspect}, host:#{uri.host}, port:#{uri.port}"
        req = Net::HTTP.new(uri.host, uri.port)
        resp = req.post(uri.to_s, self.content.content, {'Content-type'=>self.mime_type+';charset=utf-8', "Content-Length"=>"#{self.content.content.size}" })
        puts "Response from solr: #{resp.body.inspect}"
        extracted_text = eval(resp.body)[""].rstrip
        #extracted_text = JSON.parse(resp.body)[""].rstrip
        puts "Text from pdf: #{extracted_text}"
        full_text.content = extracted_text if extracted_text.present?
      #rescue Exception => e
      #  logger.warn ("Rescued exception while extracting content for #{self.pid}: #{e.inspect} ")
      #end
    end

  end
end
