require 'test_helper'

class AuthorsControllerTest < ActionController::TestCase
  setup do
    @author = authors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:authors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create author" do
    assert_difference('Author.count') do
      post :create, author: { first_name: @author.first_name, last_name: @author.last_name }
    end

    assert_redirected_to author_path(assigns(:author))
  end

  test "should show author" do
    get :show, id: @author
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @author
    assert_response :success
  end

  test "should update author" do
    patch :update, id: @author, author: { first_name: @author.first_name, last_name: @author.last_name }
    assert_redirected_to author_path(assigns(:author))
  end

  test "should destroy author" do
    assert_difference('Author.count', -1) do
      delete :destroy, id: @author
    end

    assert_redirected_to authors_path
  end

  # Author Export As CSV
  test 'authors search' do
    get :index, q2: { first_name_or_last_name_cont: 'Marceline' }
    assert_response :success
    assert_equal 1, assigns(:authors).length
  end
end
