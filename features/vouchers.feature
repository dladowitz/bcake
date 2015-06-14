Feature: Vouchers
  Customers can redeem vouchers

  Scenario: A customer can redeem a voucher
    Given Customer has a voucher link
    Then  they can press the redeem button the first time
    Then  they succeed in redeeming
    And   they click the link again after the expiration time
    Then  they cannot redeem again
