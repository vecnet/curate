require 'sufia/noid'

class DownloadsController < ApplicationController
  include Sufia::Noid # for normalize_identifier method

  def generic_file
    @generic_file ||= GenericFile.find(params[:id])
  end
  before_filter :generic_file
  prepend_before_filter :normalize_identifier, except: [:index, :new, :create]
  load_and_authorize_resource :generic_file, class: "GenericFile"

  def show
    send_data(
      generic_file.content.content,
      type: generic_file.content.mimeType,
      filename: generic_file.filename,
      disposition: 'inline'
    )
  end

end
