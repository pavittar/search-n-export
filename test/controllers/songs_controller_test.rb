require 'test_helper'

class SongsControllerTest < ActionController::TestCase
  setup do
    @song = songs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:songs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create song" do
    assert_difference('Song.count') do
      post :create, song: { author_id: @song.author_id, title: @song.title, year: @song.year }
    end

    assert_redirected_to song_path(assigns(:song))
  end

  test "should show song" do
    get :show, id: @song
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @song
    assert_response :success
  end

  test "should update song" do
    patch :update, id: @song, song: { author_id: @song.author_id, title: @song.title, year: @song.year }
    assert_redirected_to song_path(assigns(:song))
  end

  test "should destroy song" do
    assert_difference('Song.count', -1) do
      delete :destroy, id: @song
    end

    assert_redirected_to songs_path
  end

  test 'songs search' do
    get :index, q1: { title_cont: 'Tempora' }
    assert_response :success
    assert_equal 1, assigns(:songs).length

    get :index, q1: { author_first_name_or_author_last_name_cont: 'Marceline' }
    assert_equal 2, assigns(:songs).length
  end
end