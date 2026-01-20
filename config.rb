require 'yaml'

class Config

  def self.read_config
    file_path = File.join(Dir.home, "git_branch_creator.yml")

    mode = File.stat(file_path).mode & 0777
    if (mode & 0077) != 0
      STDERR.puts "Error: #{file_path} has insecure permissions."
      STDERR.puts "Run 'chmod 600 #{file_path}' to fix."
      exit 1
    end

    YAML.load(File.open(file_path).read)
  end
end
