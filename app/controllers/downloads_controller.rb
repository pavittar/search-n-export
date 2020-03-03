class DownloadsController < ApplicationController
  def index
    @downloads = Download.order(id: :desc).page(params[:page])
  end

  def show
    download = Download.find(params[:id])

    respond_to do |f|
      f.html {
        redirect_to(root_path) and return if !download.completed? || !File.exists?(download.file)
        send_file(download.file, filename: download.filename)
      }
      f.json { render json: { status: download.status } }
    end
  end
end
