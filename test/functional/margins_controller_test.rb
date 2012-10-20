require 'test_helper'

class MarginsControllerTest < ActionController::TestCase
  setup do
    @margin = margins(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:margins)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create margin" do
    assert_difference('Margin.count') do
      post :create, margin: { body: @margin.body, ref: @margin.ref, user_id: @margin.user_id }
    end

    assert_redirected_to margin_path(assigns(:margin))
  end

  test "should show margin" do
    get :show, id: @margin
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @margin
    assert_response :success
  end

  test "should update margin" do
    put :update, id: @margin, margin: { body: @margin.body, ref: @margin.ref, user_id: @margin.user_id }
    assert_redirected_to margin_path(assigns(:margin))
  end

  test "should destroy margin" do
    assert_difference('Margin.count', -1) do
      delete :destroy, id: @margin
    end

    assert_redirected_to margins_path
  end
end
