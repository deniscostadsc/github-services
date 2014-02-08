class Service::FreedomSponsors < Service
  string :token

  default_events :commit_comment, :create, :delete, :deployment,
    :deployment_status, :fork, :gollum, :issue_comment, :issues,
    :member, :public, :pull_request, :pull_request_review_comment,
    :push, :release, :status, :team_add, :watch

  url 'http://freedomsponsors.org'
  logo_url 'http://freedomsponsors.org/static/img2/fs_logo.png'

  maintained_by :github => 'deniscostadsc', :twitter => '@deniscostadsc'

  supported_by :web => 'http://freedomsponsors.org/feedback',
    :email => 'tony@freedomsponsors.org',
    :twitter => '@freedomsponsors'

  def receive_event
    raise_config_error "Missing token" if data['token'].to_s.empty?

    http.headers['Content-Type'] = 'application/json'
    http.headers['Accept'] = 'application/json'
    url = "http://freedomsponsors.org/github-hook/#{data['token']}/"
    http_post url, :payload => generate_json(payload)
  end
end