class Download < ActiveRecord::Base
  Storage = Rails.root.join('storage')

  enum kind: { csv: 0 }.freeze
  enum status: { pending: 0, completed: 1, failed: 2 }.freeze

  validates :kind, :status, presence: true

  class << self
    def create_pending(kind, filename)
      create(status: :pending, kind: kind, filename: filename)
    end
  end

  def save_content(content)
    case self.kind
      when 'csv'
        name = "#{SecureRandom.hex}.csv"
        File.write(Storage.join(name), content)
        self.update_attributes(status: :completed, path: name)
    end
  end

  def file
    Storage.join(path)
  end
end