require 'net/http'
require 'json'
require 'yaml'

class JiraApi
  API_ENDPOINT = "https://digit.atlassian.net/rest/api/3/issue/"

  def initialize(credentials)
    @username = credentials["username"]
    @password = credentials["password"]
  end

  def title(jira_id)
    uri = URI(API_ENDPOINT + jira_id)
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password

    res = Net::HTTP.start(uri.hostname, uri.port, :use_ssl => true) {|http|
      http.request(req)
    }
    JSON.parse(res.body)["fields"]["summary"]
  end
end
