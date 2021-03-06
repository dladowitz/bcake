Then /they visit the new user page/ do
  visit new_user_path
end

Then /they fill out the new user form/ do
  uri = URI.parse(current_url)
  expect(uri.path).to eq new_user_path

  fill_in "user_first_name",            with: "Andre"
  fill_in "user_email",                 with: "Andre.Ampere@gmail.com"
  fill_in "user_password",              with: "asdfasdf"
  fill_in "user_password_confirmation", with: "asdfasdf"

  click_button "Sign Up"
end

And /they see the user homepage/ do
  uri = URI.parse(current_url)

  # TODO create a current_user method. Doesn't seem to have access to rpsec or application controller
  # expect(uri.path).to eq user_path(current_user)
  expect(page).to have_content "Account created successfully. Lets get some more customers!"
end
