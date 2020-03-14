class GitBranchCreator
  def self.sanitized_branch_name(user_input)
    user_input.downcase
      .gsub(/[^A-Za-z0-9]/, " ")
      .strip
      .squeeze(" ")
      .gsub(" ", "-")
  end
end
