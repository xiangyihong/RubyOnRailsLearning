require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test "should get home" do
    basic_page_test(:home)
  end

  test "should get help" do
    basic_page_test(:help)
  end

  test "should get about" do
    basic_page_test(:about)
  end

  test "should get contact" do
    basic_page_test(:contact)
  end

  def basic_page_test(page)
    # page should be a symbol
    raise TypeError.new('Should pass Symbol') unless page.is_a? Symbol
    get page
    assert_response :success
    assert_select 'title', "#{page.to_s.capitalize} | Ruby on Rails Learning"
  end

end
