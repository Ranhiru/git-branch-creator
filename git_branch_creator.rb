class GitBranchCreator
  def self.santizied_branch_name(user_input)
    user_input.downcase
      .strip
      .squeeze(" ")
      .gsub(" ", "-")
  end
end
