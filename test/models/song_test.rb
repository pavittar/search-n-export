require 'test_helper'

class SongTest < ActiveSupport::TestCase
  test "should not persist without title, author, year" do
    song = Song.create
    assert_not song.valid?
    assert_includes song.errors.full_messages, %q{Title can't be blank}
    assert_includes song.errors.full_messages, %q{Author can't be blank}
    assert_includes song.errors.full_messages, %q{Year can't be blank}
  end

  test "should persist" do
    song = Song.create(
      title: 'Title',
      year: 2020,
      author: authors(:two)
    )
    assert song.persisted?
  end
end
