require "test_helper"

class DentistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @dentist = dentists(:one)
  end

  test "should get index" do
    get dentists_url, as: :json
    assert_response :success
  end

  test "should create dentist" do
    assert_difference("Dentist.count") do
      post dentists_url, params: { dentist: { email_address: @dentist.email_address, first_name: @dentist.first_name, last_name: @dentist.last_name, middle_name: @dentist.middle_name, password_digest: @dentist.password_digest } }, as: :json
    end

    assert_response :created
  end

  test "should show dentist" do
    get dentist_url(@dentist), as: :json
    assert_response :success
  end

  test "should update dentist" do
    patch dentist_url(@dentist), params: { dentist: { email_address: @dentist.email_address, first_name: @dentist.first_name, last_name: @dentist.last_name, middle_name: @dentist.middle_name, password_digest: @dentist.password_digest } }, as: :json
    assert_response :success
  end

  test "should destroy dentist" do
    assert_difference("Dentist.count", -1) do
      delete dentist_url(@dentist), as: :json
    end

    assert_response :no_content
  end
end
