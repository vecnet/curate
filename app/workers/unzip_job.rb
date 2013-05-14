require Sufia::Engine.root.join('lib/sufia/jobs/unzip_job')

class UnzipJob
  def run
      zip_file = GenericFile.find(pid)
    Zip::Archive.open_buffer(zip_file.content.content) do |archive|
      archive.each do |f|
        generic_file = GenericFile.new
        generic_file.batch_id = zip_file.batch.pid
        generic_file.file=f
        file_name = f.name
        mime_types = MIME::Types.of(file_name)
        mime_type = mime_types.empty? ? "application/octet-stream" : mime_types.first.content_type
        options = {:label=>file_name, :dsid=>'content', :mimeType=>mime_type}
        generic_file.add_file_datastream(f.read, options)
        generic_file.set_title_and_label( file_name, :only_if_blank=>true )
        generic_file.apply_depositor_metadata(zip_file.edit_users.first)
        generic_file.apply_depositor_roles(User.from_url_component(zip_file.edit_users.first))
        generic_file.rights = zip_file.rights
        generic_file.creator = zip_file.creator
        generic_file.tag = zip_file.tag
        generic_file.date_uploaded = Time.now.ctime
        generic_file.date_modified = Time.now.ctime
        generic_file.save
      end
    end
  end
end
