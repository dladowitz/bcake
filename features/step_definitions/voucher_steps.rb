Given /Customer has a voucher link/ do
  voucher = vouchers(:voucher1)
  visit voucher_path(voucher.token)
end


Then  /they can press the redeem button the first time/ do
end


Then  /they succeed in redeeming/ do
end


And   /they click the link again after the expiration time/ do
end


Then  /they cannot redeem again/ do
end
