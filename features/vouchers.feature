Feature: Vouchers
  Customers can redeem vouchers

  Scenario: A customer can redeem a voucher
    Given Customer has a voucher link
    And   they visit the link for the first time
    And   they can press the redeem button
    Then  they succeed in redeeming
    Then  they revisit the voucher link a second time
    Then  they revisit the link after the redemtion window
