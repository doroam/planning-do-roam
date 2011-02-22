require 'test_helper'

class GroupsControllerTest < ActionController::TestCase
  setup do
    @group = groups(:firstGroup)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create group" do
    assert_difference('Group.count') do
      post :create, :group => @group.attributes
    end

    assert_redirected_to "/studi_groups_view_url"
  end

  test "should show group" do
    get :show, :id => @group.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @group.to_param
    assert_response :success
  end

  test "should update group as professor" do
    user = User.new(:name=> "TestUser", :login => "TestUser", :is_professor=>true)
    user.save
    if user.id != nil
      @request.session[:login_user_id] = user.id
    
      put :update, :id => @group.to_param, :group => @group.attributes
      assert_redirected_to professor_view_path(assigns(:professor_view))
    else 
      assert false, "Could not create user - user.id == nil!"
    end
  end

  #TODO o.g Testfall mit session, wo Benutzer student ist -> weiterleitung auf :users

  test "should destroy group" do
    assert_difference('Group.count', -1) do
      delete :destroy, :id => @group.to_param
    end

    assert_redirected_to groups_path
  end
end
