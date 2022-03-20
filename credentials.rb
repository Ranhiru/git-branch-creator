require 'yaml'

class Credentials

  def self.read_credentials
    file_path = File.join(Dir.home, "git_branch_creator.yml")
    YAML.load(File.open(file_path).read)
  end
end
