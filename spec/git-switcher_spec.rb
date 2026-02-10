require "rspec"
require "stringio"
load File.expand_path("../git-branch-creator", __dir__)
require_relative "../utils"

describe "GitBranchCreator" do
  describe ".sanitize_branch_name" do
    shared_examples_for "sanitized branch name" do |input, expected_result|
      it "returns a sanitized branch name" do
        expect(Utils.sanitize_branch_name(input)).to eq expected_result
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
      it_behaves_like "sanitized branch name", expectation[0], expectation[1]
    end
  end

  describe ".default_prefix_for_issue_type" do
    it "returns fix/ for bug" do
      expect(default_prefix_for_issue_type("bug")).to eq("fix/")
    end

    it "returns chore/ for task" do
      expect(default_prefix_for_issue_type("task")).to eq("chore/")
    end

    it "returns feat/ for story" do
      expect(default_prefix_for_issue_type("story")).to eq("feat/")
    end

    it "falls back to feat/ for unknown issue type" do
      expect(default_prefix_for_issue_type("spike")).to eq("feat/")
    end
  end

  describe ".select_branch_prefix" do
    around do |example|
      original_stdin = $stdin
      $stdin = StringIO.new(input)
      example.run
      $stdin = original_stdin
    end

    context "when no selection is entered" do
      let(:input) { "\n" }

      it "uses the provided default prefix" do
        expect(select_branch_prefix("fix/")).to eq("fix/")
      end
    end

    context "when an explicit valid selection is entered" do
      let(:input) { "3\n" }

      it "uses the chosen prefix instead of default" do
        expect(select_branch_prefix("fix/")).to eq("chore/")
      end
    end

    context "when none is selected" do
      let(:input) { "5\n" }

      it "returns an empty prefix" do
        expect(select_branch_prefix("feat/")).to eq("")
      end
    end

    context "when an invalid selection is entered" do
      let(:input) { "9\n" }

      it "exits with status 1" do
        expect { select_branch_prefix("feat/") }.to raise_error(SystemExit) do |error|
          expect(error.status).to eq(1)
        end
      end
    end
  end
end
