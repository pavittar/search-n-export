class ExportToCSVController < ApplicationController
  def authors
    @download = CSVPrepareJob.download_later('Author', params[:q], params[:csv_fields])
    render_response
  end

  def songs
    @download = CSVPrepareJob.download_later('Song', params[:q], params[:csv_fields])
    render_response
  end

private
  def render_response
    respond_to do |f|
      f.html { redirect_to :back }
      f.json { render json: { id: @download.id } }
    end
  end
end
