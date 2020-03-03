require 'test_helper'

class DownloadsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:downloads)
  end

  test "should not show download" do
    get :show, id: downloads(:one)
    assert_response 302
  end

  test "should show download" do
    File.write(Download::Storage.join(downloads(:two).path), 'a,b,c')
    get :show, id: downloads(:two)
    assert_response :success
    File.delete(Download::Storage.join(downloads(:two).path))
  end
end
