Given /Customer visits the locations_path/ do
  visit locations_path
end

Then  /they can see a list of locations/ do
  expect(page).to have_content "Locations"
  expect(page).to have_content "Jackson Place Cafe"
end

Then  /they can view a single location/ do
  click_link "Jackson Place Cafe"
  expect(page).to have_content "Jackson Place Cafe"
  expect(page).to have_content "wants to give you something free on your birthday"
end

Then  /they can create a new location/ do
  click_link "Locations"
  click_link "Create New Location"
  expect(page).to have_content "New Location"
  fill_in "location_name", with: "Sugar Cafe"
  fill_in "location_img_url", with: "http://www.sugarcafesf.com/fireplace1.jpg"
  click_button "Create Location"
  expect(page).to have_content "Nice. Location Created Successfully."
end


Then  /they can view that location/ do
  visit user_locations_path
  click_link "Sugar Cafe"
  expect(page).to have_content "Location: Sugar Cafe"
end
