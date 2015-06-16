Given /Customer has a voucher link/ do
  @voucher = vouchers(:voucher1)
end

And   /they visit the link for the first time/ do
  visit voucher_path(@voucher.token)
end

And   /they can press the redeem button/ do
  click_button "Redeem Now"
end

Then  /they succeed in redeeming/ do
  expect(page).to have_content "Show this at the register"
end

Then  /they revisit the voucher link a second time/ do
  @voucher.update_attributes(redeemed: 2.days.ago)
  visit voucher_path(@voucher.token)
  expect(page).not_to have_content "Redeem Now"
end

Then  /they revisit the link after the redemtion window/ do
  expect(page).to have_content "Sorry"
end
