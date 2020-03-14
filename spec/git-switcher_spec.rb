require "rspec"
require_relative "../git_branch_creator"

describe "GitBranchCreator" do
  shared_examples_for "Sanitized Branch Name" do |input, expected_result|
    it "will return a sanitized branch name" do
      expect(GitBranchCreator.santizied_branch_name(input)).to eq expected_result
    end
  end

  [
    ["Test", "test"],
    ["Test123", "test123"],
    ["Test 123", "test-123"],
    ["Test 123", "test-123"]
  ].each do |expectation|
    it_behaves_like "Sanitized Branch Name", expectation[0], expectation[1]
  end
end
