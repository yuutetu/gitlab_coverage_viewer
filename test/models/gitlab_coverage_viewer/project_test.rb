require 'test_helper'

module GitlabCoverageViewer
  class ProjectTest < ActiveSupport::TestCase
    def test_get_coverage_url
      commit_id = "23748"
      project = Project.new
      project.stubs(:coverage_url).returns("http://hoge.org/path/to/{commit_id}/coverage.json")
      meta_url = project.coverage_url_with_commit_id commit_id
      assert_equal "http://hoge.org/path/to/23748/coverage.json", meta_url
    end
  end
end
