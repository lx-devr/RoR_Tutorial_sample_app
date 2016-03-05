require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:michael)
  end
  
  test "layout links without login" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path
    assert_select "a", {text: "Profile", count: 0}
    assert_select "a", {text: "Settings", count: 0}
    assert_select "a[href=?]", users_path, count: 0
    assert_select "a[href=?]", logout_path, count: 0
  end

  test "layout links after login" do
    log_in_as(@user)
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", users_path
    # assert_select "a[href=?]", @current_user #profile
    # assert_select "a[href=?]", edit_user_path(@current_user) #settings
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
    assert_select "a[href=?]", login_path, count: 0
  end
end
