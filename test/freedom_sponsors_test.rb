require File.expand_path('../helper', __FILE__)

class FreedomSponsorsTest < Service::TestCase
  def setup
    @stubs = Faraday::Adapter::Test::Stubs.new
  end

  def data
    {
      'token' => '5373dd4a3648b88fa9acb8e46ebc188a'
    }
  end

  def test_require_token
    svc = service :push, {}, payload
    assert_raises Service::ConfigurationError do
      svc.receive_event
    end
  end

  def test_commit_comment
    post_to_service :commit_comment
  end

  def test_create
    post_to_service :create
  end

  def test_delete
    post_to_service :delete
  end

  def test_deployment
    post_to_service :deployment
  end

  def test_deployment_status
    post_to_service :deployment_status
  end

  def test_fork
    post_to_service :fork
  end

  def test_gollum
    post_to_service :gollum
  end

  def test_issue_comment
    post_to_service :issue_comment
  end

  def test_issues
    post_to_service :issues
  end

  def test_member
    post_to_service :member
  end

  def test_public
    post_to_service :public
  end

  def test_pull_request
    post_to_service :pull_request
  end

  def test_pull_request_review_comment
    post_to_service :pull_request_review_comment
  end

  def test_push
    post_to_service :push
  end

  def test_release
    post_to_service :release
  end

  def test_status
    post_to_service :status
  end

  def test_team_add
    post_to_service :team_add
  end

  def test_watch
    post_to_service :watch
  end

  def post_to_service(event_name)
    @stubs.post "/github-hook/#{data['token']}" do |env|
      assert_match "http://freedomsponsors.org/github-hook/", env[:url].to_s
      [200, {}, '']
    end

    svc = service event_name, data, payload
    svc.receive_event
    assert_equal data['token'], svc.data['token']
  end

  def service(*args)
    super Service::FreedomSponsors, *args
  end
end
