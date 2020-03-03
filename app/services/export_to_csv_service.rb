require 'csv'

class ExportToCSVService
  AuthorFields = {
    'ID'          => :id,
    'Author Name' => :name,
    'Songs Count' => :songs_count,
    'Created At'  => ->(r){ r.created_at.to_s(:short) }
  }.freeze

  SongFields = {
    'ID'          => :id,
    'Title'       => :title,
    'Author Name' => ->(r){ r.author.try(:name) },
    'Year'        => :year
  }.freeze


  def self.call(relation, fields=[])
    case relation.klass.name
      when 'Author', 'Song'
        allowed_fields = const_get("#{relation.klass.name}Fields")
        fields = allowed_fields.slice(*fields).presence || allowed_fields

        to_csv(relation, fields)
      else
        raise NotImplementedError, relation.klass.name
    end
  end

  def self.to_csv(relation, fields)
    CSV.generate(headers: true) do |csv|
      csv << fields.keys

      relation.find_each do |r|
        csv << fields.values.map { |m| m.respond_to?(:call) ? m.(r) : r.send(m) }
      end
    end
  end
  private_class_method :to_csv
end