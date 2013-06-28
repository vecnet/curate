require 'sufia/noid'

class DownloadsController < ApplicationController
  include Sufia::Noid # for normalize_identifier method

  def generic_file
    @generic_file ||= GenericFile.find(params[:id])
  end
  before_filter :generic_file
  prepend_before_filter :normalize_identifier, except: [:index, :new, :create]

  def show
    authorize!(:show, generic_file)
    send_content (generic_file)
  end

  protected
  def send_content (asset)
    opts = {}
    ds = nil
    opts[:filename] = params["filename"] || asset.label
    opts[:disposition] = 'inline'
    if params.has_key?(:datastream_id)
      opts[:filename] = params[:datastream_id]
      ds = asset.datastreams[params[:datastream_id]]
    end
    ds = asset.content.content if ds.nil?
    raise ActionController::RoutingError.new('Not Found') if ds.nil?
    data = ds.content
    opts[:type] = ds.mimeType
    send_data data, opts
    return
  end
end
