And /they click on the signin link/ do
  click_link "Sign In"
end

And /they fill out the signin form/ do
  user = users(:admin)

  uri = URI.parse(current_url)
  expect(uri.path).to eq signin_path

  # Need to create users in test db
  fill_in "email",                 with: user.email
  fill_in "password",              with: "asdfasdf"

  click_button "Sign In"
end

Then /they are logged into the site/ do
  expect(page).to have_content "Welcome, David"
end

Then /they click the logout link/ do
  click_link "Sign Out"

end

Then /they are logged out of the site/ do

  # verify the session_id is nil
  uri = URI.parse(current_url)
  expect(uri.path).to eq signin_path
end


# Used for signin on other specs.
# Pretty sure there is a way to do a fast-sign in by just setting the session
And /A non-admin user signs in successfully/ do
  @user = users(:owner)
  visit signin_path
  uri = URI.parse(current_url)
  expect(uri.path).to eq signin_path

  fill_in "email",                 with: @user.email
  fill_in "password",              with: "asdfasdf"

  click_button "Sign In"

  expect(page).to have_content "Welcome, #{@user.first_name}"
end

And /An admin user signs in successfully/ do
  @user = users(:david)
  visit signin_path
  uri = URI.parse(current_url)
  expect(uri.path).to eq signin_path

  fill_in "email",                 with: @user.email
  fill_in "password",              with: "asdfasdf"

  click_button "Sign In"

  expect(page).to have_content "Welcome, #{@user.first_name}"
end
