require 'test_helper'

class CSVPrepareJobTest < ActiveJob::TestCase
  test "enqueued jobs" do
    CSVPrepareJob.download_later('Author', nil, nil)

    assert_enqueued_jobs 1
    clear_enqueued_jobs
    assert_enqueued_jobs 0
  end

  test "return download object" do
    download = CSVPrepareJob.download_later('Author', nil, nil)

    assert_not_nil download
    assert_not_nil download.id
    assert download.pending?
    assert download.csv?
  end

  test 'perform' do
    assert_performed_jobs 0
    download = Download.create_pending(:csv, "author.csv")

    perform_enqueued_jobs do
      CSVPrepareJob.perform_later('Author', nil, nil, download)
    end

    assert_performed_jobs 1
  end

  test 'perform and update download' do
    download = Download.create_pending(:csv, "author.csv")

    perform_enqueued_jobs do
      CSVPrepareJob.perform_later('Author', nil, nil, download)
    end
    download.reload
    assert download.completed?
    assert File.file?(download.file)
  end
end