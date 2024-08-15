require 'yaml'

class Config

  def self.read_config
    file_path = File.join(Dir.home, "git_branch_creator.yml")
    YAML.load(File.open(file_path).read)
  end
end
