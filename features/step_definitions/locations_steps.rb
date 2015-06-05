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
  expect(page).to have_content "You don't have any locations yet"
  click_link "Create New Location"
  expect(page).to have_content "New Location"
  fill_in "name", with: "Sugar Cafe"
  fill_in "img_url", with: "http://www.sugarcafesf.com/fireplace1.jpg"
  click_button "Create Location"
  expect(page).to have_content "Nice. Location Created Successfully"
end



Then  /they can view that location/ do

end
