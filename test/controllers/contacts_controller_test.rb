require "test_helper"

class ContactsControllerTest < ActionDispatch::IntegrationTest
  test "should get contact_us" do
    get contacts_contact_us_url
    assert_response :success
  end
end
