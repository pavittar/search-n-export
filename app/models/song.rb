class Song < ActiveRecord::Base
  belongs_to :author, counter_cache: true

  validates :title, :author, :year, presence: true
end