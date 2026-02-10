# frozen_string_literal: true

require 'net/http'
require 'json'

class JiraApi
  def initialize(config)
    @username = config["username"]
    @password = config["password"]
    @api_host = config["apiHost"]
  end

  def card_details(jira_id)
    fields = issue_fields(jira_id)
    {
      title: fields["summary"],
      issue_type: fields.dig("issuetype", "name")
    }
  end

  def title(jira_id)
    card_details(jira_id)[:title]
  end

  private

  def issue_fields(jira_id)
    uri = URI("#{@api_host}/rest/api/2/issue/#{jira_id}")
    req = Net::HTTP::Get.new(uri)
    req.basic_auth @username, @password

    res = Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(req)
    end

    unless res.is_a?(Net::HTTPSuccess)
      raise "JIRA request failed for #{jira_id}: HTTP #{res.code}"
    end

    body = JSON.parse(res.body)
    body.fetch("fields")
  end
end
