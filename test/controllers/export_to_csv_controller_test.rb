require 'test_helper'

class ExportToCSVControllerTest < ActionController::TestCase
  setup do
    request.env["HTTP_REFERER"] = root_path
  end

  test 'should redirect back for html request - authors' do
    get :authors, { q: { first_name_or_last_name_cont: 'Marceline' } }
    assert_redirected_to root_path
    assert_not_nil assigns(:download)
  end

  test 'should redirect back for html request - songs' do
    get :songs, { q: { title_cont: 'Tempora' } }
    assert_redirected_to root_path
    assert_not_nil assigns(:download)
  end

  test 'should render json - authors' do
    get :authors, format: :json, q: { first_name_or_last_name_cont: 'Marceline' }
    assert_response :success
    assert_not_nil JSON.parse(response.body)["id"]
  end

  test 'should render json - songs' do
    get :songs, format: :json, q: { title_cont: 'Tempora' }
    assert_response :success
    assert_not_nil JSON.parse(response.body)["id"]
  end
end