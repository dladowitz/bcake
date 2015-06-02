Given /Customer visits the locations_path/ do
  visit locations_path
end

Then  /they can see a list of locations/ do
  expect(page).to have_content "Locations"
  expect(page).to have_content "Jackson Place Cafe"
end
