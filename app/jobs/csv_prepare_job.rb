class CSVPrepareJob < ActiveJob::Base
  queue_as :default

  class << self
    def download_later(type, search_params, fields)
      download = Download.create_pending(:csv, "#{type.downcase.pluralize}.csv")
      self.perform_later(type, search_params, fields, download)
      download
    end
  end

  def perform(type, search_params, fields, download)
    content = ExportToCSVService.call(relation, fields)
    download.save_content(content)
  end

private
  def relation
    type, search_params = self.arguments
    relation = type.constantize.ransack(search_params).result
    relation = relation.includes(:author) if type == 'Song'
    relation
  end
end