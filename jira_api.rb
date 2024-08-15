require 'net/http'
require 'json'
require 'yaml'

class JiraApi
  def initialize(config)
    @username = config["username"]
    @password = config["password"]
    @apiHost = config["apiHost"]
  end

  def title(jira_id)
    uri = URI(@apiHost + jira_id)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
      http.request(req)
    }

    JSON.parse(res.body)["fields"]["summary"]
  end
end
