require "rspec"
require_relative "../git_branch_creator"

describe "GitBranchCreator" do
  shared_examples_for "Sanitized Branch Name" do |input, expected_result|
    it "will return a sanitized branch name" do
      expect(GitBranchCreator.sanitized_branch_name(input)).to eq expected_result
    end
  end

  [
    ["Test", "test"],
    ["Test123", "test123"],
    ["Test 123", "test-123"],
    ["Test 123", "test-123"],
    ["Random &@!@) [Symbol] Testing #1121 \"/ Mock @#* Test", "random-symbol-testing-1121-mock-test"],
    ["BE - Checkout/Consumer portal/Admin portal - Support VISA", "be-checkout-consumer-portal-admin-portal-support-visa"],
    ["JIRA 12212 FE - Consumer Portal - Pay now/Payment methods/Order details", "jira-12212-fe-consumer-portal-pay-now-payment-methods-order-details"],
    ["JIRA-9830 - Upgrade Google Maps", "jira-9830-upgrade-google-maps"],
    ["FE - Mobile Verification - Auto Continue", "fe-mobile-verification-auto-continue"],
    ["Display App Banner [WAITING ON UK mobile app release]", "display-app-banner-waiting-on-uk-mobile-app-release"],
    ["API v1: Use order search", "api-v1-use-order-search"],
    ["Testing X4232 (For Fast Search)", "testing-x4232-for-fast-search"],
    ["Upgrade test #1 __TEST__", "upgrade-test-1-test"],
    ["Hide \"In-Store\" Link", "hide-in-store-link"],
    ["Remove obsolete JIRA-2323 work", "remove-obsolete-jira-2323-work"],
    ["Automate TC#23323 Login", "automate-tc-23323-login"],
    ["INVALID_TXN_STATE, 'Error'", "invalid-txn-state-error"],
    ["Run Skipped 20.4 migration in sandbox/prod (for ANZ and EU)", "run-skipped-20-4-migration-in-sandbox-prod-for-anz-and-eu"]
  ].each do |expectation|
    it_behaves_like "Sanitized Branch Name", expectation[0], expectation[1]
  end
end
