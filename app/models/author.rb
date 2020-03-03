class Author < ActiveRecord::Base
  has_many :songs

  validates :first_name, :last_name, presence: true

  def name
    [first_name, last_name].compact.join(' ')
  end
end