require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test 'home action' do
    get :home
    assert_response :success
    assert_not_nil assigns(:songs)
    assert_not_nil assigns(:authors)
    assert_not_nil assigns(:q1)
    assert_not_nil assigns(:q2)
  end

  test 'authors search' do
    get :home, q2: { first_name_or_last_name_cont: 'Marceline' }
    assert_response :success
    assert_equal 1, assigns(:authors).length
  end

  test 'songs search' do
    get :home, q1: { title_cont: 'Tempora' }
    assert_response :success
    assert_equal 1, assigns(:songs).length

    get :home, q1: { author_first_name_or_author_last_name_cont: 'Marceline' }
    assert_equal 2, assigns(:songs).length
  end
end