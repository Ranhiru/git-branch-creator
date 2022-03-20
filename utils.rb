class Utils
  def self.sanitize_branch_name(branch_name)
    branch_name.downcase
      .gsub(/[^A-Za-z0-9]/, " ")
      .strip
      .squeeze(" ")
      .gsub(" ", "-")
  end
end
