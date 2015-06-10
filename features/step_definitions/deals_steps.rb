And   /they view a location/ do
  visit user_locations_path
  click_link "Brioche Bakery"
end

Then  /they create a deal/ do
  click_link "Create Deal"
  fill_in "Birthday Deal", with: "Free Panini"
  fill_in "Monthly Deal", with: "50% off a single item"
  click_button "Create Deal"
  expect(page).to have_content "Woot! Deal successfully created."
end
