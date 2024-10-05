require "application_system_test_case"

class UserProfilesTest < ApplicationSystemTestCase
  setup do
    @user_profile = user_profiles(:one)
  end

  test "visiting the index" do
    visit user_profiles_url
    assert_selector "h1", text: "User profiles"
  end

  test "should create user profile" do
    visit user_profiles_url
    click_on "New user profile"

    fill_in "Auth level", with: @user_profile.auth_level
    fill_in "Contact no", with: @user_profile.contact_no
    fill_in "Details", with: @user_profile.details
    fill_in "Email", with: @user_profile.email
    fill_in "Name", with: @user_profile.name
    fill_in "Role", with: @user_profile.role
    fill_in "Uin", with: @user_profile.uin
    fill_in "User", with: @user_profile.user_id
    click_on "Create User profile"

    assert_text "User profile was successfully created"
    click_on "Back"
  end

  test "should update User profile" do
    visit user_profile_url(@user_profile)
    click_on "Edit this user profile", match: :first

    fill_in "Auth level", with: @user_profile.auth_level
    fill_in "Contact no", with: @user_profile.contact_no
    fill_in "Details", with: @user_profile.details
    fill_in "Email", with: @user_profile.email
    fill_in "Name", with: @user_profile.name
    fill_in "Role", with: @user_profile.role
    fill_in "Uin", with: @user_profile.uin
    fill_in "User", with: @user_profile.user_id
    click_on "Update User profile"

    assert_text "User profile was successfully updated"
    click_on "Back"
  end

  test "should destroy User profile" do
    visit user_profile_url(@user_profile)
    click_on "Destroy this user profile", match: :first

    assert_text "User profile was successfully destroyed"
  end
end
