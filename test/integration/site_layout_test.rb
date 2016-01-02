require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "layout links" do
    selecter = "a[href=?]"
    get root_path
    assert_template 'static_pages/home'
    assert_select selecter, home_path, count: 2
    # assert_select selecter, help_path
    assert_select selecter, about_path
    # assert_select selecter, contact_path
  end
end
