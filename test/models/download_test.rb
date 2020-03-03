require 'test_helper'

class DownloadTest < ActiveSupport::TestCase
  test "should not persist without kind status" do
    download = Download.create
    assert_not download.valid?
    assert_includes download.errors.full_messages, %q{Kind can't be blank}
    assert_includes download.errors.full_messages, %q{Status can't be blank}
  end

  test "should persist" do
    download = Download.create(
      kind: :csv,
      status: :pending,
      path: 'abc.csv',
      filename: 'author.csv'
    )
    assert download.persisted?
  end

  test "should create pending record" do
    download = Download.create_pending(:csv, 'author.csv')
    assert download.persisted?
  end

  test "should save content for pending" do
    download = Download.create_pending(:csv, 'author.csv')
    download.save_content('a,b,c')
    assert download.completed?
    assert download.path
  end

  test 'should know storage' do
    assert_not_nil Download::Storage
  end
end
