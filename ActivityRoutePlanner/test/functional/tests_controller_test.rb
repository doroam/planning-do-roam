require 'test_helper'

class TestsControllerTest < ActionController::TestCase
  setup do
    @test = tests(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tests)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create test" do
    assert_difference('Test.count') do
      post :create, :test => @test.attributes
    end

    assert_redirected_to test_path(assigns(:test))
  end

  test "should show test" do
    get :show, :id => @test.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @test.to_param
    assert_response :success
  end

  test "should update test" do
    put :update, :id => @test.to_param, :test => @test.attributes
    assert_redirected_to test_path(assigns(:test))
  end

  test "should destroy test" do
    assert_difference('Test.count', -1) do
      delete :destroy, :id => @test.to_param
    end

    assert_redirected_to tests_path
  end
end
