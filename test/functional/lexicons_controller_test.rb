require 'test_helper'

class LexiconsControllerTest < ActionController::TestCase
  setup do
    @lexicon = lexicons(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:lexicons)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create lexicon" do
    assert_difference('Lexicon.count') do
      post :create, lexicon: { code: @lexicon.code, dictionary: @lexicon.dictionary, ipd_def: @lexicon.ipd_def, orig_word: @lexicon.orig_word, part_of_speech: @lexicon.part_of_speech, phonetic: @lexicon.phonetic, st_def: @lexicon.st_def, tdnt: @lexicon.tdnt, translit: @lexicon.translit, word_orig: @lexicon.word_orig }
    end

    assert_redirected_to lexicon_path(assigns(:lexicon))
  end

  test "should show lexicon" do
    get :show, id: @lexicon
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @lexicon
    assert_response :success
  end

  test "should update lexicon" do
    put :update, id: @lexicon, lexicon: { code: @lexicon.code, dictionary: @lexicon.dictionary, ipd_def: @lexicon.ipd_def, orig_word: @lexicon.orig_word, part_of_speech: @lexicon.part_of_speech, phonetic: @lexicon.phonetic, st_def: @lexicon.st_def, tdnt: @lexicon.tdnt, translit: @lexicon.translit, word_orig: @lexicon.word_orig }
    assert_redirected_to lexicon_path(assigns(:lexicon))
  end

  test "should destroy lexicon" do
    assert_difference('Lexicon.count', -1) do
      delete :destroy, id: @lexicon
    end

    assert_redirected_to lexicons_path
  end
end
