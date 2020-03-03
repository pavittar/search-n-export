require 'test_helper'

class AuthorTest < ActiveSupport::TestCase
  test "should not persist without first_name and last_name" do
    author = Author.create
    assert_not author.valid?
    assert_includes author.errors.full_messages, %q{First name can't be blank}
    assert_includes author.errors.full_messages, %q{Last name can't be blank}
  end

  test "should persist" do
    author = Author.create(first_name: 'First', last_name: 'Last')
    assert author.persisted?
  end

  test 'should have name' do
    assert authors(:one).respond_to? :name
    assert_equal 'Marceline Mayert', authors(:one).name
  end
end
