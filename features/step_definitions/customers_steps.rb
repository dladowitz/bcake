Given /Customer visits a location show page/ do
  visit "/1"
end

And   /they fill out the email-birthday form/ do
  fill_in "customer_email", with: "misha@tradecraft.com"
  fill_in "customer_birthday", with: 35.years.ago
  click_button "Sign Up"
end

Then  /they are shown a confirmation screen/ do
  expect(page).to have_content "Thanks for signing up with Jackson Place Cafe"
end

And   /they can click on a new location/ do
end

And   /they can sign up for the new location/ do
end

And   /they see the confirmation page again/ do
end
