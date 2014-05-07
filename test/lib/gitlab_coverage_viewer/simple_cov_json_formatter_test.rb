require 'test_helper'

module GitlabCoverageViewer
  module CoverageFormatter
    class SimpleCovJsonFormatterTest < ActiveSupport::TestCase
      test "should be able to parse json format of simplecov" do
        response_mock = mock(headers: {"Content-Type" => "application/json" })
        project_mock = mock(coverage_base_path: "/path/to/workspace/")
        path = "path/to/sample_controller.rb"
        sample_hash = {
          "files" => [
            {
              "filename" => "/path/to/workspace/path/to/sample_controller.rb",
              "coverage" => [1,nil,nil,1,nil]
            },{
              "filename" => "/path/to/workspace/hogehoge/hugahuga/example_controller.rb",
              "coverage" => [1,nil,1,nil,1,1,1,nil,1,nil,nil,1,1,2,2,1,nil,nil,nil]
            }
          ]
        }
        response_mock.stubs(:body).returns(sample_hash.to_json)
        result = GitlabCoverageViewer::CoverageFormatter::SimpleCovJsonFormatter.parse response_mock, project_mock, path
        assert_equal result, [1,nil,nil,1,nil]
      end

      test "#desc should output 'Rails/SimpleCov/Json'" do
        assert_equal GitlabCoverageViewer::CoverageFormatter::SimpleCovJsonFormatter.desc, "Rails/SimpleCov/Json"
      end
    end
  end
end