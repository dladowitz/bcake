Given /Customer visits a location show page/ do
  location = Location.first
  visit "/#{location.id}"
end

And   /they fill out the email-birthday form/ do
  fill_in "customer_email", with: "misha@tradecraft.com"
  fill_in "customer_birthday", with: "01-01-1992"
  click_button "Sign Up"
end

Then  /they are shown a confirmation screen/ do
  expect(page).to have_content "Thanks for signing up with Jackson Place Cafe"
end

And   /they can click on a new location/ do
  expect(page).to have_content "Yo Yo's"
  click_link "Yo Yo's"
end

And   /they can sign up for the new location/ do
  fill_in "customer_email", with: "misha@tradecraft.com"
  fill_in "customer_birthday", with: "01-01-1992"
  click_button "Sign Up"
end

And   /they see the confirmation page again/ do
  expect(page).to have_content "Thanks for signing up with Yo Yo's"
end
